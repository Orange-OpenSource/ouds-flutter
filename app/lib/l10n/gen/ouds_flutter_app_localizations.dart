import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ouds_flutter_app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/ouds_flutter_app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'OudsPlayground'**
  String get app_name;

  /// No description provided for @app_common_back_a11y.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get app_common_back_a11y;

  /// No description provided for @app_common_copyCode_a11y.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get app_common_copyCode_a11y;

  /// No description provided for @app_common_codeCopied_text.
  ///
  /// In en, this message translates to:
  /// **'Code copied to the clipboard'**
  String get app_common_codeCopied_text;

  /// No description provided for @app_common_collapsed_a11y.
  ///
  /// In en, this message translates to:
  /// **'Collapsed'**
  String get app_common_collapsed_a11y;

  /// No description provided for @app_common_expanded_a11y.
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get app_common_expanded_a11y;

  /// No description provided for @app_common_bottomSheetExpanded_a11y.
  ///
  /// In en, this message translates to:
  /// **'Bottom sheet expanded'**
  String get app_common_bottomSheetExpanded_a11y;

  /// No description provided for @app_common_bottomSheetCollapsed_a11y.
  ///
  /// In en, this message translates to:
  /// **'Bottom sheet collapsed'**
  String get app_common_bottomSheetCollapsed_a11y;

  /// No description provided for @app_common_customize_label.
  ///
  /// In en, this message translates to:
  /// **'Customize'**
  String get app_common_customize_label;

  /// No description provided for @app_common_enabled_label.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get app_common_enabled_label;

  /// No description provided for @app_common_onColoredBackground_label.
  ///
  /// In en, this message translates to:
  /// **'On colored background'**
  String get app_common_onColoredBackground_label;

  /// No description provided for @app_bottomBar_tokens_label.
  ///
  /// In en, this message translates to:
  /// **'Tokens'**
  String get app_bottomBar_tokens_label;

  /// No description provided for @app_bottomBar_components_label.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get app_bottomBar_components_label;

  /// No description provided for @app_bottomBar_about_label.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get app_bottomBar_about_label;

  /// No description provided for @app_components_common_layout_label.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get app_components_common_layout_label;

  /// No description provided for @app_components_common_textOnlyLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Text only'**
  String get app_components_common_textOnlyLayout_label;

  /// No description provided for @app_components_common_iconAndTextLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Icon + text'**
  String get app_components_common_iconAndTextLayout_label;

  /// No description provided for @app_components_common_style_label.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get app_components_common_style_label;

  /// No description provided for @app_components_common_text_label.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get app_components_common_text_label;

  /// No description provided for @app_components_common_onColoredBackground_label.
  ///
  /// In en, this message translates to:
  /// **'On colored background'**
  String get app_components_common_onColoredBackground_label;

  /// No description provided for @app_components_button_label.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get app_components_button_label;

  /// No description provided for @app_components_button_description_text.
  ///
  /// In en, this message translates to:
  /// **'Buttons allow users to make choices or perform an action. They have multiple styles for various needs.'**
  String get app_components_button_description_text;

  /// No description provided for @app_components_button_hierarchy_label.
  ///
  /// In en, this message translates to:
  /// **'Hierarchy'**
  String get app_components_button_hierarchy_label;

  /// No description provided for @app_components_button_iconOnlyLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Icon only'**
  String get app_components_button_iconOnlyLayout_label;

  /// No description provided for @app_components_button_icon_a11y.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get app_components_button_icon_a11y;

  /// No description provided for @app_about_name_label.
  ///
  /// In en, this message translates to:
  /// **'Design System Toolbox'**
  String get app_about_name_label;

  /// No description provided for @app_about_privacyPolicy_label.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get app_about_privacyPolicy_label;

  /// No description provided for @app_about_legalInformation_label.
  ///
  /// In en, this message translates to:
  /// **'Legal information'**
  String get app_about_legalInformation_label;

  /// No description provided for @app_about_materialComponents_label.
  ///
  /// In en, this message translates to:
  /// **'Material 3 components'**
  String get app_about_materialComponents_label;

  /// No description provided for @app_about_changelog_label.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get app_about_changelog_label;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
