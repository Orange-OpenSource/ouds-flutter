/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_grid_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_size_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_space_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_components_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/material/ouds_material_color_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_elevation_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_font_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_grid_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_size_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_space_semantic_tokens.dart';
import 'package:ouds_theme_orange/components/orange_badge_tokens.dart';
import 'package:ouds_theme_orange/components/orange_bar_tokens.dart';
import 'package:ouds_theme_orange/components/orange_buttonMono_tokens.dart';
import 'package:ouds_theme_orange/components/orange_button_tokens.dart';
import 'package:ouds_theme_orange/components/orange_checkbox_tokens.dart';
import 'package:ouds_theme_orange/components/orange_chip_tokens.dart';
import 'package:ouds_theme_orange/components/orange_controlItem_tokens.dart';
import 'package:ouds_theme_orange/components/orange_divider_tokens.dart';
import 'package:ouds_theme_orange/components/orange_inputTag_tokens.dart';
import 'package:ouds_theme_orange/components/orange_linkMono_tokens.dart';
import 'package:ouds_theme_orange/components/orange_link_tokens.dart';
import 'package:ouds_theme_orange/components/orange_pinCodeInput_tokens.dart';
import 'package:ouds_theme_orange/components/orange_radioButton_tokens.dart';
import 'package:ouds_theme_orange/components/orange_skeleton_tokens.dart';
import 'package:ouds_theme_orange/components/orange_switch_tokens.dart';
import 'package:ouds_theme_orange/components/orange_tag_tokens.dart';
import 'package:ouds_theme_orange/components/orange_textInput_tokens.dart';
import 'package:ouds_theme_orange/material/orange_material_color_tokens.dart';
import 'package:ouds_theme_orange/orange_typography.dart';
import 'package:ouds_theme_orange/semantic/orange_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_elevation_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_font_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_grid_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_opacity_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_size_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_space_semantic_tokens.dart';

/// Orange brand theme implementation for OUDS Flutter.
///
/// [OrangeTheme] provides a complete implementation of the Orange brand design system,
/// including colors, typography, spacing, and component styles for both light and dark modes.
///
/// ## Font Configuration
///
/// This theme uses **Helvetica Neue** as its primary font family. Due to licensing restrictions,
/// font files are not bundled with this library.
///
/// ### Font Sources
///
/// **Option 1: Download from CDN (Recommended for development)**
///
/// Fonts are automatically downloaded from Orange's CDN and cached locally:
///
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Automatic locale-based loading (Arabic or Latin)
///   final fontFamily = await OrangeFontProvider.loadFromCdn();
///
///   runApp(MyApp(
///     theme: OrangeTheme(fontFamily),
///   ));
/// }
/// ```
///
/// **Option 2: Bundle fonts as assets (Recommended for production)**
///
/// 1. Download Helvetica Neue fonts from [Orange Brand Portal](https://brand.orange.com/en/brand-basics/typography)
/// 2. Add font files to your `fonts/` directory:
///
/// ```
/// app/fonts/
/// ├── helvetica_neue_arabic_light.ttf
/// ├── helvetica_neue_arabic_roman.ttf
/// ├── helvetica_neue_arabic_bold.ttf
/// ├── helvetica_neue_latin_roman.ttf
/// ├── helvetica_neue_latin_medium.ttf
/// └── helvetica_neue_latin_bold.ttf
/// ```
///
/// 3. Configure in `pubspec.yaml` (NO weight specification - managed by API):
///
/// ```yaml
/// flutter:
///   fonts:
///     - family: HelveticaNeue-Arabic-Light
///       fonts:
///         - asset: fonts/helvetica_neue_arabic_light.ttf
///     - family: HelveticaNeue-Arabic
///       fonts:
///         - asset: fonts/helvetica_neue_arabic_roman.ttf
///     - family: HelveticaNeue-Arabic-Bold
///       fonts:
///         - asset: fonts/helvetica_neue_arabic_bold.ttf
///     - family: HelveticaNeue
///       fonts:
///         - asset: fonts/helvetica_neue_latin_roman.ttf
///     - family: HelveticaNeue-Medium
///       fonts:
///         - asset: fonts/helvetica_neue_latin_medium.ttf
///     - family: HelveticaNeue-Bold
///       fonts:
///         - asset: fonts/helvetica_neue_latin_bold.ttf
/// ```
///
/// 4. Load fonts at app startup (blocking):
///
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Manual configuration
///   final orangeFontFamily = OrangeFontFamily(
///     latin: OrangeHelveticaNeueLatin.bundled(
///       regularFontRes: "fonts/helvetica_neue_latin_roman.ttf",
///       mediumFontRes: "fonts/helvetica_neue_latin_medium.ttf",
///       boldFontRes: "fonts/helvetica_neue_latin_bold.ttf",
///     ),
///     arabic: OrangeHelveticaNeueArabic.bundled(
///       lightFontRes: "fonts/helvetica_neue_arabic_light.ttf",
///       regularFontRes: "fonts/helvetica_neue_arabic_roman.ttf",
///       boldFontRes: "fonts/helvetica_neue_arabic_bold.ttf",
///     ),
///   );
///   final fontFamilyName = await OrangeFontProvider.loadFromAssets(orangeFontFamily);
///
///   runApp(MyApp(
///     theme: OrangeTheme(fontFamilyName),
///   ));
/// }
/// ```
///
/// **Option 3: Non-blocking font loading (Recommended for fast startup)**
///
/// Use `OrangeFontService` to load fonts in background without blocking app startup:
///
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Load fonts in background (non-blocking)
///   OrangeFontService.instance.loadFromCdn();
///
///   runApp(MyApp());  // App starts immediately with fallback fonts
/// }
/// ```
///
/// ### Font Weights
///
/// All font loading methods automatically include all required weights:
/// - **Light (300)**: Helvetica Neue Light
/// - **Regular (400)**: Helvetica Neue Roman
/// - **Medium (500)**: Helvetica Neue Medium (Latin only)
/// - **Bold (700)**: Helvetica Neue Bold
///
/// ### Locale Support
///
/// The provider automatically detects device locale and loads appropriate fonts:
/// - **Arabic (`ar`)**: Loads Helvetica Neue Arabic variants
/// - **Other locales**: Loads Helvetica Neue Latin variants
///
/// ### Fallback Fonts
///
/// If Helvetica Neue fonts fail to load, the theme will fallback to system default fonts:
/// - Roboto (for Android devices)
/// - SF Pro Display (for iOS devices)
///
/// ## Theme Features
///
/// - **Color tokens**: Semantic color tokens for light and dark modes
/// - **Typography**: Complete typography scale with responsive sizing
/// - **Spacing**: Consistent spacing system
/// - **Components**: Pre-styled components (buttons, inputs, navigation, etc.)
/// - **Responsive**: Adapts to different screen sizes (mobile, tablet)
///
/// ## Example Usage
///
/// ```dart
/// MaterialApp(
///   theme: OudsTheme(
///     theme: OrangeTheme(fontFamily),
///   ).themeData,
///   darkTheme: OudsTheme(
///     theme: OrangeTheme(fontFamily),
///   ).darkThemeData,
///   home: MyHomePage(),
/// )
/// ```
class OrangeTheme implements OudsThemeContract {
  String? orangeFontFamily;

