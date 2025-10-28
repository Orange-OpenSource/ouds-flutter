# OUDS Flutter changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.5.0...develop)

### Added
- [library] Mobile SDK Data Privacy Disclaimer ([#410](https://github.com/Orange-OpenSource/ouds-flutter/issues/#410))
- [Library] Tokens: `link` and `linkMono` ([#390](https://github.com/Orange-OpenSource/ouds-flutter/issues/#390))

### Changed
- [Library] Update tokens 1.8.0 ([#436](https://github.com/Orange-OpenSource/ouds-flutter/issues/436))
- [Tool] Change the favicon to orange favicon in the documentation ([#371](https://github.com/Orange-OpenSource/ouds-flutter/issues/371))

### Fixed
- [Library] `Checkbox item` + icon : wrong accessible name ([#392](https://github.com/Orange-OpenSource/ouds-flutter/issues/392))
- [Library] `Checkbox`: hint is missing on component  ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/391))
- [Library] Android `Switch` : remove the useless focus on switch ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/364))
- [Library] `Chip`: Hint is wrong on Android and missing on iOS ([#393](https://github.com/Orange-OpenSource/ouds-flutter/issues/393))
- [Library] `Badge` with icon or standard has no accessible name  ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/385))
- [Library] iOS Wrong accessible name for `Button` text+icon ([#387](https://github.com/Orange-OpenSource/ouds-flutter/issues/387))
- [Library] `Radio button` not correctly read by screen-readers ([#362](https://github.com/Orange-OpenSource/ouds-flutter/issues/362))
- [Library] Fix accessible name and missing role `Chip`  ([#375](https://github.com/Orange-OpenSource/ouds-flutter/issues/375))
- [Library] `Badge`: Text enlargement is not applied to icon ([#368](https://github.com/Orange-OpenSource/ouds-flutter/issues/368))
- [Library] `Button` loading state should set the disabled state ([#368](https://github.com/Orange-OpenSource/ouds-flutter/issues/368))
- [Library] Android High Contrast for Checkbox and Radio button ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/327))
- [Library] Preserve @nodoc header in generated l10n files ([#412](https://github.com/Orange-OpenSource/ouds-flutter/issues/412))
- [Library] Error status not read by Talkback and Voice Over `Switch` ([#365](https://github.com/Orange-OpenSource/ouds-flutter/issues/365))
- [Library] Label text overflow `Text Input` ([#333](https://github.com/Orange-OpenSource/ouds-flutter/issues/333))
- [Library] Checkbox indeterminate status : no difference with not checked status ([#361](https://github.com/Orange-OpenSource/ouds-flutter/issues/#361))
- [Library] Tag with bullet/icon has incorrect name a11y ([#366](https://github.com/Orange-OpenSource/ouds-flutter/issues/366))
- [Library] Move dartdoc to dev_dependencies ([#350](https://github.com/Orange-OpenSource/ouds-flutter/issues/350))
- [Library] Inaccessible suggestion `chip` ([#331](https://github.com/Orange-OpenSource/ouds-flutter/issues/331))

## [0.5.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.4.0...0.5.0) - 2025-08-14

### Added
- [Library] Create component - `Text Input` ([#5O](https://github.com/Orange-OpenSource/ouds-flutter/issues/50))
- [Library] Create component - `Tag` ([#52](https://github.com/Orange-OpenSource/ouds-flutter/issues/52))

### Changed
- [Library] Remove style loading `Button` and replace with loader ([#304](https://github.com/Orange-OpenSource/ouds-flutter/issues/304))
- [Library] Update component - `Button version 3.0` ([#279](https://github.com/Orange-OpenSource/ouds-flutter/issues/279))
- [Library] Refactor with custom configuration Rounded `Button`, `Tag` and `TextInput` ([#299](-https://github.com/Orange-OpenSource/ouds-flutter/issues/299))
- [Library] Refactor `Chip` and `Button` classes name ([#298](-https://github.com/Orange-OpenSource/ouds-flutter/issues/298))

### Fixed
- [Library] Wrong token used in tag input for disabled status ([#310](https://github.com/Orange-OpenSource/ouds-flutter/issues/310))
- [Library] wrong role for checkbox a11y ([#261](https://github.com/Orange-OpenSource/ouds-flutter/issues/261))


## [0.4.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.3.0...0.4.0) - 2025-07-11

### Added
- [Library] Create component - Tag ([#52](https://github.com/Orange-OpenSource/ouds-flutter/issues/52))
- [Library] Create component - Filter Chip ([#213](https://github.com/Orange-OpenSource/ouds-flutter/issues/213))
- [Library] Create component - Suggestion Chip ([#212](https://github.com/Orange-OpenSource/ouds-flutter/issues/212))
- [Library] Create component - Badge  ([#88](https://github.com/Orange-OpenSource/ouds-flutter/issues/#88))

### Changed
- [Library] Update tokens 1.2.0 ([#236](https://github.com/Orange-OpenSource/ouds-flutter/issues/236))
- [Library] Update tokens 1.1.0 ([#225](https://github.com/Orange-OpenSource/ouds-flutter/issues/225))

### Fixed
- [Tool] Add assets to `notice.txt` ([#244](https://github.com/Orange-OpenSource/ouds-flutter/issues/244))
- [Library] Delayed pressed state ([#220](https://github.com/Orange-OpenSource/ouds-flutter/issues/220))

## [0.3.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.2.0...0.3.0) - 2025-06-10

### Added
- [Library] Create component - Switch ([#49](https://github.com/Orange-OpenSource/ouds-flutter/issues/49))
- [Library] Create component - Divider ([#57](https://github.com/Orange-OpenSource/ouds-flutter/issues/57))

### Changed
- [Library] Token `grid` and `space` values now adapt based on device type ([#137](https://github.com/Orange-OpenSource/ouds-flutter/issues/137))

### Fixed
- [Library] Use `context` access; removed `ouds_core/ouds_theme_contract` interdependency ([#136](https://github.com/Orange-OpenSource/ouds-flutter/issues/136))
- [Library] Clean project ouds_core ([#185](https://github.com/Orange-OpenSource/ouds-flutter/issues/185))

## [0.2.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.1.0...0.2.0) - 2025-05-13

### Changed
- [Library] Refactor : create class global for icons names ([#152](https://github.com/Orange-OpenSource/ouds-flutter/issues/152))

### Added
- [Library] Create component - Checkbox ([#47](https://github.com/Orange-OpenSource/ouds-flutter/issues/47))
- [Library] RTL : activation of RTL mode / manage arabic language ([#134](https://github.com/Orange-OpenSource/ouds-flutter/issues/134))

## [0.1.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.0.0...0.1.0) - 2025-03-20

### Added

- [Library] Create component - Button ([#45](https://github.com/Orange-OpenSource/ouds-flutter/issues/45))
- [Library] Fix workflow to use dart doc ([#75](https://github.com/Orange-OpenSource/ouds-flutter/issues/75))
- [Library] Add color tokens ([#44](https://github.com/Orange-OpenSource/ouds-flutter/issues/44))
- [Library] Add typography tokens ([#43](https://github.com/Orange-OpenSource/ouds-flutter/issues/43))
- [Library] Add grid tokens ([#42](https://github.com/Orange-OpenSource/ouds-flutter/issues/42))
- [Library] Add size tokens ([#41](https://github.com/Orange-OpenSource/ouds-flutter/issues/41))
- [Library] Add space tokens ([#40](https://github.com/Orange-OpenSource/ouds-flutter/issues/40))
- [Library] Add elevation tokens ([#39](https://github.com/Orange-OpenSource/ouds-flutter/issues/39))
- [Library] Add border tokens ([#38](https://github.com/Orange-OpenSource/ouds-flutter/issues/38))
- [Library] Add opacity tokens ([#36](https://github.com/Orange-OpenSource/ouds-flutter/issues/36))
- [Library] Implement tokens architecture ([#37](https://github.com/Orange-OpenSource/ouds-flutter/issues/37))
- [Library] Create the basics of a documentation ([#7](https://github.com/Orange-OpenSource/ouds-flutter/issues/7))
- [Library] Create the basic architecture of the library ([#4](https://github.com/Orange-OpenSource/ouds-flutter/issues/4))

### Changed

### Fixed
