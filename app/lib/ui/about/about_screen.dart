/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/about/detail/about_file_screen.dart';
import 'package:ouds_flutter_demo/ui/about/material/material_component_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/environment.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // TODO: correct version package insertion
  // Package Version instantiation
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  EnvironmentType currentEnvironment = EnvironmentType.production;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initEnvironmentInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _initEnvironmentInfo() async {
    currentEnvironment = await Environment.getCurrentEnvironment();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(currentTheme.spaceTokens.scaledMediumMobile),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.app_about_name_label,
                      style: TextStyle(
                        fontSize: currentTheme.fontTokens.sizeHeadingXlargeMobile,
                        fontWeight: currentTheme.fontTokens.weightStrong,
                      ),
                    ),
                    SizedBox(height: currentTheme.spaceTokens.rowGapShort),
                    Text(
                      '${currentEnvironment.name[0].toUpperCase()}${currentEnvironment.name.substring(1)} version ${_packageInfo.version} (${_packageInfo.buildNumber}) - Flutter',
                      style: TextStyle(
                        fontSize: currentTheme.fontTokens.sizeBodyMediumMobile,
                        fontWeight: currentTheme.fontTokens.weightDefault,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(context.l10n.app_about_legalInformation_label,
                    style: TextStyle(
                      fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                      fontWeight: currentTheme.fontTokens.weightStrong,
                    )),
                onTap: () {
                  Get.to(
                    AboutFileScreen(
                      title: context.l10n.app_about_legalInformation_label,
                      fileMenuItem: 'assets/about_legal_information.md',
                      darkModeEnabled: Theme.of(context).brightness == Brightness.light,
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  context.l10n.app_about_privacyPolicy_label,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: currentTheme.fontTokens.weightStrong,
                  ),
                ),
                onTap: () {
                  Get.to(
                    AboutFileScreen(
                      title: context.l10n.app_about_privacyPolicy_label,
                      fileMenuItem: 'assets/about_privacy_policy.md',
                      darkModeEnabled: Theme.of(context).brightness == Brightness.light,
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  context.l10n.app_about_changelog_label,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: currentTheme.fontTokens.weightStrong,
                  ),
                ),
                onTap: () {
                  Get.to(
                    AboutFileScreen(
                      title: context.l10n.app_about_changelog_label,
                      fileMenuItem: 'CHANGELOG.md',
                      darkModeEnabled: Theme.of(context).brightness == Brightness.light,
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(context.l10n.app_about_materialComponents_label,
                    style: TextStyle(
                      fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                      fontWeight: currentTheme.fontTokens.weightStrong,
                    )),
                onTap: () {
                  Get.to(
                    MaterialComponentScreen(
                      scaffoldKey: scaffoldKey,
                      title: context.l10n.app_about_materialComponents_label,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
