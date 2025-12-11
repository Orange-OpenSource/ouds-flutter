/// @nodoc
library;

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'ouds_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class OudsLocalizationsEn extends OudsLocalizations {
  OudsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get core_common_onError_a11y => 'Is on error';

  @override
  String get core_common_selected_a11y => 'Selected';

  @override
  String get core_common_unselected_a11y => 'Unselected';

  @override
  String get core_common_loading_a11y => 'Loading';

  @override
  String get core_common_disabled_a11y => 'Disabled';

  @override
  String get core_button_icon_only_a11y => 'Icon';

  @override
  String get core_bottom_sheets_label_a11y => 'Bottom sheets';

  @override
  String get core_bottom_sheets_expanded_a11y => 'Expanded';

  @override
  String get core_bottom_sheets_collapsed_a11y => 'Collapsed';

  @override
  String get core_bottom_sheets_hint_a11y =>
      'Tap to expand or collapse the bottom sheet';

  @override
  String get core_filterChip_selected_a11y => 'Selected';

  @override
  String get core_filterChip_unselected_a11y => 'Unselected';

  @override
  String get core_filterChip_hint_unselected_a11y => 'Double-tap to unselect';

  @override
  String get core_filterChip_hint_selected_a11y => 'Double-tap to select';

  @override
  String get core_chip_chip_label_a11y => 'Chip label';

  @override
  String get core_chip_chip_icon_a11y => 'Chip icon';

  @override
  String get core_checkbox_trait_a11y => 'Checkbox';

  @override
  String get core_checkbox_checked_a11y => 'Checked';

  @override
  String get core_checkbox_unchecked_a11y => 'Unchecked';

  @override
  String get core_checkbox_indeterminate_a11y => 'Indeterminate';

  @override
  String get core_checkbox_hint_a11y => 'double tap to toggle';

  @override
  String get core_radioButton_radioButton_a11y => 'Radio button';

  @override
  String get core_link_trait_a11y => 'Link';

  @override
  String get core_inputTag_hint_a11y => 'Double-tap to delete';

  @override
  String get core_tag_tag_input_role_a11y => 'Option';

  @override
  String get core_inputTag_delete_a11y => 'Remove tag';

  @override
  String core_tag_tag_input_removed_a11y(Object label) {
    return 'Tag $label removed';
  }

  @override
  String get core_textInput_trait_a11y => 'TextField';

  @override
  String get core_password_input_hidden_a11y => 'Password hidden';

  @override
  String get core_password_input_visible_a11y => 'Password visible';

  @override
  String get core_password_input_hint_show_a11y =>
      'Double tap to show password';

  @override
  String get core_password_input_hint_hide_a11y =>
      'Double tap to hide password';

  @override
  String core_pinCodeInput_digitCode_label_a11y(Object current) {
    return 'Digit code $current';
  }

  @override
  String core_pinCodeInput_pinCode_label_a11y(Object digitsCount) {
    return 'Enter your $digitsCount-digit code';
  }

  @override
  String get core_pinCodeInput_error_a11y => 'Error: Invalid code';
}
