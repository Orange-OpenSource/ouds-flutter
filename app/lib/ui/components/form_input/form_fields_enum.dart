import 'package:flutter/widgets.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Enum to choose wich input type to use
enum FormFieldsTypeEnum { textInput, phoneNumberInput, passwordInput }

extension CustomLabelLayout on FormFieldsTypeEnum {
  String get labelValue {
    switch (this) {
      case FormFieldsTypeEnum.textInput:
        return "Label";
      case FormFieldsTypeEnum.phoneNumberInput:
        return "Phone number";
      case FormFieldsTypeEnum.passwordInput:
        return "Password";
    }
  }
}

extension CustomHelperLayout on FormFieldsTypeEnum {
  String get helperValue {
    switch (this) {
      case FormFieldsTypeEnum.textInput:
        return "Helper text";
      case FormFieldsTypeEnum.phoneNumberInput:
        return "Include your full number without spaces.";
      case FormFieldsTypeEnum.passwordInput:
        return "Your password must be between 8 and 20 characters long.";
    }
  }
}

/// Represents the leading icon customization option: hidden, tinted (single
/// color, following the theme color) or untinted (original, potentially
/// multi-color, asset colors). Merges presence and tinting into a single
/// selector.
enum LeadingIconOptionEnum {
  none,
  tinted,
  untinted;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_textInput_leadingIcon_label;
  }
}

extension CustomLeadingIconOption on LeadingIconOptionEnum {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case LeadingIconOptionEnum.none:
        return l10n.app_components_common_none_label;
      case LeadingIconOptionEnum.tinted:
        return l10n.app_components_common_tinted_tech;
      case LeadingIconOptionEnum.untinted:
        return l10n.app_components_common_untinted_tech;
    }
  }
}

/// Represents the trailing action customization option: hidden or tinted.
///
/// Unlike the leading icon, the trailing action is rendered through an
/// [OudsButton], whose own `tinted` handling already provides the untinted
/// (brand-background) rendering when needed, so only presence and tinted
/// states are exposed here.
enum TrailingIconOptionEnum {
  none,
  tinted;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_textInput_trailingAction_label;
  }
}

extension CustomTrailingIconOption on TrailingIconOptionEnum {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case TrailingIconOptionEnum.none:
        return l10n.app_components_common_none_label;
      case TrailingIconOptionEnum.tinted:
        return l10n.app_components_common_tinted_tech;
    }
  }
}
