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
import 'package:ouds_theme_orange/semantic/orange_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_elevation_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_font_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_grid_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_opacity_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_size_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_space_semantic_tokens.dart';

/// [OrangeTheme] implements the [OudsThemeContract] and defines the "Orange" theme for the application.
/// It provides both light and dark theme configurations using the OUDS design system, including color, typography,
/// and component tokens. The class handles the theme's data for both light and dark modes, allowing dynamic
/// switching based on the current [ThemeMode] setting.
///
/// This theme uses the Helvetica Neue font family. **Due to legal issues Helvetica Neue font files are not bundled with this library.**
///
/// The Helvetica Neue font files for the Orange theme are available at
/// [https://brand.orange.com/en/brand-basics/typography](https://brand.orange.com/en/brand-basics/typography) and can be used by copying the `ttf` files
/// in the `assets/fonts` directory of the project
///
/// Load Fonts Before App Starts
///
///```dart
///   final fontFamily = await OrangeFontFamily.getFontFamily(
///     fontConfigs: [
///       OrangeFontFamily(
///         familyName: "HelveticaNeueArabic",
///         assets: [
///           "assets/fonts/helvetica_neue_arabic_bold.ttf",
///           "assets/fonts/helvetica_neue_arabic_light.ttf",
///           "assets/fonts/helvetica_neue_arabic_roman.ttf",
///         ]
///       ),
///       OrangeFontFamily(
///           familyName: "HelveticaNeueLatin",
///           assets: [
///             "assets/fonts/helvetica_neue_latin_bold.ttf",
///             "assets/fonts/helvetica_neue_latin_medium.ttf",
///             "assets/fonts/helvetica_neue_latin_roman.ttf",
///           ]
///       )
///     ],
///   );
///
/// OrangeTheme(fontFamily);
/// }
///```
///
/// Although the preferred way of using the Helvetica Neue font is configuring bundled font files,
/// there are some cases where this is not possible, for instance in open source projects where the font
/// files cannot be bundled due to legal issues. In these cases, the font files can alternatively,
/// the font files can be downloaded using Flutter's Downloadable Fonts feature
/// by calling the [OrangeFontService.getFontFamily] method in your `app` before the `runApp` method in your main file.
///
///
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   final orangeFontFamily = await OrangeFontFamily.getFontFamily();
///
///   runApp(OudsApplication(fontFamily:orangeFontFamily));
/// }
///```
///
/// When using OrangeTheme, simply provide the font as a parameter.
///
/// ```dart
///   OrangeTheme(
///     orangeFontFamily
///   )
///```
///
/// Please note that the Flutter Downloadable Font feature works asynchronously, whether the font is already downloaded or not,
/// and that default font family will be used if download fails.
///
/// The theme includes the following:
/// - A color scheme with semantic tokens for light and dark modes,
/// - Typography settings based on the defined font tokens,
/// - Component tokens for consistency across the app's UI elements.
///
/// This theme is used for the visual styling of the Flutter application, ensuring a consistent user experience
/// across both Android and iOS platforms.
class OrangeTheme implements OudsThemeContract {
  String? orangeFontFamily;
  OrangeTheme(this.orangeFontFamily);

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
  String get fontFamily => orangeFontFamily
      ?? (defaultTargetPlatform == TargetPlatform.android
      ? 'Roboto'
      : 'SFProDisplay')
      ;

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
  OudsTypography get typographyTokens => OudsTypography();

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
      button: OrangeButtonTokens(
        providersTokens(context),
      ),
      buttonMono: OrangeButtonMonoTokens(
        providersTokens(context),
      ),
      checkbox: OrangeCheckboxTokens(
        providersTokens(context),
      ),
      controlItem: OrangeControlItemTokens(
        providersTokens(context),
      ),
      radioButton: OrangeRadioButtonTokens(
        providersTokens(context),
      ),
      divider: OrangeDividerTokens(
        providersTokens(context),
      ),
      skeleton: OrangeSkeletonTokens(
        providersTokens(context),
      ),
      switchButton: OrangeSwitchTokens(
        providersTokens(context),
      ),
      chip: OrangeChipTokens(
        providersTokens(context),
      ),
      badge: OrangeBadgeTokens(
        providersTokens(context),
      ),
      tag: OrangeTagTokens(
        providersTokens(context),
      ),
      inputTag: OrangeInputTagTokens(
        providersTokens(context),
      ),
      textInput: OrangeTextInputTokens(
        providersTokens(context),
      ),
      pinCodeInput: OrangePinCodeInputTokens(
        providersTokens(context),
      ),
      link: OrangeLinkTokens(
        providersTokens(context),
      ),
      linkMono: OrangeLinkMonoTokens(
        providersTokens(context),
      ),
      bar: OrangeBarTokens(
        providersTokens(context),
      ),
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
