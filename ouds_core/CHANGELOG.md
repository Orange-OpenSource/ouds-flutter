# OUDS Flutter changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.3.1...develop)
### Added
### Changed
- [Library] `filter chip` and `suggestion chip` component update to v1.4 ([#688](https://github.com/Orange-OpenSource/ouds-flutter/issues/688))
- [Library] deps update dependency bump dartdoc to 9.0.4 ([#780](https://github.com/Orange-OpenSource/ouds-flutter/issues/780))
- [Library] update `Phone number input` component to v1.3 ([#690](https://github.com/Orange-OpenSource/ouds-flutter/issues/690))
- [Library] update `tag` component to v1.5 ([#694](https://github.com/Orange-OpenSource/ouds-flutter/issues/694))
- [Library] update `input tag` component to v1.2 ([#695](https://github.com/Orange-OpenSource/ouds-flutter/issues/695))
- [Library] update tokens 2.5.0 ([#778](https://github.com/Orange-OpenSource/ouds-flutter/issues/778))
- [Library] update tokens 2.4.0 ([#726](https://github.com/Orange-OpenSource/ouds-flutter/issues/726))

### Fixed
- [Library] `Filter chip` is not reached by keyboard focus or Switch Access focus ([#474](https://github.com/Orange-OpenSource/ouds-flutter/issues/474))
- [Library] `Phone number input` Add a hint to explain how to interact with fields  ([#571](https://github.com/Orange-OpenSource/ouds-flutter/issues/571))
- [Library] `input tag` the whole component should have the role button ([#481](https://github.com/Orange-OpenSource/ouds-flutter/issues/481))

## [1.3.1](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.3.0...1.3.1) - 2026-05-14
### Added
### Changed
### Fixed
- [Library] Null check operator used on a null value in all components has isHighContrastEnabled ([#756](https://github.com/Orange-OpenSource/ouds-flutter/issues/756))
- [Library] `Pin code input` Paste of less than 4 characters drops or merges characters ([#749](https://github.com/Orange-OpenSource/ouds-flutter/issues/749))

## [1.3.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.2.0...1.3.0) - 2026-05-08
### Added
- [Library] Create component - `Bottom sheet` ([#671](https://github.com/Orange-OpenSource/ouds-flutter/issues/671))
- [Library] Create component - `Alert message` ([#670](https://github.com/Orange-OpenSource/ouds-flutter/issues/670))
- [Library] Create component - `Inline alert` ([#485](https://github.com/Orange-OpenSource/ouds-flutter/issues/485))
- [Library] `Filter chip` Apply high contrast theme to filter chip (selected) ([#494](https://github.com/Orange-OpenSource/ouds-flutter/issues/494))

### Changed
- [Library] `Pin code input` Add optional `keyboardType` parameter (numeric/alphanumeric) ([#733](https://github.com/Orange-OpenSource/ouds-flutter/issues/733))
- [Library] update tokens 1.9.0 - Component Bullet List ([#710](https://github.com/Orange-OpenSource/ouds-flutter/issues/710))
- [Library] update tokens 1.9.0 - Component Alert ([#672](https://github.com/Orange-OpenSource/ouds-flutter/issues/672))

### Fixed
- [Library] `Pin code input` deletion requires two backspace presses on a typed digit ([#735](https://github.com/Orange-OpenSource/ouds-flutter/issues/735))
- [Library] `orange compact` some components are not displayed correctly ([#630](https://github.com/Orange-OpenSource/ouds-flutter/issues/630))
- [Library] `Password Input` Change the accessible name on show/hide button ([#599](https://github.com/Orange-OpenSource/ouds-flutter/issues/599))
- [Library] `Password input` Hidden password is clearly read by screen readers([#488](https://github.com/Orange-OpenSource/ouds-flutter/issues/488))
- [Library] `Password Input` password input is not accessible anymore with VO or FKA ([#614](https://github.com/Orange-OpenSource/ouds-flutter/issues/614))
- [Library] `Suggestion Chip` Wrong label([#519](https://github.com/Orange-OpenSource/ouds-flutter/issues/519))
- [Library] `Filter Chip` No button role on filter chip([#482](https://github.com/Orange-OpenSource/ouds-flutter/issues/482))
- [Library] `Pin Code Input` Role is missing on digit code input([#486](https://github.com/Orange-OpenSource/ouds-flutter/issues/486))
- [Library] `Pin Code Input` Read helper text with the group label([#487](https://github.com/Orange-OpenSource/ouds-flutter/issues/487))
- [Library] Nothing happens when clicking on the `suggestion chip` ([#723](https://github.com/Orange-OpenSource/ouds-flutter/issues/723))

## [1.2.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.1.2...1.2.0) - 2026-04-21
### Added
- [Library] Create component - `Toolbar top` ([#582](https://github.com/Orange-OpenSource/ouds-flutter/issues/582))
- [Library] Create component - `Top app bar` ([#91](https://github.com/Orange-OpenSource/ouds-flutter/issues/91))
- [Library] Add french Language ([#638](https://github.com/Orange-OpenSource/ouds-flutter/issues/638))
- [Library] Update the components definitions where relevant ([#549](https://github.com/Orange-OpenSource/ouds-flutter/issues/549))
- [Library] Manage Helvetica Neue Arabic font ([#404](https://github.com/Orange-OpenSource/ouds-flutter/issues/404))

### Changed
- [Library] Downgrade to Flutter SDK 3.35 and update documentation ([#656](https://github.com/Orange-OpenSource/ouds-flutter/issues/656))
- [Library] Remove OudsTagConfig and add rounded corner into `Tag` ([#598](https://github.com/Orange-OpenSource/ouds-flutter/issues/598))
- [Library] Update uses icons of status in `badge` and `tag` ([#597](https://github.com/Orange-OpenSource/ouds-flutter/issues/597))

### Fixed
- [Library] `Checkbox` Incorrect accessibility label ([#514](https://github.com/Orange-OpenSource/ouds-flutter/issues/514))
- [Library] `Input Tag` The whole component should have the role button ([#481](https://github.com/Orange-OpenSource/ouds-flutter/issues/481))

## [1.1.2](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.1.1...1.1.2) - 2026-03-17
### Fixed
- [Library] Fix `Orange button` multiple line([#611](https://github.com/Orange-OpenSource/ouds-flutter/issues/611))
- [Library] Add deprecated to OrangeTheme ([#610](https://github.com/Orange-OpenSource/ouds-flutter/issues/610))

## [1.1.1](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.0.0...1.1.1) - 2026-03-06
### Added
- [Library] Management of Helvetica Neue 75 font for Orange themes ([#370](https://github.com/Orange-OpenSource/ouds-flutter/issues/370))
- [Library] force `Tweak` Theme to use it into current theme ([#583](https://github.com/Orange-OpenSource/ouds-flutter/issues/583))
- [Library] Create component - `Navigation bar` ([#464](https://github.com/Orange-OpenSource/ouds-flutter/issues/464))
- [Library] Create component - `Bottom Navigation` ([#90](https://github.com/Orange-OpenSource/ouds-flutter/issues/90))

### Changed
- [Library] Update tokens 1.9.0 - Input tag tokens ([#594](https://github.com/Orange-OpenSource/ouds-flutter/issues/594))
- [Library] Update tokens 1.9.0 - Orange Compact theme ([#591](https://github.com/Orange-OpenSource/ouds-flutter/issues/591))
- [Library] Let `Button` takes the screen full width ([#577](https://github.com/Orange-OpenSource/ouds-flutter/issues/577))

### Fixed
- [Tool] Fix version `OudsAccessibilityPlugin`
- [Library] Incorrect calculation in `Typography` Tokens([#272](https://github.com/Orange-OpenSource/ouds-flutter/issues/272))
- [Library] remove `Not Null` check in components ([#587](https://github.com/Orange-OpenSource/ouds-flutter/issues/587))
- [Library] Keyboard focus is not visible on `button` component ([#473](https://github.com/Orange-OpenSource/ouds-flutter/issues/473))
- [Library] `Button`, `Chip`, `Link`, `Tag` components have text overflow ([#552](https://github.com/Orange-OpenSource/ouds-flutter/issues/552))
- [Tool] Unsupported operation Web for ouds libs and demo app ([#559](https://github.com/Orange-OpenSource/ouds-flutter/issues/559))
- [Library] Add a hint to explain how to interact with `input fields` (text, password, pin-code) ([#495](https://github.com/Orange-OpenSource/ouds-flutter/issues/495))
- [Library] `Text Input` Placeholder is read even if input is filled ([#471](https://github.com/Orange-OpenSource/ouds-flutter/issues/471))
- [Library] `Text Input` Incorrect reading order ([#449](https://github.com/Orange-OpenSource/ouds-flutter/issues/449))
- [Library] `Badge` Child Element Not Rendered Properly ([#557](https://github.com/Orange-OpenSource/ouds-flutter/issues/557))

## [1.0.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.7.0...1.0.0) - 2025-12-19
### Added
- [Library] Create component - `Phone Number Input` ([#326](https://github.com/Orange-OpenSource/ouds-flutter/issues/326))

### Changed
- [Library] Update `Control Items` and `Inputs` API to allow max-width management ([#533](https://github.com/Orange-OpenSource/ouds-flutter/issues/533))
- [Library] Update DSM links ([#528](https://github.com/Orange-OpenSource/ouds-flutter/issues/528))
- [Library] Use OUDS Icons V1.4 ([#515](https://github.com/Orange-OpenSource/ouds-flutter/issues/515))
- [Library] Update homepage documentation  ([#135](https://github.com/Orange-OpenSource/ouds-flutter/issues/135))

### Fixed
- [Library] `Checkbox` hint is missing on component ([#391](https://github.com/Orange-OpenSource/ouds-flutter/issues/391))
- [Library] Input text helper link ([#334](https://github.com/Orange-OpenSource/ouds-flutter/issues/334))
- [Library] Update keys, english label and Arabic translations ([#518](https://github.com/Orange-OpenSource/ouds-flutter/issues/518))

## [0.7.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.5.0...0.7.0) - 2025-12-01

### Added
- [Library] Include Design Component version in dev documentation ([#239](https://github.com/Orange-OpenSource/ouds-flutter/issues/239))
- [Library] Create component - `Password Input` ([#397](https://github.com/Orange-OpenSource/ouds-flutter/issues/397))
- [Library] Create component - `Pin Code Input` ([#307](https://github.com/Orange-OpenSource/ouds-flutter/issues/307))
- [Library] Create component - `Link` ([#46](https://github.com/Orange-OpenSource/ouds-flutter/issues/46))
- [library] Mobile SDK Data Privacy Disclaimer ([#410](https://github.com/Orange-OpenSource/ouds-flutter/issues/410))
- [Library] Tokens: `link` and `linkMono` ([#390](https://github.com/Orange-OpenSource/ouds-flutter/issues/390))

### Changed
- [Library] Component Update - Standalone checkbox and radio button rounded corners ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/437))
- [Library] Component Update - Radio button v1.4.0 ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/467))
- [Library] Component Update - Switch v1.5.0 ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/466))
- [Library] Component Update - Checkbox v2.4.0 ([#465](https://github.com/Orange-OpenSource/ouds-flutter/issues/465))
- [Library] Component Update - Update of radio item v1.3.0 ([#433](https://github.com/Orange-OpenSource/ouds-flutter/issues/433))
- [Library] Component Update - Update switch item to v1.4.0 ([#434](https://github.com/Orange-OpenSource/ouds-flutter/issues/434))
- [Library] Component Update - Update checkbox item to v2.3.0 ([#431](https://github.com/Orange-OpenSource/ouds-flutter/issues/431))
- [Library] Update `badge` component (badge, badge count, badge icon (v1.2) ([#423](https://github.com/Orange-OpenSource/ouds-flutter/issues/423))
- [Library] Update of `button` version v3.1 ([#396](https://github.com/Orange-OpenSource/ouds-flutter/issues/396))
- [Library] Use Solaris icons ([#245](https://github.com/Orange-OpenSource/ouds-flutter/issues/245))
- [Library] Update tokens 1.9.0 ([#478](https://github.com/Orange-OpenSource/ouds-flutter/issues/478))
- [Library] Update `tag` component v1.4 ([#452](https://github.com/Orange-OpenSource/ouds-flutter/issues/452))
- [Library] Update tokens 1.8.0 ([#436](https://github.com/Orange-OpenSource/ouds-flutter/issues/436))
- [Tool] Change the favicon to orange favicon in the documentation ([#371](https://github.com/Orange-OpenSource/ouds-flutter/issues/371))

### Fixed
- [Library] `Text input` helper link ([#334](https://github.com/Orange-OpenSource/ouds-flutter/issues/334))
- [Library] Border Token of 0 should not show any border ([#328](https://github.com/Orange-OpenSource/ouds-flutter/issues/328))
- [Library] `Text input` Trailing action button should have its own accessibility label ([#450](https://github.com/Orange-OpenSource/ouds-flutter/issues/450))
- [Library] `Text input` Incorrect reading order ([#449](https://github.com/Orange-OpenSource/ouds-flutter/issues/449))
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
- [Library] Checkbox indeterminate status : no difference with not checked status ([#361](https://github.com/Orange-OpenSource/ouds-flutter/issues/361))
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
- [Library] Create component - Badge  ([#88](https://github.com/Orange-OpenSource/ouds-flutter/issues/88))

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