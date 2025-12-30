/// @nodoc
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ouds_localizations_ar.dart';
import 'ouds_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of OudsLocalizations
/// returned by `OudsLocalizations.of(context)`.
///
/// Applications need to include `OudsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/ouds_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: OudsLocalizations.localizationsDelegates,
///   supportedLocales: OudsLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the OudsLocalizations.supportedLocales
/// property.
abstract class OudsLocalizations {
  OudsLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static OudsLocalizations? of(BuildContext context) {
    return Localizations.of<OudsLocalizations>(context, OudsLocalizations);
  }

  static const LocalizationsDelegate<OudsLocalizations> delegate =
      _OudsLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @core_common_onError_a11y.
  ///
  /// In en, this message translates to:
  /// **'Is on error'**
  String get core_common_onError_a11y;

  /// No description provided for @core_common_selected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get core_common_selected_a11y;

  /// No description provided for @core_common_unselected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Unselected'**
  String get core_common_unselected_a11y;

  /// No description provided for @core_common_loading_a11y.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get core_common_loading_a11y;

  /// No description provided for @core_common_disabled_a11y.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get core_common_disabled_a11y;

  /// No description provided for @core_common_back_a11y.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get core_common_back_a11y;

  /// No description provided for @core_button_icon_only_a11y.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get core_button_icon_only_a11y;

  /// No description provided for @core_bottom_sheets_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Bottom sheets'**
  String get core_bottom_sheets_label_a11y;

  /// No description provided for @core_bottom_sheets_expanded_a11y.
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get core_bottom_sheets_expanded_a11y;

  /// No description provided for @core_bottom_sheets_collapsed_a11y.
  ///
  /// In en, this message translates to:
  /// **'Collapsed'**
  String get core_bottom_sheets_collapsed_a11y;

  /// No description provided for @core_bottom_sheets_hint_a11y.
  ///
  /// In en, this message translates to:
  /// **'Tap to expand or collapse the bottom sheet'**
  String get core_bottom_sheets_hint_a11y;

  /// No description provided for @core_filterChip_selected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get core_filterChip_selected_a11y;

  /// No description provided for @core_filterChip_unselected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Unselected'**
  String get core_filterChip_unselected_a11y;

  /// No description provided for @core_filterChip_hint_unselected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to unselect'**
  String get core_filterChip_hint_unselected_a11y;

  /// No description provided for @core_filterChip_hint_selected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to select'**
  String get core_filterChip_hint_selected_a11y;

  /// No description provided for @core_chip_chip_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Chip label'**
  String get core_chip_chip_label_a11y;

  /// No description provided for @core_chip_chip_icon_a11y.
  ///
  /// In en, this message translates to:
  /// **'Chip icon'**
  String get core_chip_chip_icon_a11y;

  /// No description provided for @core_checkbox_trait_a11y.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get core_checkbox_trait_a11y;

  /// No description provided for @core_checkbox_checked_a11y.
  ///
  /// In en, this message translates to:
  /// **'Checked'**
  String get core_checkbox_checked_a11y;

  /// No description provided for @core_checkbox_unchecked_a11y.
  ///
  /// In en, this message translates to:
  /// **'Unchecked'**
  String get core_checkbox_unchecked_a11y;

  /// No description provided for @core_checkbox_indeterminate_a11y.
  ///
  /// In en, this message translates to:
  /// **'Indeterminate'**
  String get core_checkbox_indeterminate_a11y;

  /// No description provided for @core_checkbox_hint_a11y.
  ///
  /// In en, this message translates to:
  /// **'double tap to toggle'**
  String get core_checkbox_hint_a11y;

  /// No description provided for @core_radioButton_radioButton_a11y.
  ///
  /// In en, this message translates to:
  /// **'Radio button'**
  String get core_radioButton_radioButton_a11y;

  /// No description provided for @core_link_trait_a11y.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get core_link_trait_a11y;

  /// No description provided for @core_inputTag_hint_a11y.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to delete'**
  String get core_inputTag_hint_a11y;

  /// No description provided for @core_tag_tag_input_role_a11y.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get core_tag_tag_input_role_a11y;

  /// No description provided for @core_inputTag_delete_a11y.
  ///
  /// In en, this message translates to:
  /// **'Remove tag'**
  String get core_inputTag_delete_a11y;

  /// No description provided for @core_tag_tag_input_removed_a11y.
  ///
  /// In en, this message translates to:
  /// **'Tag {label} removed'**
  String core_tag_tag_input_removed_a11y(Object label);

  /// No description provided for @core_textInput_trait_a11y.
  ///
  /// In en, this message translates to:
  /// **'TextField'**
  String get core_textInput_trait_a11y;

  /// No description provided for @core_password_input_hidden_a11y.
  ///
  /// In en, this message translates to:
  /// **'Password hidden'**
  String get core_password_input_hidden_a11y;

  /// No description provided for @core_password_input_visible_a11y.
  ///
  /// In en, this message translates to:
  /// **'Password visible'**
  String get core_password_input_visible_a11y;

  /// No description provided for @core_password_input_hint_show_a11y.
  ///
  /// In en, this message translates to:
  /// **'Double tap to show password'**
  String get core_password_input_hint_show_a11y;

  /// No description provided for @core_password_input_hint_hide_a11y.
  ///
  /// In en, this message translates to:
  /// **'Double tap to hide password'**
  String get core_password_input_hint_hide_a11y;

  /// No description provided for @core_pinCodeInput_digitCode_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Digit code {current}'**
  String core_pinCodeInput_digitCode_label_a11y(Object current);

  /// No description provided for @core_pinCodeInput_pinCode_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Enter your {digitsCount}-digit code'**
  String core_pinCodeInput_pinCode_label_a11y(Object digitsCount);

  /// No description provided for @core_pinCodeInput_error_a11y.
  ///
  /// In en, this message translates to:
  /// **'Error: Invalid code'**
  String get core_pinCodeInput_error_a11y;

  /// No description provided for @core_topAppBar_menu_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get core_topAppBar_menu_label_a11y;

  /// No description provided for @core_topAppBar_close_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get core_topAppBar_close_label_a11y;
}

class _OudsLocalizationsDelegate
    extends LocalizationsDelegate<OudsLocalizations> {
  const _OudsLocalizationsDelegate();

  @override
  Future<OudsLocalizations> load(Locale locale) {
    return SynchronousFuture<OudsLocalizations>(
        lookupOudsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_OudsLocalizationsDelegate old) => false;
}

OudsLocalizations lookupOudsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return OudsLocalizationsAr();
    case 'en':
      return OudsLocalizationsEn();
  }

  throw FlutterError(
      'OudsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
