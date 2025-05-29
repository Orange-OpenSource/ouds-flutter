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
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

List<Component> components(BuildContext context) {
  return [
    Component(
      context.l10n.app_components_button_label,
      AdaptiveImageHelper.getImage(context, AppAssets.images.ilComponentsButton),
      context.l10n.app_components_button_description_text,
      ButtonDemoScreen(),
    ),
    Component.withVariant(
      context.l10n.app_components_checkbox_label,
      AdaptiveImageHelper.getImage(context, AppAssets.images.ilcomponentsCheckbox),
      context.l10n.app_components_checkbox_description_text,
      [
        VariantComponent(
          context.l10n.app_components_checkbox_checkbox_label,
          CheckboxDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_checkboxItem_label,
          ControlItemDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_indeterminateCheckbox_label,
          CheckboxDemoScreen(indeterminate: true),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_indeterminateCheckboxItem_label,
          ControlItemDemoScreen(indeterminate: true),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_divider_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_components_divider.svg'),
      context.l10n.app_components_divider_description_text,
      [
        VariantComponent(
          context.l10n.app_components_divider_horizontalDivider_label,
          DividerDemoScreen(vertical: false),
        ),
        VariantComponent(
          context.l10n.app_components_divider_verticalDivider_label,
          DividerDemoScreen(vertical: true),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_radioButton_label,
      AdaptiveImageHelper.getImage(context, AppAssets.images.ilComponentsRadioButton),
      context.l10n.app_components_radioButton_description_text,
      [
        VariantComponent(
          context.l10n.app_components_radioButton_radioButton_label,
          RadioButtonDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_radioButton_radioButtonItem_label,
          RadioButtonItemDemoScreen(),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_switch_label,
      AdaptiveImageHelper.getImage(context, AppAssets.images.ilComponentsSwitch),
      context.l10n.app_components_switch_description_text,
      [
        VariantComponent(
          context.l10n.app_components_switch_label,
          SwitchDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_switch_switchItem_label,
          SwitchButtonItemDemoScreen(),
        ),
      ],
    ),
  ];
}
