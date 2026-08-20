#!/usr/bin/env dart

/// Icon Updater Script
///
/// Updates existing icons from a Figma ZIP export.
/// Only updates icons that already exist - does NOT add new icons.
///
/// Usage: dart run app/bin/update_assets.dart <path-to-zip>
/// Exit codes: 0 = success, 1 = error
///
/// Example:
///   dart run app/bin/update_assets.dart ~/Downloads/OUDS\ Icons\ V2.3.zip

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

/// Main entry point
void main(List<String> args) async {
  if (args.isEmpty) {
    print(
      'Usage: dart run app/bin/update_assets.dart <path-to-zip>',
    );
    exit(1);
  }

  final zipFile = File(
    args.first.replaceFirst('~', Platform.environment['HOME'] ?? ''),
  );

  if (!await zipFile.exists()) {
    print('❌ Zip file not found: ${zipFile.path}');
    exit(1);
  }

  await updateExistingIcons(zipFile);
}

/// Extracts ZIP and updates existing icons from app/assets/ and theme packages
Future<void> updateExistingIcons(File zipFile) async {
  print('📦 Updating icons from: ${zipFile.path}\n');

  final tempDir = Directory.systemTemp.createTempSync('ouds-icons-');
  try {
    // Step 1: Extract ZIP
    print('📂 Extracting ZIP...');
    final archive = ZipDecoder().decodeBytes(zipFile.readAsBytesSync());
    for (final file in archive) {
      if (!file.isFile) continue;
      final outputFile = File(path.join(tempDir.path, file.name));
      outputFile.parent.createSync(recursive: true);
      outputFile.writeAsBytesSync(file.content as List<int>);
    }
    print('✅ Extraction complete\n');

    // Step 2: Find ZIP root directory
    final matchingDirs = Directory(tempDir.path)
        .listSync()
        .whereType<Directory>()
        .where((d) => RegExp(r'OUDS Icons V').hasMatch(d.path));

    if (matchingDirs.isEmpty) {
      print('❌ No OUDS Icons directory found in ZIP');
      exit(1);
    }

    final sourceDir = matchingDirs.first;

    // Step 3: Collect all existing icon paths from target directories
    final existingIconPaths =
        <String, String>{}; // lowerPath -> absoluteTargetPath

    // Scan app/assets/ (has theme subfolders: orange, sosh, wireframe, orange_compact)
    for (final theme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
      final themeDir = Directory(path.join('app/assets', theme));
      if (themeDir.existsSync()) {
        for (final file
            in themeDir.listSync(recursive: true).whereType<File>()) {
          if (file.path.endsWith('.svg')) {
            final relativePath = path.relative(file.path, from: themeDir.path);
            existingIconPaths[relativePath.toLowerCase()] = file.path;
          }
        }
      }
    }

    // Scan theme packages (no theme subfolder - icons are directly in assets/)
    final themePackages = [
      'ouds_theme_orange',
      'ouds_theme_sosh',
      'ouds_theme_wireframe',
      'ouds_theme_orange_compact',
    ];

    for (final package in themePackages) {
      final packageAssetsDir = Directory('$package/assets');
      if (!packageAssetsDir.existsSync()) continue;

      for (final file
          in packageAssetsDir.listSync(recursive: true).whereType<File>()) {
        if (file.path.endsWith('.svg')) {
          final relativePath = path.relative(
            file.path,
            from: packageAssetsDir.path,
          );
          existingIconPaths[relativePath.toLowerCase()] = file.path;
        }
      }
    }

    print('📋 Found ${existingIconPaths.length} existing icon files\n');

    // Step 4: Update only existing icons from ZIP
    print('📝 Updating existing icons...');
    int updatedCount = 0;

    for (final theme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
      final themeDir = Directory(path.join(sourceDir.path, theme));
      if (!themeDir.existsSync()) continue;

      for (final file in themeDir.listSync(recursive: true).whereType<File>()) {
        if (!file.path.endsWith('.svg')) continue;

        final relativePath = path.relative(file.path, from: themeDir.path);
        final lowerPath = relativePath.toLowerCase();

        // Only update if icon already exists in target directories
        if (existingIconPaths.containsKey(lowerPath)) {
          final targetPath = existingIconPaths[lowerPath]!;
          final targetFile = File(targetPath);
          targetFile.parent.createSync(recursive: true);
          targetFile.writeAsBytesSync(file.readAsBytesSync());
          updatedCount++;
        }
      }
    }
    print('✅ Updated $updatedCount existing icons\n');

    // Step 5: Collect all available icons from ZIP for verification
    final availableIconPaths = <String>{};
    for (final theme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
      final themeDir = Directory(path.join(sourceDir.path, theme));
      if (!themeDir.existsSync()) continue;

      for (final file in themeDir.listSync(recursive: true).whereType<File>()) {
        if (file.path.endsWith('.svg')) {
          availableIconPaths.add(
            path.relative(file.path, from: themeDir.path).toLowerCase(),
          );
        }
      }
    }

    print('📊 Found ${availableIconPaths.length} icons in ZIP\n');

    // Step 6: Read defined icons from app_assets.dart for verification
    final appAssetsPath = 'ouds_core/lib/components/utilities/app_assets.dart';
    final definedIconPaths = <String>{};
    if (File(appAssetsPath).existsSync()) {
      final content = File(appAssetsPath).readAsStringSync();
      final iconRegex = RegExp(
        r"final String (\w+)\s*=\s*'assets/(.+?)';",
        multiLine: true,
      );

      definedIconPaths.addAll(
        iconRegex.allMatches(content).map((m) => m.group(2)!),
      );
      print(
        '📄 Found ${definedIconPaths.length} icon definitions in app_assets.dart',
      );
    }

    // Step 7: Compare and report missing icons
    final missingIcons = <String>[];
    for (final iconPath in definedIconPaths) {
      if (!availableIconPaths.contains(iconPath.toLowerCase())) {
        missingIcons.add(iconPath);
      }
    }

    print('═══════════════════════════════════════════════════════════');
    print('SUMMARY');
    print('═══════════════════════════════════════════════════════════');
    print('✅ Updated $updatedCount existing icons');
    if (missingIcons.isEmpty) {
      print('✅ All ${definedIconPaths.length} defined icons found in ZIP');
    } else {
      print(
        '⚠️  Missing ${missingIcons.length} of ${definedIconPaths.length} defined icons:',
      );
      for (final icon in missingIcons) {
        print('   - $icon');
      }
    }
    print('═══════════════════════════════════════════════════════════');
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}