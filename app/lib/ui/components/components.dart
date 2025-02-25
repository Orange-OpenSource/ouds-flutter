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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';

List<Component> components(BuildContext context) {
  return [
    Component(
      AppLocalizations.of(context)!.app_components_button_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_components_button.png'),
      AppLocalizations.of(context)!.app_components_button_description_text,
      ButtonDemoScreen(),
    ),
  ];
}
