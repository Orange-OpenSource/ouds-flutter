import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ouds_flutter_app_localizations_ar.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'DesignToolbox'**
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

  /// No description provided for @app_common_selected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get app_common_selected_a11y;

  /// No description provided for @app_common_unselected_a11y.
  ///
  /// In en, this message translates to:
  /// **'Unselected'**
  String get app_common_unselected_a11y;

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

  /// No description provided for @app_common_customizeChips_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Chip list'**
  String get app_common_customizeChips_label_a11y;

  /// No description provided for @app_common_customizeChips_hint_a11y.
  ///
  /// In en, this message translates to:
  /// **'Please select a chip by navigating through the options'**
  String get app_common_customizeChips_hint_a11y;

  /// No description provided for @app_common_selected_label.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get app_common_selected_label;

  /// No description provided for @app_common_design_version.
  ///
  /// In en, this message translates to:
  /// **'Reference design version:'**
  String get app_common_design_version;

  /// No description provided for @app_components_common_outlined_label.
  ///
  /// In en, this message translates to:
  /// **'Outlined'**
  String get app_components_common_outlined_label;

  /// No description provided for @app_topBar_theme_button_a11y.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get app_topBar_theme_button_a11y;

  /// No description provided for @app_topBar_darkMode_button_a11y.
  ///
  /// In en, this message translates to:
  /// **'Apply dark mode'**
  String get app_topBar_darkMode_button_a11y;

  /// No description provided for @app_topBar_lightMode_button_a11y.
  ///
  /// In en, this message translates to:
  /// **'Apply light mode'**
  String get app_topBar_lightMode_button_a11y;

  /// No description provided for @app_topBar_systemMode_button_a11y.
  ///
  /// In en, this message translates to:
  /// **'Apply system mode'**
  String get app_topBar_systemMode_button_a11y;

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

  /// No description provided for @app_tokens_viewCodeExample_label.
  ///
  /// In en, this message translates to:
  /// **'View token code example'**
  String get app_tokens_viewCodeExample_label;

  /// No description provided for @app_tokens_color_label.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get app_tokens_color_label;

  /// No description provided for @app_tokens_color_description_text.
  ///
  /// In en, this message translates to:
  /// **'Colour reinforces our brand identity and ensures consistency across all product experiences. The semantic tokens described are the onse you should use when building a mobile app.'**
  String get app_tokens_color_description_text;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get app_tokens_color_action_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get app_tokens_color_always_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get app_tokens_color_background_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Border'**
  String get app_tokens_color_border_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get app_tokens_color_brand_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get app_tokens_color_content_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Overlay'**
  String get app_tokens_color_overlay_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Repository'**
  String get app_tokens_color_repository_label;

  /// Do not translate this string
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get app_tokens_color_surface_label;

  /// No description provided for @app_tokens_elevation_label.
  ///
  /// In en, this message translates to:
  /// **'Elevation'**
  String get app_tokens_elevation_label;

  /// No description provided for @app_tokens_elevation_description_text.
  ///
  /// In en, this message translates to:
  /// **'Shadows are used to give the impression of distance or elevation between surfaces, which adds depth to our designs.'**
  String get app_tokens_elevation_description_text;

  /// No description provided for @app_tokens_opacity_label.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get app_tokens_opacity_label;

  /// No description provided for @app_tokens_opacity_description_text.
  ///
  /// In en, this message translates to:
  /// **'Opacity can help distinguish foreground elements from background elements, making content easier to read and important actions more noticeable.'**
  String get app_tokens_opacity_description_text;

  /// No description provided for @app_tokens_typography_label.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get app_tokens_typography_label;

  /// No description provided for @app_tokens_typography_description_text.
  ///
  /// In en, this message translates to:
  /// **'Typography is our system of fonts and text styles. They enhance communication and reinforce the brand style.'**
  String get app_tokens_typography_description_text;

  /// No description provided for @app_tokens_border_label.
  ///
  /// In en, this message translates to:
  /// **'Border'**
  String get app_tokens_border_label;

  /// No description provided for @app_tokens_border_description_text.
  ///
  /// In en, this message translates to:
  /// **'Borders are used for the stroke colours on components and also for the colours of divider lines for components like tables.'**
  String get app_tokens_border_description_text;

  /// No description provided for @app_tokens_border_width_label.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get app_tokens_border_width_label;

  /// No description provided for @app_tokens_border_radius_label.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get app_tokens_border_radius_label;

  /// No description provided for @app_tokens_border_style_label.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get app_tokens_border_style_label;

  /// No description provided for @app_components_common_color_label.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get app_components_common_color_label;

  /// No description provided for @app_components_common_error_label.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get app_components_common_error_label;

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
  /// **'Text + Icon'**
  String get app_components_common_iconAndTextLayout_label;

  /// No description provided for @app_components_common_label_label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get app_components_common_label_label;

  /// No description provided for @app_components_common_onColoredBackground_label.
  ///
  /// In en, this message translates to:
  /// **'On colored background'**
  String get app_components_common_onColoredBackground_label;

  /// No description provided for @app_components_common_hierarchy_label.
  ///
  /// In en, this message translates to:
  /// **'Hierarchy'**
  String get app_components_common_hierarchy_label;

  /// No description provided for @app_components_common_status_label.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get app_components_common_status_label;

  /// No description provided for @app_components_common_size_label.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get app_components_common_size_label;

  /// No description provided for @app_components_common_textAndBulletLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Text + Bullet'**
  String get app_components_common_textAndBulletLayout_label;

  /// No description provided for @app_components_common_textAndLoaderLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Text + Loader'**
  String get app_components_common_textAndLoaderLayout_label;

  /// No description provided for @app_components_common_roundedCorner_label.
  ///
  /// In en, this message translates to:
  /// **'Rounded Corner'**
  String get app_components_common_roundedCorner_label;

  /// No description provided for @app_components_common_loader_label.
  ///
  /// In en, this message translates to:
  /// **'Loader'**
  String get app_components_common_loader_label;

  /// No description provided for @app_components_common_iconOnlyLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Icon only'**
  String get app_components_common_iconOnlyLayout_label;

  /// No description provided for @app_components_common_icon_a11y.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get app_components_common_icon_a11y;

  /// No description provided for @app_components_common_style_label.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get app_components_common_style_label;

  /// No description provided for @app_components_common_readOnly_label.
  ///
  /// In en, this message translates to:
  /// **'Read only'**
  String get app_components_common_readOnly_label;

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

  /// No description provided for @app_components_checkbox_label.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get app_components_checkbox_label;

  /// No description provided for @app_components_checkbox_description_text.
  ///
  /// In en, this message translates to:
  /// **'Checkboxes allows users to select one or multiple options from a list, toggle settings on or off, or confirm an action.'**
  String get app_components_checkbox_description_text;

  /// No description provided for @app_components_checkbox_checkbox_label.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get app_components_checkbox_checkbox_label;

  /// No description provided for @app_components_checkbox_checkboxItem_label.
  ///
  /// In en, this message translates to:
  /// **'Checkbox item'**
  String get app_components_checkbox_checkboxItem_label;

  /// No description provided for @app_components_checkbox_indeterminateCheckbox_label.
  ///
  /// In en, this message translates to:
  /// **'Indeterminate checkbox'**
  String get app_components_checkbox_indeterminateCheckbox_label;

  /// No description provided for @app_components_checkbox_indeterminateCheckboxItem_label.
  ///
  /// In en, this message translates to:
  /// **'Indeterminate checkbox item'**
  String get app_components_checkbox_indeterminateCheckboxItem_label;

  /// No description provided for @app_components_controlItem_helperText_label.
  ///
  /// In en, this message translates to:
  /// **'Helper text'**
  String get app_components_controlItem_helperText_label;

  /// No description provided for @app_components_controlItem_icon_label.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get app_components_controlItem_icon_label;

  /// No description provided for @app_components_controlItem_readOnly_label.
  ///
  /// In en, this message translates to:
  /// **'Read only'**
  String get app_components_controlItem_readOnly_label;

  /// No description provided for @app_components_controlItem_divider_label.
  ///
  /// In en, this message translates to:
  /// **'Divider'**
  String get app_components_controlItem_divider_label;

  /// No description provided for @app_components_controlItem_reversed_label.
  ///
  /// In en, this message translates to:
  /// **'Reversed'**
  String get app_components_controlItem_reversed_label;

  /// No description provided for @app_components_controlItem_label_label.
  ///
  /// In en, this message translates to:
  /// **'Label text'**
  String get app_components_controlItem_label_label;

  /// No description provided for @app_components_divider_label.
  ///
  /// In en, this message translates to:
  /// **'Divider'**
  String get app_components_divider_label;

  /// No description provided for @app_components_divider_description_text.
  ///
  /// In en, this message translates to:
  /// **'A divider visually structures an interface by clearly separating content sections. It helps to improve readability and content organization without introducing a strong hierarchy like a heading or a container would.'**
  String get app_components_divider_description_text;

  /// No description provided for @app_components_divider_horizontalDivider_label.
  ///
  /// In en, this message translates to:
  /// **'Horizontal divider'**
  String get app_components_divider_horizontalDivider_label;

  /// No description provided for @app_components_divider_verticalDivider_label.
  ///
  /// In en, this message translates to:
  /// **'Vertical divider'**
  String get app_components_divider_verticalDivider_label;

  /// No description provided for @app_components_radioButton_label.
  ///
  /// In en, this message translates to:
  /// **'Radio Button'**
  String get app_components_radioButton_label;

  /// No description provided for @app_components_radioButton_description_text.
  ///
  /// In en, this message translates to:
  /// **'A radio button allows users to select a single option from a set of mutually exclusive choices, typically displayed as a circular input with a label that becomes filled when selected.'**
  String get app_components_radioButton_description_text;

  /// No description provided for @app_components_radioButton_radioButton_label.
  ///
  /// In en, this message translates to:
  /// **'Radio button'**
  String get app_components_radioButton_radioButton_label;

  /// No description provided for @app_components_radioButton_radioButtonItem_label.
  ///
  /// In en, this message translates to:
  /// **'Radio Button Item'**
  String get app_components_radioButton_radioButtonItem_label;

  /// No description provided for @app_components_radioButton_radioButtonItem_outlined_label.
  ///
  /// In en, this message translates to:
  /// **'Outlined'**
  String get app_components_radioButton_radioButtonItem_outlined_label;

  /// No description provided for @app_components_radioButton_radioButtonItem_additionalLabel_label.
  ///
  /// In en, this message translates to:
  /// **'Additional text'**
  String get app_components_radioButton_radioButtonItem_additionalLabel_label;

  /// No description provided for @app_components_switch_label.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get app_components_switch_label;

  /// No description provided for @app_components_switch_description_text.
  ///
  /// In en, this message translates to:
  /// **'A switch allows the user to toggle between two states, typically on and off. It is often represented as a button or a slider that changes position or color to indicate the current state. Switches are used to enable or disable features, options, or settings in an intuitive and visual manner.'**
  String get app_components_switch_description_text;

  /// No description provided for @app_components_switch_switchItem_label.
  ///
  /// In en, this message translates to:
  /// **'Switch item'**
  String get app_components_switch_switchItem_label;

  /// No description provided for @app_components_badge_label.
  ///
  /// In en, this message translates to:
  /// **'Badge'**
  String get app_components_badge_label;

  /// No description provided for @app_components_badge_description_text.
  ///
  /// In en, this message translates to:
  /// **'The Badge is a small UI element used to highlight status, notifications, or categorization within an interface. It is often displayed as a label or indicator with a distinct background color and text.'**
  String get app_components_badge_description_text;

  /// No description provided for @app_components_badge_type_label.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get app_components_badge_type_label;

  /// No description provided for @app_components_badge_standardType_label.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get app_components_badge_standardType_label;

  /// No description provided for @app_components_badge_countType_label.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get app_components_badge_countType_label;

  /// No description provided for @app_components_badge_iconType_label.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get app_components_badge_iconType_label;

  /// No description provided for @app_components_badge_count_label.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get app_components_badge_count_label;

  /// No description provided for @app_components_badge_notification_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get app_components_badge_notification_label_a11y;

  /// No description provided for @app_components_badge_success_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get app_components_badge_success_label_a11y;

  /// No description provided for @app_components_badge_important_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get app_components_badge_important_label_a11y;

  /// No description provided for @app_components_badge_info_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get app_components_badge_info_label_a11y;

  /// No description provided for @app_components_badge_warning_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get app_components_badge_warning_label_a11y;

  /// No description provided for @app_components_badge_negative_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get app_components_badge_negative_label_a11y;

  /// No description provided for @app_components_badge_disable_label_a11y.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get app_components_badge_disable_label_a11y;

  /// No description provided for @app_components_chip_label.
  ///
  /// In en, this message translates to:
  /// **'Chip'**
  String get app_components_chip_label;

  /// No description provided for @app_components_chip_description_text.
  ///
  /// In en, this message translates to:
  /// **'Chips help people enter information, make selections, filter content, or trigger actions.'**
  String get app_components_chip_description_text;

  /// No description provided for @app_components_suggestionChip_label.
  ///
  /// In en, this message translates to:
  /// **'Suggestion Chip'**
  String get app_components_suggestionChip_label;

  /// No description provided for @app_components_chip_suggestionChip_description_text.
  ///
  /// In en, this message translates to:
  /// **'A suggestion chip is a compact UI element used to present recommended or predictive options based on user input or context. Often found in search bars, forms, or messaging interfaces, suggestion chips help users quickly select from relevant suggestions. They are typically non-selected by default and can be tapped or clicked to apply the suggestion, streamlining user input and enhancing usability.'**
  String get app_components_chip_suggestionChip_description_text;

  /// No description provided for @app_components_filterChip_label.
  ///
  /// In en, this message translates to:
  /// **'Filter Chip'**
  String get app_components_filterChip_label;

  /// No description provided for @app_components_chip_filterChip_description_text.
  ///
  /// In en, this message translates to:
  /// **'A filter chip is a compact UI element used in a design system to represent a filter option that can be selected or deselected by the user. Filter chips allow users to refine content or data by applying one or more filters in a visually accessible and interactive way.'**
  String get app_components_chip_filterChip_description_text;

  /// No description provided for @app_components_tag_label.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get app_components_tag_label;

  /// No description provided for @app_components_tag_description_text.
  ///
  /// In en, this message translates to:
  /// **'A tag is a small element that shows short info like a label, keyword, or category.It helps users quickly find, group, or understand content.'**
  String get app_components_tag_description_text;

  /// No description provided for @app_components_tagInput_label.
  ///
  /// In en, this message translates to:
  /// **'Tag Input'**
  String get app_components_tagInput_label;

  /// No description provided for @app_components_tagInput_description_text.
  ///
  /// In en, this message translates to:
  /// **'A Tag Input is a component that allows users to enter multiple values, each represented as a tag. As users type and submit values (usually by pressing enter, comma, or tab), each value is transformed into a Tag.'**
  String get app_components_tagInput_description_text;

  /// No description provided for @app_components_text_input_label.
  ///
  /// In en, this message translates to:
  /// **'Text input'**
  String get app_components_text_input_label;

  /// No description provided for @app_components_text_input_description_text.
  ///
  /// In en, this message translates to:
  /// **'A Text Input is a user interface component that allows users to enter, edit, or select single-line textual data. It\'s one of the most fundamental form elements used to capture user input such as names, emails, passwords, or search queries.'**
  String get app_components_text_input_description_text;

  /// No description provided for @app_components_text_input_leadingIcon_label.
  ///
  /// In en, this message translates to:
  /// **'Leading icon'**
  String get app_components_text_input_leadingIcon_label;

  /// No description provided for @app_components_text_input_trailingIcon_label.
  ///
  /// In en, this message translates to:
  /// **'Trailing action'**
  String get app_components_text_input_trailingIcon_label;

  /// No description provided for @app_components_text_input_prefix_label.
  ///
  /// In en, this message translates to:
  /// **'Prefix'**
  String get app_components_text_input_prefix_label;

  /// No description provided for @app_components_text_input_suffix_label.
  ///
  /// In en, this message translates to:
  /// **'Suffix'**
  String get app_components_text_input_suffix_label;

  /// No description provided for @app_components_text_input_placeholder_label.
  ///
  /// In en, this message translates to:
  /// **'Placeholder'**
  String get app_components_text_input_placeholder_label;

  /// No description provided for @app_components_text_input_helperText_label.
  ///
  /// In en, this message translates to:
  /// **'Helper text'**
  String get app_components_text_input_helperText_label;

  /// No description provided for @app_components_text_input_error_label.
  ///
  /// In en, this message translates to:
  /// **'This field can’t be empty.'**
  String get app_components_text_input_error_label;

  /// No description provided for @app_components_link_label.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get app_components_link_label;

  /// No description provided for @app_components_link_description_text.
  ///
  /// In en, this message translates to:
  /// **'Links direct users to other resources or sections, whether internal (within the same application) or external (to a website or document).'**
  String get app_components_link_description_text;

  /// No description provided for @app_components_link_backLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get app_components_link_backLayout_label;

  /// No description provided for @app_components_link_nextLayout_label.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get app_components_link_nextLayout_label;

  /// No description provided for @app_components_password_input_label.
  ///
  /// In en, this message translates to:
  /// **'Password input'**
  String get app_components_password_input_label;

  /// No description provided for @app_components_password_input_description_text.
  ///
  /// In en, this message translates to:
  /// **'A password input is a form field specifically designed to securely capture a user’s confidential password. It masks the characters as they are typed, typically replacing them with dots, in order to protect the input from being read by others nearby. While the primary goal is to enhance privacy and security, the field may also include usability features such as a show/hide password toggle and helper text to guide password creation.'**
  String get app_components_password_input_description_text;

  /// No description provided for @app_components_password_input_error_label.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get app_components_password_input_error_label;

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

  /// No description provided for @app_about_appSettings_label.
  ///
  /// In en, this message translates to:
  /// **'Open the app settings'**
  String get app_about_appSettings_label;

  /// No description provided for @app_about_details_themeCoreVersion.
  ///
  /// In en, this message translates to:
  /// **'Core tokens library version:'**
  String get app_about_details_themeCoreVersion;

  /// No description provided for @app_about_details_themeOrangeCoreVersion.
  ///
  /// In en, this message translates to:
  /// **'Orange core tokens library version:'**
  String get app_about_details_themeOrangeCoreVersion;

  /// No description provided for @app_about_details_themeOrangeBrandVersion.
  ///
  /// In en, this message translates to:
  /// **'Orange brand tokens library version:'**
  String get app_about_details_themeOrangeBrandVersion;

  /// No description provided for @app_about_details_themeSoshCoreVersion.
  ///
  /// In en, this message translates to:
  /// **'Sosh core tokens library version:'**
  String get app_about_details_themeSoshCoreVersion;

  /// No description provided for @app_about_details_themeSoshBrandVersion.
  ///
  /// In en, this message translates to:
  /// **'Sosh brand tokens library version:'**
  String get app_about_details_themeSoshBrandVersion;

  /// No description provided for @app_about_details_androidCoreVersion.
  ///
  /// In en, this message translates to:
  /// **'Android core tokens library version:'**
  String get app_about_details_androidCoreVersion;

  /// No description provided for @app_about_details_androidSystemVersion.
  ///
  /// In en, this message translates to:
  /// **'Android system tokens library version:'**
  String get app_about_details_androidSystemVersion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
