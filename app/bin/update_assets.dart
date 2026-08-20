#!/usr/bin/env dart

/// Icon Updater Script
///
/// Updates existing icons from a Figma ZIP export.
/// Only updates icons that already exist - does NOT add new icons.
///
/// Theme mapping (ZIP source -> target themes):
///   - orange -> orange, orange_compact
///   - orange_compact -> orange_compact (if exists in ZIP)
///   - sosh -> sosh
///   - wireframe -> wireframe
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
    print('Usage: dart run app/bin/update_assets.dart <path-to-zip>');
    exit(1);
  }

  // Get project root (parent of app/)
  final scriptDir = path.dirname(Platform.script.toFilePath());
  final projectRoot = path.dirname(path.dirname(scriptDir));

  final zipFile = File(
    args.first.replaceFirst('~', Platform.environment['HOME'] ?? ''),
  );

  if (!await zipFile.exists()) {
    print('❌ Zip file not found: ${zipFile.path}');
    exit(1);
  }

  await updateExistingIcons(zipFile, projectRoot);
}

/// Extracts ZIP and updates existing icons from app/assets/ and theme packages
Future<void> updateExistingIcons(File zipFile, String projectRoot) async {
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
    // Map: lowerPath -> {targetTheme -> targetPath}
    // targetTheme: 'orange', 'orange_compact', 'sosh', 'wireframe'
    final existingIconPaths = <String, Map<String, String>>{};

    // Scan app/assets/ (has theme subfolders: orange, sosh, wireframe, orange_compact)
    for (final theme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
      final themeDir = Directory(path.join(projectRoot, 'app/assets', theme));
      if (themeDir.existsSync()) {
        for (final file
            in themeDir.listSync(recursive: true).whereType<File>()) {
          if (file.path.endsWith('.svg')) {
            final relativePath = path.relative(file.path, from: themeDir.path);
            final lowerPath = relativePath.toLowerCase();
            existingIconPaths.putIfAbsent(lowerPath, () => {});
            existingIconPaths[lowerPath]![theme] = file.path;
          }
        }
      }
    }

    // Scan theme packages (no theme subfolder - icons are directly in assets/)
    final themePackages = {
      'ouds_theme_orange': 'orange',
      'ouds_theme_sosh': 'sosh',
      'ouds_theme_wireframe': 'wireframe',
      'ouds_theme_orange_compact': 'orange_compact',
    };

    for (final entry in themePackages.entries) {
      final package = entry.key;
      final theme = entry.value;
      final packageAssetsDir = Directory(
        path.join(projectRoot, package, 'assets'),
      );
      if (!packageAssetsDir.existsSync()) continue;

      for (final file
          in packageAssetsDir.listSync(recursive: true).whereType<File>()) {
        if (file.path.endsWith('.svg')) {
          final relativePath = path.relative(
            file.path,
            from: packageAssetsDir.path,
          );
          final lowerPath = relativePath.toLowerCase();
          existingIconPaths.putIfAbsent(lowerPath, () => {});
          existingIconPaths[lowerPath]![theme] = file.path;
        }
      }
    }

    print('📋 Found ${existingIconPaths.length} existing icon files\n');

    // Step 4: Update only existing icons from ZIP
    // Mapping: ZIP theme -> target themes that should receive these icons
    // orange_compact gets icons from orange (not from its own folder in ZIP which doesn't exist)
    final themeMapping = {
      'orange': ['orange', 'orange_compact'],
      'sosh': ['sosh'],
      'wireframe': ['wireframe'],
      'orange_compact': ['orange_compact'], // fallback if exists in ZIP
    };

    print('📝 Updating existing icons...');
    int updatedCount = 0;

    for (final zipTheme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
      final themeDir = Directory(path.join(sourceDir.path, zipTheme));
      if (!themeDir.existsSync()) continue;

      // Get target themes for this ZIP theme
      final targetThemes = themeMapping[zipTheme] ?? [zipTheme];

      for (final file in themeDir.listSync(recursive: true).whereType<File>()) {
        if (!file.path.endsWith('.svg')) continue;

        final relativePath = path.relative(file.path, from: themeDir.path);
        final lowerPath = relativePath.toLowerCase();

        // Only update if icon already exists in target directories
        if (existingIconPaths.containsKey(lowerPath)) {
          for (final targetTheme in targetThemes) {
            if (existingIconPaths[lowerPath]!.containsKey(targetTheme)) {
              final targetPath = existingIconPaths[lowerPath]![targetTheme]!;
              final targetFile = File(targetPath);
              targetFile.parent.createSync(recursive: true);
              targetFile.writeAsBytesSync(file.readAsBytesSync());
              updatedCount++;
            }
          }
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

    // Step 8: Check all project icons vs ZIP icons
    print('\n═══════════════════════════════════════════════════════════');
    print('PROJECT ASSETS VS ZIP COMPARISON');
    print('═══════════════════════════════════════════════════════════\n');

    checkProjectIconsVsZip(projectRoot, availableIconPaths);

    print('\n═══════════════════════════════════════════════════════════');
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

/// Checks all project icons (app/assets + theme packages) against ZIP icons
/// and displays icons that exist in the project but NOT in the ZIP
void checkProjectIconsVsZip(String projectRoot, Set<String> zipIconPaths) {
  final projectIcons = <String, Set<String>>{}; // theme -> icon paths

  // Scan app/assets/ (all themes)
  for (final theme in ['orange', 'sosh', 'wireframe', 'orange_compact']) {
    final themeDir = Directory(path.join(projectRoot, 'app/assets', theme));
    if (themeDir.existsSync()) {
      projectIcons[theme] = <String>{};
      for (final file in themeDir.listSync(recursive: true).whereType<File>()) {
        if (file.path.endsWith('.svg')) {
          final relativePath = path.relative(file.path, from: themeDir.path);
          projectIcons[theme]!.add(relativePath.toLowerCase());
        }
      }
    }
  }

  // Scan theme packages
  final themePackages = {
    'ouds_theme_orange': 'orange',
    'ouds_theme_sosh': 'sosh',
    'ouds_theme_wireframe': 'wireframe',
    'ouds_theme_orange_compact': 'orange_compact',
  };

  for (final entry in themePackages.entries) {
    final package = entry.key;
    final theme = entry.value;
    final packageAssetsDir = Directory(
      path.join(projectRoot, package, 'assets'),
    );
    if (!packageAssetsDir.existsSync()) continue;

    projectIcons[theme] ??= <String>{};
    for (final file
        in packageAssetsDir.listSync(recursive: true).whereType<File>()) {
      if (file.path.endsWith('.svg')) {
        final relativePath = path.relative(
          file.path,
          from: packageAssetsDir.path,
        );
        projectIcons[theme]!.add(relativePath.toLowerCase());
      }
    }
  }

  // Compare and report missing icons per theme
  int totalMissing = 0;
  for (final theme in projectIcons.keys) {
    final themeIcons = projectIcons[theme]!;
    final missingInZip =
        themeIcons.where((icon) => !zipIconPaths.contains(icon)).toList()
          ..sort();

    if (missingInZip.isNotEmpty) {
      print('🔴 Theme "$theme" - ${missingInZip.length} icons missing in ZIP:');
      for (final icon in missingInZip) {
        print('   - $icon');
      }
      totalMissing += missingInZip.length;
    } else {
      print('✅ Theme "$theme" - All ${themeIcons.length} icons found in ZIP');
    }
  }

  if (totalMissing > 0) {
    print('\n⚠️  Total: $totalMissing icons exist in project but NOT in ZIP');
  } else {
    print('\n✅ All project icons exist in ZIP');
  }
}
