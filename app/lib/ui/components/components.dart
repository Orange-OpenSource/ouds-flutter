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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';

List<Component> components(BuildContext context) {
  return [
    Component(
      context.l10n.app_components_button_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_components_button.svg'),
      context.l10n.app_components_button_description_text,
      ButtonDemoScreen(),
    ),
    Component.withVariant(
      context.l10n.app_components_checkbox_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_components_checkbox.png'),
      context.l10n.app_components_checkbox_description_text,
      [
        VariantComponent(
          context.l10n.app_components_checkbox_checkbox_label,
          CheckboxDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_indeterminateCheckbox_label,
          CheckboxDemoScreen(indeterminate: true),
        ),
      ],
    ),
  ];
}
