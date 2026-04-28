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

## Orange Unified Design System

Orange Unified Design System is abbreviated to *OUDS*.

This is a new design system, again, but _unified_, aiming to merge all requirements of Orange brands and affiliates to provide a unique design system, consistent across all platforms and for all countries, companies, users, and apps. Guidelines for TV, Flutter, Android, iOS, and web environments will be integrated into a "cohesive" approach, and any Orange-related software, including brand apps like *Parnasse* and *Sosh*, *Orange Innovation Cup* apps, and apps for Orange countries and affiliates will utilize this project in the future.

The project is open source, and topics such as accessibility and ecodesign will also be addressed.

It is intended to replace internal frameworks and the previous [ODS](https://github.com/Orange-OpenSource/ods-flutter) in the near future.

## Tokens version

- **OUDS core token version**: 1.9.0.

## Other OUDS Libraries

- **ouds_theme_contract**: Contains the semantic tokens and component tokens.
- **ouds_theme_orange**: Contains the theme for the Orange brand.
- **ouds_theme_orange_compact**: Contains the theme for the Orange brand.
- **ouds_theme_sosh**: Contains the theme for the Sosh brand.
- **ouds_theme_wireframe**: Contains the theme for the Wireframe brand.


## Components version


<table>
  <thead>
    <tr>
      <th>Component</th>
      <th>Version</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding-left:10px;">Badge</td>
      <td>1.2.0</td>
    </tr>
    <tr>
      <td style="padding-left:10px;">Bar</td>
      <td>1.0.0</td>
    </tr>
    <tr>
      <td style="padding-left:10px;">Button</td>
      <td>3.2.0 </td>
    </tr>
    <tr>
      <td style="padding:10px;">Checkbox</td>
      <td>2.4.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Chip</td>
      <td>1.3.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Divider</td>
      <td>1.0.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Link</td>
      <td>2.2.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Pin Code Input </td>
      <td>1.2.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Radio Button</td>
      <td>1.4.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Switch</td>
      <td>1.5.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Tag</td>
      <td>1.4.0</td>
    </tr>
    <tr>
      <td style="padding:10px;">Text Input</td>
      <td>1.3.0</td>
    </tr>
  </tbody>
</table>


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

```yaml
  # Core
  ouds_core: ^1.3.0
  # Orange Theme contract
  ouds_theme_contract: ^1.3.0
  # Orange Theme
  ouds_theme_orange: ^1.3.0
  # Orange Theme Compact
  ouds_theme_orange_compact: ^1.3.0
  # Sosh Theme
  ouds_theme_sosh: ^1.3.0
  # Wireframe Theme
  ouds_theme_wireframe: ^1.3.0
  
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
      theme: OrangeTheme(OrangeFontService.instance.fontFamily).themeData,
      darkTheme: OrangeTheme(OrangeFontService.instance.fontFamily).darkThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'title'),
      builder: (context, child) {
        return OudsTheme(
          themeContract: OrangeTheme(OrangeFontService.instance.fontFamily),
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
      theme: OrangeTheme(OrangeFontService.instance.fontFamily).themeData,
      darkTheme: OrangeTheme(OrangeFontService.instance.fontFamily).darkThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'title'),
      builder: (context, child) {
        // Custom configuration with `OudsThemeConfigModel`.
        return OudsThemeConfigModel(
          button: OudsButtonConfig(rounded: false), // Apply rounded corners for the button.
          textInput: OudsTextInputConfig(rounded: true), // Apply rounded corners for the text input.
          // Wrap with `OudsTheme` for theme customization.
          child: OudsTheme(
            themeContract: OrangeTheme(OrangeFontService.instance.fontFamily),
            themeMode: ThemeMode.system,
            onColoredSurface: false,
            child: child ?? Container(),
          ),
        );
      },
    );
```

### Custom Implementation with Fonts

The Orange theme uses **Helvetica Neue** as its primary font. You can load fonts in three different ways:

#### Bundle Custom Fonts as Assets

For production apps, bundle fonts locally:

1. Add fonts to your project:
   ```
   app/fonts/
   ├── helvetica_neue_latin_roman.ttf
   ├── helvetica_neue_latin_medium.ttf
   ├── helvetica_neue_latin_bold.ttf
   ├── helvetica_neue_arabic_roman.ttf
   ├── helvetica_neue_arabic_light.ttf
   └── helvetica_neue_arabic_bold.ttf
   ```

2. Configure in `pubspec.yaml`:
   ```yaml
   flutter:
     fonts:
       - family: HelveticaNeue
         fonts:
           - asset: fonts/helvetica_neue_latin_roman.ttf
       - family: HelveticaNeue-Medium
         fonts:
           - asset: fonts/helvetica_neue_latin_medium.ttf
       - family: HelveticaNeue-Bold
         fonts:
           - asset: fonts/helvetica_neue_latin_bold.ttf
       - family: HelveticaNeue-Arabic
         fonts:
          - asset: fonts/helvetica_neue_arabic_roman.ttf
       - family: HelveticaNeue-Arabic-Light
         fonts:
          - asset: fonts/helvetica_neue_arabic_light.ttf
       - family: HelveticaNeue-Arabic-Bold
         fonts:
          - asset: fonts/helvetica_neue_arabic_bold.ttf

   ```

3. Load fonts at startup:

   ```Dart
   import 'package:ouds_theme_orange/orange_font_service.dart';
   import 'package:ouds_theme_orange/orange_font_family.dart';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();
     
     final orangeFontFamily = OrangeFontFamily(
       latin: OrangeHelveticaNeueLatin.bundled(
         regularFontRes: "fonts/helvetica_neue_latin_roman.ttf",
         mediumFontRes: "fonts/helvetica_neue_latin_medium.ttf",
         boldFontRes: "fonts/helvetica_neue_latin_bold.ttf",
       ),
       arabic: OrangeHelveticaNeueArabic.bundled(
         lightFontRes: "fonts/helvetica_neue_arabic_light.ttf",
         regularFontRes: "fonts/helvetica_neue_arabic_roman.ttf",
         boldFontRes: "fonts/helvetica_neue_arabic_bold.ttf",
       ),
     );
     
     // Load in background
     OrangeFontService.instance.loadFromAssets(orangeFontFamily);
     
     runApp(MyApp());
   }
   ```

**Fallback Fonts:**
If font loading fails, the theme automatically falls back to system fonts:
- Roboto (on Android devices)
- SF Pro Display (on iOS devices)


## Data privacy

The Orange Unified Design System library is an SDK that allows a developer to create Orange branded mobile application. As such:

this SDK does not handle any personal data.
this SDK does not require any device permission to work.



## Copyright and license

Code released under the [MIT License](https://github.com/Orange-OpenSource/ouds-flutter/blob/develop/LICENSE).
For images and other assets, please [refer to the NOTICE.txt](https://github.com/Orange-OpenSource/ouds-flutter/blob/develop/NOTICE.txt).
