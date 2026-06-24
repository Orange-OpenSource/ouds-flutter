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
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_defaults.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_theme_helper.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/chip/ouds_filter_chip.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_phone_number_input.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_core/components/form_input/password_input/ouds_password_input.dart';
import 'package:ouds_core/components/form_input/password_input/ouds_password_input_decoration.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item_data.dart';
import 'package:ouds_core/components/list_item/ouds_static_list_item.dart';
import 'package:ouds_core/components/navigation/ouds_bottom_bar.dart';
import 'package:ouds_core/components/pin_code_input/digit_input/ouds_digit_input.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart';
import 'package:ouds_core/components/switch/ouds_switch.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/alert/inline_alert_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/modal_bottom_sheet_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_demo_screen.dart';
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
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/radio_button/radio_button_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/switch/switch_item_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/tag/input_tag_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_demo_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

List<Component> components(BuildContext context) {
  final theme = OudsTheme.of(context);
  ThemeController? themeController = Provider.of<ThemeController>(
    context,
    listen: true,
  );

  return [
    Component.withVariant(
      context.l10n.app_components_alert_tech,
      ComponentContainer(
        child: OudsAlertMessage(
          label: 'Label',
          status: Positive(),
          onClose: () {},
        ),
      ),
      context.l10n.app_components_alert_description_text,
      [
        VariantComponent(
          context.l10n.app_components_alert_alertMessage_tech,
          AlertMessageDemoScreen(
            previousPageTitle: context.l10n.app_components_alert_tech,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_alert_inlineAlert_tech,
          InlineAlertDemoScreen(
            previousPageTitle: context.l10n.app_components_alert_tech,
          ),
        ),
      ],
    ),
    Component(
      context.l10n.app_components_badge_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsBadge.count(
              label: "1",
              size: OudsBadgeSize.large,
              status: Negative(),
            ),
          ],
        ),
      ),
      context.l10n.app_components_badge_description_text,
      BadgeDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
    Component.withVariant(
      context.l10n.app_components_bottomSheet_tech,
      ComponentContainer(
        child: ClipRect(
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: _BottomSheetPreview(),
          ),
        ),
      ),
      context.l10n.app_components_bottomSheet_description_text,
      [
        VariantComponent(
          context.l10n.app_components_bottomSheet_standardBottomSheet_tech,
          StandardBottomSheetDemoScreen(
            previousPageTitle: context.l10n.app_components_bottomSheet_tech,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_bottomSheet_modalBottomSheet_tech,
          ModalBottomSheetDemoScreen(
            previousPageTitle: context.l10n.app_components_bottomSheet_tech,
          ),
        ),
      ],
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
                context: context,
                themeController: themeController,
              ),
            ),
          ],
        ),
      ),
      context.l10n.app_components_navigationBar_description_text,
      NavigationBarDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
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
      ButtonDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
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
          CheckboxDemoScreen(
            previousPageTitle: context.l10n.app_components_checkbox_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_checkboxItem_label,
          ControlItemDemoScreen(
            previousPageTitle: context.l10n.app_components_checkbox_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_indeterminateCheckbox_label,
          CheckboxDemoScreen(
            indeterminate: true,
            previousPageTitle: context.l10n.app_components_checkbox_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_checkbox_indeterminateCheckboxItem_label,
          ControlItemDemoScreen(
            indeterminate: true,
            previousPageTitle: context.l10n.app_components_checkbox_label,
          ),
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
            OudsFilterChip(
              label: "Label",
              selected: true,
              onSelected: (newValue) {},
            ),
            SizedBox(width: theme.spaceScheme(context).fixedSmall),
            OudsFilterChip(
              label: "Label",
              selected: false,
              onSelected: (newValue) {},
            ),
          ],
        ),
      ),
      context.l10n.app_components_chip_description_text,
      [
        VariantComponent(
          context.l10n.app_components_filterChip_label,
          ChipFilterDemoScreen(
            previousPageTitle: context.l10n.app_components_chip_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_suggestionChip_label,
          ChipSuggestionDemoScreen(
            previousPageTitle: context.l10n.app_components_chip_label,
          ),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_divider_label,
      ComponentContainer(
        child: Column(children: [OudsDivider.horizontal(length: 300)]),
      ),
      context.l10n.app_components_divider_description_text,
      [
        VariantComponent(
          context.l10n.app_components_divider_horizontalDivider_label,
          DividerDemoScreen(
            vertical: false,
            previousPageTitle: context.l10n.app_components_divider_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_divider_verticalDivider_label,
          DividerDemoScreen(
            vertical: true,
            previousPageTitle: context.l10n.app_components_divider_label,
          ),
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
      LinkDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
    Component.withVariant(
      "List Item",
      ComponentContainer(
        child: Column(
          children: [
            OudsStaticListItem(
              data: OudsListItemData(label: "label", overline: "overline"),
              leading: OudsListItemLeadingIcon(
                Neutral(
                  icon: AppAssets.icons.assistanceTipsAndTricks(
                    themeController,
                  ),
                ),
              ),
            ),
            OudsStaticListItem(
              data: OudsListItemData(label: "label"),
              leading: OudsListItemLeadingIcon(
                Neutral(
                  icon: AppAssets.icons.assistanceTipsAndTricks(
                    themeController,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      "A list item is a horizontal row used to display a unit of information within a list.",
      [
        VariantComponent(
          "Static list item",
          StaticListItemDemoScreen(previousPageTitle: "List Item"),
        ),
      ],
    ),
    Component(
      context.l10n.app_components_passwordInput_label,
      ComponentContainer(
        child: OudsPasswordInput(
          decoration: OudsPasswordInputDecoration(
            labelText: "Password",
            helperText:
                "Your password must be between 8 and 20 characters long.",
          ),
        ),
      ),
      context.l10n.app_components_passwordInput_description_text,
      PasswordInputDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
    Component(
      context.l10n.app_components_phoneNumberInput_label,
      ComponentContainer(
        child: OudsPhoneNumberInput(
          decoration: OudsInputDecoration(
            labelText: "Phone number",
            helperText: "Include your full number without spaces.",
            outlined: false,
          ),
          countrySelector: CountrySelector(
            countryFilter: CountryFilter.custom,
            codes: ["fr", "tn", "us"],
          ),
        ),
      ),
      context.l10n.app_components_phoneNumberInput_description_text,
      PhoneNumberInputDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
    Component(
      context.l10n.app_components_pinCodeInput_label,
      ComponentContainer(
        child: OudsPinCodeInput(
          controllers: [
            TextEditingController(text: "1"),
            TextEditingController(text: "1"),
            TextEditingController(text: "1"),
            TextEditingController(text: ""),
            TextEditingController(text: ""),
            TextEditingController(text: ""),
          ],
          digitInputDecoration: OudsDigitInputDecoration(hintText: '-'),
          helperText: context
              .l10n
              .app_components_pinCodeInput_helperText_description_text_6,
        ),
      ),
      context.l10n.app_components_pinCodeInput_description_text,
      PinCodeInputDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
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
          RadioButtonDemoScreen(
            previousPageTitle: context.l10n.app_components_radioButton_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_radioButton_radioButtonItem_label,
          RadioButtonItemDemoScreen(
            previousPageTitle: context.l10n.app_components_radioButton_label,
          ),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_switch_label,
      ComponentContainer(
        child: Column(
          children: [
            OudsSwitch(value: true, onChanged: (newValue) {}),
            SizedBox(height: theme.spaceScheme(context).fixedSmall),
            OudsSwitch(value: false, onChanged: (newValue) {}),
          ],
        ),
      ),
      context.l10n.app_components_switch_description_text,
      [
        VariantComponent(
          context.l10n.app_components_switch_switch_label,
          SwitchDemoScreen(
            previousPageTitle: context.l10n.app_components_switch_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_switch_switchItem_label,
          SwitchButtonItemDemoScreen(
            previousPageTitle: context.l10n.app_components_switch_label,
          ),
        ),
      ],
    ),
    Component.withVariant(
      context.l10n.app_components_tag_label,
      ComponentContainer(
        child: OudsTag.text(
          label: context.l10n.app_components_common_label_label,
          status: Positive(),
        ),
      ),
      context.l10n.app_components_tag_description_text,
      [
        VariantComponent(
          context.l10n.app_components_tag_tag_label,
          TagDemoScreen(
            previousPageTitle: context.l10n.app_components_tag_label,
          ),
        ),
        VariantComponent(
          context.l10n.app_components_tag_inputTag_label,
          InputTagDemoScreen(
            previousPageTitle: context.l10n.app_components_tag_label,
          ),
        ),
      ],
    ),
    Component(
      context.l10n.app_components_textInput_label,
      ComponentContainer(
        child: OudsTextField(
          decoration: OudsInputDecoration(
            labelText: context.l10n.app_components_common_label_label,
            helperText: context.l10n.app_components_textInputHelperText_label,
            outlined: false,
          ),
        ),
      ),
      context.l10n.app_components_textInput_description_text,
      TextInputDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
    Component(
      context.l10n.app_components_topAppBar_label,
      ComponentContainer(
        child: SizedBox(
          height: OudsTopBar.getPreferredSize(
            size: OudsTopBarSize.small,
            expandedHeight: 100,
          ).height,
          child: OudsTopBar(
            title: "Title",
            leadingActions: [
              OudsTopBarActionConfig.back(
                previousPageTitle: 'Label',
                onActionPressed: () {},
              ),
            ],
            trailingActions: [
              OudsTopBarActionConfig.icon(
                icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
                onActionPressed: () {},
              ),
            ],
          ),
        ),
      ),
      context.l10n.app_components_topAppBar_description_text,
      TopBarDemoScreen(
        previousPageTitle: context.l10n.app_bottomBar_components_label,
      ),
    ),
  ];
}

/// A static preview of a bottom sheet for the component list.
class _BottomSheetPreview extends StatelessWidget {
  const _BottomSheetPreview();

  @override
  Widget build(BuildContext context) {
    final themeData = OudsBottomSheetThemeHelper.buildThemeData(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        elevation: themeData.elevation ?? 0,
        shape: themeData.shape,
        color: themeData.backgroundColor,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: double.infinity,
          height: 90,
          child: Column(
            children: [OudsBottomSheetDefaults.dragHandle(context)],
          ),
        ),
      ),
    );
  }
}
