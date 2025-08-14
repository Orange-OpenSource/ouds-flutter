<h1 align="center">OUDS Core Flutter Library</h1>

<p align="center">
  OUDS Core Flutter provides Orange components to developers.
  <br>
  <a href="https://github.com/Orange-OpenSource/ouds-flutter/issues/new?template=bug_report.yml" title="Open an issue on GitHub">Report bug</a>
  ·
  <a href="https://github.com/Orange-OpenSource/ouds-flutter/issues/new?template=feature_request.yml" title="Open an issue on GitHub">Request feature</a>
  ·
  <a href="https://flutter.unified-design-system.orange.com/" title="Flutter library technical documentation on GitHub Pages">Flutter documentation</a>
  ·
  <a href="https://github.com/Orange-OpenSource/ouds-flutter/wiki" title="Flutter library wiki">Wiki</a>
  ·
  <a href="https://unified-design-system.orange.com/" title="Design system global website">Design system</a>
</p>

## Content

This repository contains the OUDS Core Flutter library that provides Orange components for its unified design system.

You can find the [detailed technical documentation online](https://flutter.unified-design-system.orange.com/), as well as the [whole design system](https://unified-design-system.orange.com/).

## OUDS

OUDS stands for *Orange Unified Design System*.

This is a new design system, again, but _unified_, aiming to merge all requirements of Orange brands and affiliates to provide a unique design system, consistent across all platforms and for all countries, companies, users, and apps. Guidelines for TV, Flutter, Android, iOS, and web environments will be integrated into a "cohesive" approach, and any Orange-related software, including brand apps like *Parnasse* and *Sosh*, *Orange Innovation Cup* apps, and apps for Orange countries and affiliates will utilize this project in the future.

The project is open source, and topics such as accessibility and ecodesign will also be addressed.

It is intended to replace internal frameworks and the previous [ODS](https://github.com/Orange-OpenSource/ods-flutter) in the near future.

## Tokens version

- **Version**: 1.5.0.

## Other OUDS Libraries

- **ouds_theme_contract**: Contains the semantic tokens and component tokens.
- **ouds_theme_orange**: Contains the theme for the Orange brand.
- **ouds_theme_sosh**: Contains the theme for the Sosh brand.

## Build

### Generate l10n files

**Development process**

* Developers modify `ouds_flutter_en.arb` (and/or other language files).
* To have the translations in the app launched locally, run `flutter gen-l10n` in the `ouds_core/lib` directory.
    * This will regenerate:
        * `ouds_flutter_localizations.dart`
        * `ouds_flutter_localizations_en.dart`
        * other language files.
* These files **must not be** committed and pushed.

**Release the library**

* Pre-step: run `flutter gen-l10n` before creating and publishing the package to generate `ouds_flutter_localizations*.dart`.

## How install

### Pubspec.yaml

```Dart
  # Core
  ouds_core: ^0.5.0
  # Orange Theme contract
  ouds_theme_contract: ^0.5.0
  # Orange Theme
  ouds_theme_orange: ^0.5.0
  # Sosh Theme
  ouds_theme_sosh: ^0.5.0

dependency_overrides:
  intl: ^0.20.2
```

## How to use

### Localization

To set up localization for the `ouds_core` library, you need to set the `OudsLocalizations.delegate` in the `localizationsDelegates` properties of the `MaterialApp`. 


### Implementation

```Dart
    return MaterialApp(
      title: 'Title',
      theme: OrangeTheme().themeData,
      darkTheme: OrangeTheme().darkThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'title'),
      builder: (context, child) {
        return OudsTheme(
          themeContract: OrangeTheme(),
          themeMode: ThemeMode.system,
          onColoredSurface: false,
          child: child ?? Container(),
        );
      },
    );
```
### Custom Implementation 

To customize the Orange theme (e.g., apply rounded corners or adjust spacing), wrap the `OudsTheme` with `OudsThemeConfigModel`.

This allows you to override style tokens for specific components such as border radius while preserving the overall structure and design principles of the Orange theme.

```Dart
    return MaterialApp(
      title: 'Title',
      theme: OrangeTheme().themeData,
      darkTheme: OrangeTheme().darkThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'title'),
      builder: (context, child) {
        // Custom configuration with `OudsThemeConfigModel`.
        return OudsThemeConfigModel(
          button: OudsButtonConfig(rounded: false), // Apply rounded corners for the button.
          tag: OudsTagConfig(rounded: false), // Apply rounded corners for the tag.
          textInput: OudsTextInputConfig(rounded: true),// Apply rounded corners for the text input.
          // Wrap with `OudsTheme` for theme customization.
          child: OudsTheme(
            themeContract: themeController.currentTheme,
            themeMode: themeController.themeMode,
            onColoredSurface: themeController.onColoredSurface,
            child: child ?? Container(),
          ),
        );
      },
    );
```



## Copyright and license

Code released under the [MIT License](https://github.com/Orange-OpenSource/ouds-flutter/blob/develop/LICENSE).
For images and other assets, please [refer to the NOTICE.txt](https://github.com/Orange-OpenSource/ouds-flutter/blob/develop/NOTICE.txt).
