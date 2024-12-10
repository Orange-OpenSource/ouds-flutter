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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:get/get.dart';
import 'package:ouds_flutter/ui/about/detail/about_file_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!
                    .app_about_privacyPolicy_label),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Get.to(
                    AboutFileScreen(
                      title: AppLocalizations.of(context)!
                          .app_about_privacyPolicy_label,
                      fileMenuItem: 'assets/about_privacy_policy.md',
                      darkModeEnabled:
                          Theme.of(context).brightness == Brightness.light,
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!
                    .app_about_legalInformation_label),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Get.to(
                    AboutFileScreen(
                      title: AppLocalizations.of(context)!
                          .app_about_legalInformation_label,
                      fileMenuItem: 'assets/about_legal_information.md',
                      darkModeEnabled:
                          Theme.of(context).brightness == Brightness.light,
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
