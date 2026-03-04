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
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/chip/ouds_filter_chip.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_phone_number_input.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_core/components/form_input/password_input/ouds_password_input.dart';
import 'package:ouds_core/components/form_input/password_input/ouds_password_input_decoration.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/navigation/ouds_bottom_bar.dart';
import 'package:ouds_core/components/pin_code_input/digit_input/ouds_digit_input.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart';
import 'package:ouds_core/components/switch/ouds_switch.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/checkbox/checkbox_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_filter_demo_sreen.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_suggestion_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/component_container.dart';
import 'package:ouds_flutter_demo/ui/components/component_entities.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/password_input/password_input_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/phone_number/phone_number_input_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/text_input/text_input_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/tag/input_tag_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

List<Component> components(BuildContext context) {
  final theme = OudsTheme.of(context);
  ThemeController? themeController = Provider.of<ThemeController>(context, listen: true);

  return [
    Component(
      context.l10n.app_components_badge_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsBadge(
              label: "1",
              size: OudsBadgeSize.large,
              status: OudsBadgeStatus.negative,
            ),
          ],
        ),
      ),
      context.l10n.app_components_badge_description_text,
      BadgeDemoScreen(),
    ),
    Component(
      context.l10n.app_components_navigationBar_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsBottomBar(
              selectedIndex: 0,
              onDestinationSelected: (index) {},
              translucent: true,
              destinations: NavigationBarCustomizationUtils.buildItems(
                themeController: themeController,
              ),
            ),
          ],
        ),
      ),
      context.l10n.app_components_navigationBar_description_text,
      NavigationBarDemoScreen(),
    ),
    Component(
      context.l10n.app_components_button_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsButton(
              label: "Label",
              appearance: OudsButtonAppearance.strong,
              onPressed: () {},
            ),
            SizedBox(height: theme.spaceScheme(context).fixedSmall),
            OudsButton(
              label: "Label",
              appearance: OudsButtonAppearance.defaultAppearance,
              onPressed: () {},
            ),
          ],
        ),
      ),
      context.l10n.app_components_button_description_text,
      ButtonDemoScreen(),
    ),
    Component.withVariant(
      context.l10n.app_components_checkbox_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsCheckbox(value: true, onChanged: (newValue) {}),
            SizedBox(height: theme.spaceScheme(context).fixedSmall),
            OudsCheckbox(value: false, onChanged: (newValue) {}),
          ],
        ),
      ),
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
      context.l10n.app_components_chip_label,
      ComponentContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OudsFilterChip(label: "Label", selected: true, onSelected: (newValue) {}),
            SizedBox(width: theme.spaceScheme(context).fixedSmall),
            OudsFilterChip(label: "Label", selected: false, onSelected: (newValue) {}),
          ],
        ),
      ),
      context.l10n.app_components_chip_description_text,
      [
        VariantComponent(context.l10n.app_components_filterChip_label, ChipFilterDemoScreen()),
        VariantComponent(context.l10n.app_components_suggestionChip_label, ChipSuggestionDemoScreen()),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_divider_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsDivider.horizontal(length: 300),
          ],
        ),
      ),
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
    Component(
      context.l10n.app_components_link_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsLink(
              label: "Link",
              layout: OudsLinkLayout.next,
              onPressed: () {},
            ),
          ],
        ),
      ),
      context.l10n.app_components_link_description_text,
      LinkDemoScreen(),
    ),
    Component(
      context.l10n.app_components_passwordInput_label,
      ComponentContainer(
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(start: 20.0, end: 20.0),
          child: Center(
            child: OudsPasswordInput(
              decoration: OudsPasswordInputDecoration(
                labelText: "Password",
                helperText: "Your password must be between 8 and 20 characters long.",
              ),
            ),
          ),
        ),
      ),
      context.l10n.app_components_passwordInput_description_text,
      PasswordInputDemoScreen(),
    ),
    Component(
      context.l10n.app_components_phoneNumberInput_label,
      ComponentContainer(
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(start: 20.0, end: 20.0),
          child: Center(
            child: OudsPhoneNumberInput(
              decoration: OudsInputDecoration(labelText: "Phone number", helperText: "Include your full number without spaces.", outlined: false),
              countrySelector: CountrySelector(
                countryFilter: CountryFilter.custom,
                codes: ["fr", "tn", "us"],
              ),
            ),
          ),
        ),
      ),
      context.l10n.app_components_phoneNumberInput_description_text,
      PhoneNumberInputDemoScreen(),
    ),
    Component(
      context.l10n.app_components_pinCodeInput_label,
      ComponentContainer(
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(start: 10.0, end: 10.0),
          child: OudsPinCodeInput(
            controllers: [
              TextEditingController(text: "1"),
              TextEditingController(text: "1"),
              TextEditingController(text: "1"),
              TextEditingController(
                text: "",
              ),
              TextEditingController(text: ""),
              TextEditingController(text: ""),
            ],
            digitInputDecoration: OudsDigitInputDecoration(
              hintText: '-',
            ),
            helperText: context.l10n.app_components_pinCodeInput_helperText_description_text_6,
          ),
        ),
      ),
      context.l10n.app_components_pinCodeInput_description_text,
      PinCodeInputDemoScreen(),
    ),
    Component.withVariant(
      context.l10n.app_components_radioButton_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsRadioButton(
              value: true,
              onChanged: (newValue) {},
              groupValue: true,
            ),
            SizedBox(height: theme.spaceScheme(context).fixedSmall),
            OudsRadioButton(
              value: false,
              onChanged: (newValue) {},
              groupValue: null,
            ),
          ],
        ),
      ),
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
      ComponentContainer(
        child: Column(
          children: [
            OudsSwitch(
              value: true,
              onChanged: (newValue) {},
            ),
            SizedBox(height: theme.spaceScheme(context).fixedSmall),
            OudsSwitch(
              value: false,
              onChanged: (newValue) {},
            ),
          ],
        ),
      ),
      context.l10n.app_components_switch_description_text,
      [
        VariantComponent(
          context.l10n.app_components_switch_switch_label,
          SwitchDemoScreen(),
        ),
        VariantComponent(
          context.l10n.app_components_switch_switchItem_label,
          SwitchButtonItemDemoScreen(),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_tag_label,
      ComponentContainer(child: OudsTag(label: context.l10n.app_components_common_label_label, status: OudsTagStatus.positive)),
      context.l10n.app_components_tag_description_text,
      [
        VariantComponent(context.l10n.app_components_tag_tag_label, TagDemoScreen()),
        VariantComponent(context.l10n.app_components_tag_inputTag_label, InputTagDemoScreen()),
      ],
    ),
    Component(
      context.l10n.app_components_textInput_label,
      ComponentContainer(
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(start: 20.0, end: 20.0),
          child: Center(
            child: OudsTextField(
              decoration: OudsInputDecoration(labelText: context.l10n.app_components_common_label_label, helperText: context.l10n.app_components_textInputHelperText_label, outlined: false),
            ),
          ),
        ),
      ),
      context.l10n.app_components_textInput_description_text,
      TextInputDemoScreen(),
    ),
    Component(
      context.l10n.app_components_topAppBar_label,
      ComponentContainer(
        child:  SizedBox(
          height: OudsTopBar.getPreferredSize(size: OudsTopBarSize.small, expandedHeight: 100).height,
          child: OudsTopBar(
            title: "Title",
            leadingActions: [
              OudsTopBarActionConfig.back(
                actionLabel: 'Label',
                onActionPressed: () {}
              )
            ],
            trailingActions: [
              OudsTopBarActionConfig.icon(
                customIcon: AppAssets.icons.assistanceTipsAndTricks(themeController),
                  onActionPressed: () {}
              )
            ],
          ),
        ),
      ),
      context.l10n.app_components_topAppBar_description_text,
      TopBarDemoScreen(),
    ),
  ];
}