  /// Creates an instance of the Orange theme.
  ///
  /// The [orangeFontFamily] parameter specifies the font family to be used throughout
  /// the theme.
  ///
  /// **Note:** Omitting the [orangeFontFamily] is deprecated and this parameter will
  /// become required in a future version. It is strongly recommended to explicitly
  /// provide the font family name obtained from `OrangeFontProvider` to ensure
  /// correct font rendering. See the [OrangeTheme] class documentation for
  /// detailed instructions on loading the font.

  @Deprecated(
    'Creating OrangeTheme() without orangeFontFamily is deprecated. '
    'This parameter will be required in future versions. '
    'Use OrangeTheme(fontFamily) instead.',
  )
  OrangeTheme([this.orangeFontFamily]);

  @override
  String get name => "Orange";

  @override
  OudsMaterialColorTokens get materialColorTokens => OrangeMaterialColorTokens();

  @override
  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: materialColorTokens.primaryLight,
      onPrimary: materialColorTokens.onPrimaryLight,
      primaryContainer: materialColorTokens.primaryContainerLight,
      onPrimaryContainer: materialColorTokens.onPrimaryContainerLight,
      primaryFixed: materialColorTokens.primaryFixedLight,
      primaryFixedDim: materialColorTokens.primaryFixedDimLight,
      onPrimaryFixed: materialColorTokens.onPrimaryFixedLight,
      onPrimaryFixedVariant: materialColorTokens.onPrimaryFixedVariantLight,
      secondary: materialColorTokens.secondaryLight,
      onSecondary: materialColorTokens.onSecondaryLight,
      secondaryContainer: materialColorTokens.secondaryContainerLight,
      onSecondaryContainer: materialColorTokens.onSecondaryContainerLight,
      secondaryFixed: materialColorTokens.secondaryFixedLight,
      secondaryFixedDim: materialColorTokens.secondaryFixedDimLight,
      onSecondaryFixed: materialColorTokens.onSecondaryFixedLight,
      onSecondaryFixedVariant: materialColorTokens.onSecondaryFixedVariantLight,
      tertiary: materialColorTokens.tertiaryLight,
      onTertiary: materialColorTokens.onTertiaryLight,
      tertiaryContainer: materialColorTokens.tertiaryContainerLight,
      onTertiaryContainer: materialColorTokens.onTertiaryContainerLight,
      tertiaryFixed: materialColorTokens.tertiaryFixedLight,
      tertiaryFixedDim: materialColorTokens.tertiaryFixedDimLight,
      onTertiaryFixed: materialColorTokens.onTertiaryFixedLight,
      onTertiaryFixedVariant: materialColorTokens.onTertiaryFixedVariantLight,
      error: materialColorTokens.errorLight,
      onError: materialColorTokens.onErrorLight,
      errorContainer: materialColorTokens.errorContainerLight,
      onErrorContainer: materialColorTokens.onErrorContainerLight,
      surface: materialColorTokens.surfaceLight,
      onSurface: materialColorTokens.onSurfaceLight,
      surfaceDim: materialColorTokens.surfaceDimLight,
      surfaceBright: materialColorTokens.surfaceBrightLight,
      surfaceContainerLowest: materialColorTokens.surfContainerLowestLight,
      surfaceContainerLow: materialColorTokens.surfContainerLowLight,
      surfaceContainer: materialColorTokens.surfContainerLight,
      surfaceContainerHigh: materialColorTokens.surfContainerHighLight,
      surfaceContainerHighest: materialColorTokens.surfContainerHighestLight,
      onSurfaceVariant: materialColorTokens.onSurfaceVariantLight,
      outline: materialColorTokens.outlineLight,
      outlineVariant: materialColorTokens.outlineVariantLight,
      inverseSurface: materialColorTokens.inverseSurfaceLight,
      onInverseSurface: materialColorTokens.onSurfaceLight,
      inversePrimary: materialColorTokens.inversePrimaryLight,
      surfaceTint: materialColorTokens.surfaceTintLight,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: fontTokens.sizeBodyMediumMobile,
        fontWeight: fontTokens.weightBodyDefault,
        color: colorSemanticTokens.contentColorTokens.contentDefaultLight,
        fontFamily: fontFamily,
      ),
    ),
  );

  @override
  OudsColorSemanticTokens get colorSemanticTokens => OrangeColorSemanticTokens();

  @override
  OudsOpacitySemanticTokens get opacityTokens => OrangeOpacitySemanticTokens();

  @override
  OudsBorderSemanticTokens get borderTokens => OrangeBorderSemanticTokens();

  @override
  OudsElevationSemanticTokens get elevationTokens => OrangeElevationSemanticTokens();

  @override
  OudsSpaceSemanticTokens get spaceSemanticTokens => OrangeSpaceSemanticTokens();

  @override
  OudsSizeSemanticTokens get sizeSemanticTokens => OrangeSizeSemanticTokens();

  @override
  OudsGridSemanticTokens get gridSemanticTokens => OrangeGridSemanticTokens();

  @override
  OudsFontSemanticTokens get fontTokens => OrangeFontSemanticTokens();

  /// Gets the font family name to be used in the application.
  @override
  String get fontFamily => orangeFontFamily ?? (defaultTargetPlatform == TargetPlatform.android ? 'Roboto' : 'SFProDisplay');

  @override
  String get packageName => 'ouds_theme_orange';

  @override
  OudsColorScheme colorScheme(BuildContext context) {
    return OudsColorScheme.fromContext(context: context, colorTokens: colorSemanticTokens);
  }

  @override
  OudsSpaceScheme spaceScheme(BuildContext context) {
    return OudsSpaceScheme.fromContext(context: context, spaceTokens: spaceSemanticTokens);
  }

  @override
  OudsSizeScheme sizeScheme(BuildContext context) {
    return OudsSizeScheme.fromContext(context: context, sizeTokens: sizeSemanticTokens);
  }

  @override
  OudsGridScheme gridScheme(BuildContext context) {
    return OudsGridScheme.fromContext(context: context, gridTokens: gridSemanticTokens);
  }

  @override
  OudsTypography get typographyTokens => OrangeTypography();

  @override
  OudsProvidersTokens providersTokens(BuildContext context) {
    return OudsProvidersTokens(
      colorScheme: colorScheme(context),
      opacityTokens: opacityTokens,
      borderTokens: borderTokens,
      elevationTokens: elevationTokens,
      spaceTokens: spaceSemanticTokens,
      spaceScheme: spaceScheme(context),
      sizeTokens: sizeSemanticTokens,
      fontTokens: fontTokens,
    );
  }

  @override
  OudsComponentsTokens componentsTokens(BuildContext context) {
    return OudsComponentsTokens(
      button: OrangeButtonTokens(providersTokens(context)),
      buttonMono: OrangeButtonMonoTokens(providersTokens(context)),
      checkbox: OrangeCheckboxTokens(providersTokens(context)),
      controlItem: OrangeControlItemTokens(providersTokens(context)),
      radioButton: OrangeRadioButtonTokens(providersTokens(context)),
      divider: OrangeDividerTokens(providersTokens(context)),
      skeleton: OrangeSkeletonTokens(providersTokens(context)),
      switchButton: OrangeSwitchTokens(providersTokens(context)),
      chip: OrangeChipTokens(providersTokens(context)),
      badge: OrangeBadgeTokens(providersTokens(context)),
      tag: OrangeTagTokens(providersTokens(context)),
      inputTag: OrangeInputTagTokens(providersTokens(context)),
      textInput: OrangeTextInputTokens(providersTokens(context)),
      pinCodeInput: OrangePinCodeInputTokens(providersTokens(context)),
      link: OrangeLinkTokens(providersTokens(context)),
      linkMono: OrangeLinkMonoTokens(providersTokens(context)),
      bar: OrangeBarTokens(providersTokens(context)),
    );
  }

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: materialColorTokens.primaryDark,
        onPrimary: materialColorTokens.onPrimaryDark,
        primaryContainer: materialColorTokens.primaryContainerDark,
        onPrimaryContainer: materialColorTokens.onPrimaryContainerDark,
        primaryFixed: materialColorTokens.primaryFixedDark,
        primaryFixedDim: materialColorTokens.primaryFixedDimDark,
        onPrimaryFixed: materialColorTokens.onPrimaryFixedDark,
        onPrimaryFixedVariant: materialColorTokens.onPrimaryFixedVariantDark,
        secondary: materialColorTokens.secondaryDark,
        onSecondary: materialColorTokens.onSecondaryDark,
        secondaryContainer: materialColorTokens.secondaryContainerDark,
        onSecondaryContainer: materialColorTokens.onSecondaryContainerDark,
        secondaryFixed: materialColorTokens.secondaryFixedDark,
        secondaryFixedDim: materialColorTokens.secondaryFixedDimDark,
        onSecondaryFixed: materialColorTokens.onSecondaryFixedDark,
        onSecondaryFixedVariant: materialColorTokens.onSecondaryFixedVariantDark,
        tertiary: materialColorTokens.tertiaryDark,
        onTertiary: materialColorTokens.onTertiaryDark,
        tertiaryContainer: materialColorTokens.tertiaryContainerDark,
        onTertiaryContainer: materialColorTokens.onTertiaryContainerDark,
        tertiaryFixed: materialColorTokens.tertiaryFixedDark,
        tertiaryFixedDim: materialColorTokens.tertiaryFixedDimDark,
        onTertiaryFixed: materialColorTokens.onTertiaryFixedDark,
        onTertiaryFixedVariant: materialColorTokens.onTertiaryFixedVariantDark,
        error: materialColorTokens.errorDark,
        onError: materialColorTokens.onErrorDark,
        errorContainer: materialColorTokens.errorContainerDark,
        onErrorContainer: materialColorTokens.onErrorContainerDark,
        surface: materialColorTokens.surfaceDark,
        onSurface: materialColorTokens.onSurfaceDark,
        surfaceDim: materialColorTokens.surfaceDimDark,
        surfaceBright: materialColorTokens.surfaceBrightDark,
        surfaceContainerLowest: materialColorTokens.surfContainerLowestDark,
        surfaceContainerLow: materialColorTokens.surfContainerLowDark,
        surfaceContainer: materialColorTokens.surfContainerDark,
        surfaceContainerHigh: materialColorTokens.surfContainerHighDark,
        surfaceContainerHighest: materialColorTokens.surfContainerHighestDark,
        onSurfaceVariant: materialColorTokens.onSurfaceVariantDark,
        outline: materialColorTokens.outlineDark,
        outlineVariant: materialColorTokens.outlineVariantDark,
        inverseSurface: materialColorTokens.inverseSurfaceDark,
        onInverseSurface: materialColorTokens.onSurfaceDark,
        inversePrimary: materialColorTokens.inversePrimaryDark,
        surfaceTint: materialColorTokens.surfaceTintDark,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: fontTokens.sizeBodyMediumMobile,
          fontWeight: fontTokens.weightBodyDefault,
          color: colorSemanticTokens.contentColorTokens.contentDefaultDark,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
