//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/lists/ouds_list_item.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_entities.dart';
import 'package:ouds_flutter_demo/ui/utilities/display_image.dart';

class TokenDetailScreen extends StatelessWidget {
  final Token token;

  const TokenDetailScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    var spacingM = 16.0;
    var spacingS = 8.0;
    return Scaffold(
      appBar: MainAppBar(title: token.title),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              displayImage(
                token.imageResourceName,
                MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.all(spacingM),
                child: Text(
                  token.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: spacingM, right: spacingM, top: spacingS, bottom: spacingS),
                child: Semantics(
                  header: true,
                  child: Text(
                    'AppLocalizations.of(context)!.tokensScreenVariantTitle',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: token.variants?.length,
                itemBuilder: (BuildContext context, int index) {
                  final variant = token.variants?[index];
                  if (variant != null) {
                    return VariantEntry(variant: variant);
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantEntry extends StatelessWidget {
  final Variant variant;

  const VariantEntry({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return OudsListItem(
      title: variant.title,
      subtitle: variant.technicalName,
      image: const Icon(Icons.play_circle_outline),
      onPressed: () {
        Get.to(variant.screen);
      },
    );
  }
}
