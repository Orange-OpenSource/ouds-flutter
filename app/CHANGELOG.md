# OUDS Flutter changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.3.1...develop)
### Added
### Changed
- [Library] `tab bar component`, update the animation of the `selected tab indicator` ([#633](https://github.com/Orange-OpenSource/ouds-flutter/issues/633))
- [Library] deps downgrade dartdoc from to 8.3.3 to fix meta version ([#786](https://github.com/Orange-OpenSource/ouds-flutter/issues/786))
- [DemoApp] deps update dependency github.com/apple/swift-protobuf to 1.38.0 ([#773](https://github.com/Orange-OpenSource/ouds-flutter/issues/773))
- [Library] deps update dependency bump dartdoc to 9.0.4 ([#780](https://github.com/Orange-OpenSource/ouds-flutter/issues/780))
- [Library] update `Phone number input` component to v1.3 ([#690](https://github.com/Orange-OpenSource/ouds-flutter/issues/690))
- [Library] update `tag` component to v1.5 ([#694](https://github.com/Orange-OpenSource/ouds-flutter/issues/694))
- [Library] update `input tag` component to v1.2 ([#695](https://github.com/Orange-OpenSource/ouds-flutter/issues/695))
- [DemoApp][Library] update tokens 2.5.0 ([#778](https://github.com/Orange-OpenSource/ouds-flutter/issues/778))
- [DemoApp][Library] update tokens 2.4.0 ([#726](https://github.com/Orange-OpenSource/ouds-flutter/issues/726))

### Fixed
- [Library] `Bottom Bar` Inconsistent order of the accessible ([#625](https://github.com/Orange-OpenSource/ouds-flutter/issues/625))
- [Library] `Bottom Bar` Overlap when zoom is activated ([#627](https://github.com/Orange-OpenSource/ouds-flutter/issues/627))
- [Library] `Phone number input` Add a hint to explain how to interact with fields  ([#571](https://github.com/Orange-OpenSource/ouds-flutter/issues/571))
- [Library] `input tag` the whole component should have the role button ([#481](https://github.com/Orange-OpenSource/ouds-flutter/issues/481))

## [1.3.1](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.3.0...1.3.1) - 2026-05-14
### Added
### Changed
### Fixed
- [Library] Null check operator used on a null value in all components has isHighContrastEnabled ([#756](https://github.com/Orange-OpenSource/ouds-flutter/issues/756))
- [DemoApp] Layout Overflow on Demo Screen for component version when system font size is increased for accessibility. ([#748](https://github.com/Orange-OpenSource/ouds-flutter/issues/748))
- [Library] `Pin code input` Paste of less than 4 characters drops or merges characters ([#749](https://github.com/Orange-OpenSource/ouds-flutter/issues/749))

## [1.3.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.2.0...1.3.0) - 2026-05-08
### Added
- [DemoApp][Library] Create component - `Bottom sheet` ([#671](https://github.com/Orange-OpenSource/ouds-flutter/issues/671))
- [DemoApp][Library] Create component - `Alert message` ([#670](https://github.com/Orange-OpenSource/ouds-flutter/issues/670))
- [DemoApp][Library] Create component - `Inline alert` ([#485](https://github.com/Orange-OpenSource/ouds-flutter/issues/485))
- [Library] `Filter chip` Apply high contrast theme to filter chip (selected) ([#494](https://github.com/Orange-OpenSource/ouds-flutter/issues/494))

### Changed
- [DemoApp][Library] `Pin code input` Add optional `keyboardType` parameter (numeric/alphanumeric) ([#733](https://github.com/Orange-OpenSource/ouds-flutter/issues/733))
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
- [DemoApp][Library] Create component - `Toolbar top` ([#582](https://github.com/Orange-OpenSource/ouds-flutter/issues/582))
- [DemoApp][Library] Create component - `Top app bar` ([#91](https://github.com/Orange-OpenSource/ouds-flutter/issues/91))
- [Tool] Add in README OpenSSF scorecard ([#632](https://github.com/Orange-OpenSource/ouds-flutter/issues/632))
- [DemoApp] Improve theme selections and tuning ([#356](https://github.com/Orange-OpenSource/ouds-flutter/issues/356))
- [DemoApp][Library] Add french Language ([#638](https://github.com/Orange-OpenSource/ouds-flutter/issues/638))
- [DemoApp][Library] Update the components definitions where relevant ([#549](https://github.com/Orange-OpenSource/ouds-flutter/issues/549))
- [Library] Manage Helvetica Neue Arabic font ([#404](https://github.com/Orange-OpenSource/ouds-flutter/issues/404))

### Changed
- [Tool] improve dartDoc permissions ([#664](https://github.com/Orange-OpenSource/ouds-flutter/issues/664))
- [Tool] Improve OSSF score ([#659](https://github.com/Orange-OpenSource/ouds-flutter/issues/659))
- [DemoApp][Library] Downgrade to Flutter SDK 3.35 and update documentation ([#656](https://github.com/Orange-OpenSource/ouds-flutter/issues/656))
- [DemoApp] Unused dependency detected in Flutter demo app ([#646](https://github.com/Orange-OpenSource/ouds-flutter/issues/646))
- [DemoApp][Library] Remove OudsTagConfig and add rounded corner into `Tag` ([#598](https://github.com/Orange-OpenSource/ouds-flutter/issues/598))
- [DemoApp][Library] Update uses icons of status in `badge` and `tag` ([#597](https://github.com/Orange-OpenSource/ouds-flutter/issues/597))

### Fixed
- [DemoApp] `About` Text Overflow Issue in Arabic language  ([#640](https://github.com/Orange-OpenSource/ouds-flutter/issues/640))
- [Library] `Checkbox` Incorrect accessibility label ([#514](https://github.com/Orange-OpenSource/ouds-flutter/issues/514))
- [Library] `Input Tag` The whole component should have the role button ([#481](https://github.com/Orange-OpenSource/ouds-flutter/issues/481))

## [1.1.2](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.1.1...1.1.2) - 2026-03-17
### Fixed
- [Library] Fix `Orange button` multiple line([#611](https://github.com/Orange-OpenSource/ouds-flutter/issues/611))
- [Library] Add deprecated to OrangeTheme ([#610](https://github.com/Orange-OpenSource/ouds-flutter/issues/610))

## [1.1.1](https://github.com/Orange-OpenSource/ouds-flutter/compare/1.0.0...1.1.1) - 2026-03-06
### Added
- [DemoApp][Library] Add Orange Compact theme ([#504](https://github.com/Orange-OpenSource/ouds-flutter/issues/504))
- [DemoApp][Library] Management of Helvetica Neue 75 font for Orange themes ([#370](https://github.com/Orange-OpenSource/ouds-flutter/issues/370))
- [DemoApp][Library] Create component - `Navigation bar` ([#464](https://github.com/Orange-OpenSource/ouds-flutter/issues/464))
- [DemoApp][Library] Create component - `Bottom Navigation` ([#90](https://github.com/Orange-OpenSource/ouds-flutter/issues/90))

### Changed
- [DemoApp][Library] Update tokens 1.9.0 - Input tag tokens ([#594](https://github.com/Orange-OpenSource/ouds-flutter/issues/594))
- [DemoApp][Library] Update tokens 1.9.0 - Orange Compact theme ([#591](https://github.com/Orange-OpenSource/ouds-flutter/issues/591))
- [DemoApp][Library] force `Tweak` Theme to use it into current theme ([#583](https://github.com/Orange-OpenSource/ouds-flutter/issues/583))
- [DemoApp][Library] Let `Button` takes the screen full width ([#577](https://github.com/Orange-OpenSource/ouds-flutter/issues/577))
- [DemoApp] Use the tag to show the Component Design Version ([#501](https://github.com/Orange-OpenSource/ouds-flutter/issues/501))
- [Tool] Update `Flutter` to 3.38.0 and `Dart` Version to 3.10.8  ([#572](https://github.com/Orange-OpenSource/ouds-flutter/issues/572))

### Fixed 
- [Tool] Fix version `OudsAccessibilityPlugin`
- [Library] Incorrect calculation in `Typography` Tokens([#272](https://github.com/Orange-OpenSource/ouds-flutter/issues/272))
- [DemoApp][Library] remove `Not Null` check in components ([#587](https://github.com/Orange-OpenSource/ouds-flutter/issues/587))
- [Library] Missing tokens in the token presentation pages ([#554](https://github.com/Orange-OpenSource/ouds-flutter/issues/554))
- [Library] Keyboard focus is not visible on `button` component ([#473](https://github.com/Orange-OpenSource/ouds-flutter/issues/473))
- [DemoApp] Activated tab `Navigation bar` is not highlighted ([#384](https://github.com/Orange-OpenSource/ouds-flutter/issues/384))
- [DemoApp][Library] `Button`, `Chip`, `Link`, `Tag` components have text overflow ([#552](https://github.com/Orange-OpenSource/ouds-flutter/issues/552))
- [Tool] Unsupported operation Web for ouds libs and demo app ([#559](https://github.com/Orange-OpenSource/ouds-flutter/issues/559))
- [Library] Add a hint to explain how to interact with input fields (text, password, pin-code) ([#495](https://github.com/Orange-OpenSource/ouds-flutter/issues/495))
- [Library] `Text Input` Placeholder is read even if input is filled ([#471](https://github.com/Orange-OpenSource/ouds-flutter/issues/471))
- [Library] `Text Input` Incorrect reading order ([#449](https://github.com/Orange-OpenSource/ouds-flutter/issues/449))
- [DemoApp][Library] `Badge` Child Element Not Rendered Properly ([#557](https://github.com/Orange-OpenSource/ouds-flutter/issues/557))

## [1.0.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.7.0...1.0.0) - 2025-12-19
### Added
- [DemoApp][Library] Create component - `Phone Number Input` ([#326](https://github.com/Orange-OpenSource/ouds-flutter/issues/326))
- [DemoApp][Library] Manage the new medium font weight `Typography` ([#403](https://github.com/Orange-OpenSource/ouds-flutter/issues/403))
- [Tool] Add `ITSAppUsesNonExemptEncryption` into info.plist ([#526](https://github.com/Orange-OpenSource/ouds-flutter/issues/526))

### Changed
- [DemoApp][Library] Update `Control Items` and `Inputs` API to allow max-width management ([#533](https://github.com/Orange-OpenSource/ouds-flutter/issues/533))
- [Library] Update DSM links ([#528](https://github.com/Orange-OpenSource/ouds-flutter/issues/528))
- [DemoApp][Library] Use OUDS Icons V1.4  ([#515](https://github.com/Orange-OpenSource/ouds-flutter/issues/515))
- [Library] Update homepage documentation  ([#135](https://github.com/Orange-OpenSource/ouds-flutter/issues/135))
- [Library] Integration of System library v2.3.0, component changelog v1.11 ([#513](https://github.com/Orange-OpenSource/ouds-flutter/issues/513))

### Fixed
- [Library] `Checkbox` hint is missing on component ([#391](https://github.com/Orange-OpenSource/ouds-flutter/issues/391))
- [Library] Input text helper link ([#334](https://github.com/Orange-OpenSource/ouds-flutter/issues/334))
- [DemoApp][Library] Update keys, english label and Arabic translations ([#518](https://github.com/Orange-OpenSource/ouds-flutter/issues/518))

## [0.7.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.5.0...0.7.0) - 2025-12-01

### Added
- [Library] Include Design Component version in dev documentation ([#239](https://github.com/Orange-OpenSource/ouds-flutter/issues/239))
- [DemoApp][Library] Create component - `Password Input` ([#397](https://github.com/Orange-OpenSource/ouds-flutter/issues/397))
- [DemoApp][Library] Create component - `Pin Code Input` ([#307](https://github.com/Orange-OpenSource/ouds-flutter/issues/307))
- [DemoApp][Library] Create component - `Link` ([#46](https://github.com/Orange-OpenSource/ouds-flutter/issues/46))
- [library] Mobile SDK Data Privacy Disclaimer ([#410](https://github.com/Orange-OpenSource/ouds-flutter/issues/410))
- [DemoApp][Library] Tokens: `link` and `linkMono` ([#390](https://github.com/Orange-OpenSource/ouds-flutter/issues/390))

### Changed
- [DemoApp][Library] Component Update - Standalone checkbox and radio button rounded corners ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/437))
- [DemoApp][Library] Component Update - Radio button v1.4.0 ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/467))
- [DemoApp][Library] Component Update - Switch v1.5.0 ([#466](https://github.com/Orange-OpenSource/ouds-flutter/issues/466))
- [DemoApp][Library] Component Update - Checkbox v2.4.0 ([#465](https://github.com/Orange-OpenSource/ouds-flutter/issues/465))
- [DemoApp][Library] Component Update - Update of radio item v1.3.0 ([#433](https://github.com/Orange-OpenSource/ouds-flutter/issues/433))
- [DemoApp][Library] Component Update - Update switch item to v1.4.0 ([#434](https://github.com/Orange-OpenSource/ouds-flutter/issues/434))
- [DemoApp][Library] Component Update - Update checkbox item to v2.3.0 ([#431](https://github.com/Orange-OpenSource/ouds-flutter/issues/431))
- [DemoApp][Library] Update `badge` component (badge, badge count, badge icon (v1.2) ([#423](https://github.com/Orange-OpenSource/ouds-flutter/issues/423))
- [DemoApp][Library] Update of `button` version v3.1 ([#396](https://github.com/Orange-OpenSource/ouds-flutter/issues/396))
- [DemoApp][Library] Use Solaris icons ([#245](https://github.com/Orange-OpenSource/ouds-flutter/issues/245))
- [Library] Update tokens 1.9.0 ([#478](https://github.com/Orange-OpenSource/ouds-flutter/issues/478))
- [DemoApp][Library] Update `tag` component v1.4 ([#452](https://github.com/Orange-OpenSource/ouds-flutter/issues/452))
- [Library] Update tokens 1.8.0 ([#436](https://github.com/Orange-OpenSource/ouds-flutter/issues/436))
- [DemoApp] Components must have hidden divider by default `control item` ([#379](https://github.com/Orange-OpenSource/ouds-flutter/issues/379))
- [Library] Update tokens 1.7.0 ([#422](https://github.com/Orange-OpenSource/ouds-flutter/issues/422))
- [Tool] Change the favicon to orange favicon in the documentation ([#371](https://github.com/Orange-OpenSource/ouds-flutter/issues/371))

### Fixed
- [DemoApp][Library] `Text input` helper link ([#334](https://github.com/Orange-OpenSource/ouds-flutter/issues/334))
- [DemoApp][Library] Border Token of 0 should not show any border ([#328](https://github.com/Orange-OpenSource/ouds-flutter/issues/328))
- [DemoApp][Library] `Text input` Trailing action button should have its own accessibility label ([#450](https://github.com/Orange-OpenSource/ouds-flutter/issues/450))
- [Library] `Text input` Incorrect reading order ([#449](https://github.com/Orange-OpenSource/ouds-flutter/issues/449))
- [DemoApp] Android The native tab-bar is displayed on top of the customize bottom sheet ([#358](https://github.com/Orange-OpenSource/ouds-flutter/issues/358))
- [Library] `Checkbox item` + icon : wrong accessible name ([#392](https://github.com/Orange-OpenSource/ouds-flutter/issues/392))
- [Library] `Checkbox`: hint is missing on component  ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/391))
- [Library] Android `Switch` : remove the useless focus on switch ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/364))
- [DemoApp][Library] Token updates color missing ([#435](https://github.com/Orange-OpenSource/ouds-flutter/issues/435))
- [Library] `Chip`: Hint is wrong on Android and missing on iOS ([#393](https://github.com/Orange-OpenSource/ouds-flutter/issues/393))
- [DemoApp][Library] `Badge` with icon or standard has no accessible name  ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/385))
- [Library] iOS Wrong accessible name for `Button` text+icon ([#387](https://github.com/Orange-OpenSource/ouds-flutter/issues/387))
- [Library] `Radio button` not correctly read by screen-readers ([#362](https://github.com/Orange-OpenSource/ouds-flutter/issues/362))
- [Library] Fix accessible name and missing role `Chip`  ([#375](https://github.com/Orange-OpenSource/ouds-flutter/issues/375))
- [Library] `Badge`: Text enlargement is not applied to icon ([#368](https://github.com/Orange-OpenSource/ouds-flutter/issues/368))
- [Library] `Button` loading state should set the disabled state ([#368](https://github.com/Orange-OpenSource/ouds-flutter/issues/368))
- [Library] Android High Contrast for Checkbox and Radio button ([#327](https://github.com/Orange-OpenSource/ouds-flutter/issues/327))
- [Library] Preserve @nodoc header in generated l10n files ([#412](https://github.com/Orange-OpenSource/ouds-flutter/issues/412))
- [Library] Error status not read by Talkback and Voice Over `Switch` ([#365](https://github.com/Orange-OpenSource/ouds-flutter/issues/365))
- [Library] Label text overflow `Text Input` ([#333](https://github.com/Orange-OpenSource/ouds-flutter/issues/333))
- [DemoApp][Library] Checkbox indeterminate status : no difference with not checked status ([#361](https://github.com/Orange-OpenSource/ouds-flutter/issues/#361))
- [Library] Tag with bullet/icon has incorrect name a11y ([#366](https://github.com/Orange-OpenSource/ouds-flutter/issues/366))
- [Library] Move dartdoc to dev_dependencies ([#350](https://github.com/Orange-OpenSource/ouds-flutter/issues/350))
- [DemoApp] Token 1.3 update missing  ([#336](https://github.com/Orange-OpenSource/ouds-flutter/issues/336))
- [DemoApp] Tag layout consistency ([#324](https://github.com/Orange-OpenSource/ouds-flutter/issues/324))
- [DemoApp][Library] Inaccessible suggestion `chip` ([#331](https://github.com/Orange-OpenSource/ouds-flutter/issues/331))

## [0.5.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.4.0...0.5.0) - 2025-08-14

### Added
- [DemoApp][Library] Create component - `Text Input` ([#5O](https://github.com/Orange-OpenSource/ouds-flutter/issues/50))
- [DemoApp][Library] Create component - `Tag` ([#52](https://github.com/Orange-OpenSource/ouds-flutter/issues/52))
- [DemoApp][Library] Integration of Sosh theme ([#262](https://github.com/Orange-OpenSource/ouds-flutter/issues/262))

### Changed
- [DemoApp][Library] Remove style loading `Button` and replace with loader ([#304](https://github.com/Orange-OpenSource/ouds-flutter/issues/304))
- [DemoApp] Update Kotlin version to 2.0.0 ([#303](https://github.com/Orange-OpenSource/ouds-flutter/issues/303))
- [DemoApp][Library] Update component - `Button version 3.0` ([#279](https://github.com/Orange-OpenSource/ouds-flutter/issues/279))
- [DemoApp][Library] Refactor with custom configuration Rounded `Button`, `Tag` and `TextInput` ([#299](-https://github.com/Orange-OpenSource/ouds-flutter/issues/299))
- [Library] Refactor `Chip` and `Button` classes name ([#298](-https://github.com/Orange-OpenSource/ouds-flutter/issues/298))
- [DemoApp] Include Design Component version in Design Toolbox App ([#240](https://github.com/Orange-OpenSource/ouds-flutter/issues/240))
- [DemoApp] Replace components illustrations by the components themselves ([#247](https://github.com/Orange-OpenSource/ouds-flutter/issues/247))
- [DemoApp] Replace app icon with Flutter icon for Design Toolbox ([#268](https://github.com/Orange-OpenSource/ouds-flutter/issues/268))

### Fixed
- [Library] Wrong token used in tag input for disabled status ([#310](https://github.com/Orange-OpenSource/ouds-flutter/issues/310))
- [Library] Flutter Web build fails due to Platform usage in theme ([#300](https://github.com/Orange-OpenSource/ouds-flutter/issues/300))
- [Library] Wrong role for checkbox a11y ([#261](https://github.com/Orange-OpenSource/ouds-flutter/issues/261))
- [DemoApp] The bottom sheet should be closed by default for a11y ([#263](https://github.com/Orange-OpenSource/ouds-flutter/issues/263))

## [0.4.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.3.0...0.4.0) - 2025-07-11

### Added
- [DemoApp][Library] Create component - `Filter Chip` ([#213](https://github.com/Orange-OpenSource/ouds-flutter/issues/213))
- [DemoApp][Library] Create component - `Suggestion Chip` ([#212](https://github.com/Orange-OpenSource/ouds-flutter/issues/212))
- [DemoApp] Create component - Badge ([#88](https://github.com/Orange-OpenSource/ouds-flutter/issues/88))
- [DemoApp][Library] Create component - `Switch` ([#49](https://github.com/Orange-OpenSource/ouds-flutter/issues/47))
- [DemoApp][Library] Tokens: `tag` ([#241](https://github.com/Orange-OpenSource/ouds-flutter/issues/241))
- [DemoApp][Library] Tokens: `badge` ([#238](https://github.com/Orange-OpenSource/ouds-flutter/issues/238))
- [DemoApp] Display components in both light/dark mode ([#223](https://github.com/Orange-OpenSource/ouds-flutter/issues/223))
- [DemoApp] Add token version in About page and documentation ([#142](https://github.com/Orange-OpenSource/ouds-flutter/issues/142))

### Changed
- [DemoApp][Library] Update tokens 1.2.0 ([#236](https://github.com/Orange-OpenSource/ouds-flutter/issues/236))
- [DemoApp][Library] Update tokens 1.1.0 ([#225](https://github.com/Orange-OpenSource/ouds-flutter/issues/225))

### Fixed
- [Tool] Add assets to `notice.txt` ([#244](https://github.com/Orange-OpenSource/ouds-flutter/issues/244))
- [DemoApp][Library] Delayed pressed state ([#220](https://github.com/Orange-OpenSource/ouds-flutter/issues/220))
- [DemoApp] Update cards backgrounds token ([#204](https://github.com/Orange-OpenSource/ouds-flutter/issues/204))
- [DemoApp][Library] Token `size` values now adapt based on device type ([#218](https://github.com/Orange-OpenSource/ouds-flutter/issues/218))
- [DemoApp] Color order mismatch in `Divider` component ([#216](https://github.com/Orange-OpenSource/ouds-flutter/issues/216))

## [0.3.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.2.0...0.3.0) - 2025-06-10

### Added
- [DemoApp][Library] Tokens: screen Border ([#248](https://github.com/Orange-OpenSource/ouds-flutter/issues/248))
- [Library] `Chip` component (tokens library v0.11.0) ([##215](https://github.com/Orange-OpenSource/ouds-flutter/issues/215)
- [DemoApp][Library] Tokens: screen typography ([#138](https://github.com/Orange-OpenSource/ouds-flutter/issues/138))
- [DemoApp][Library] Create component - `Divider` ([#57](https://github.com/Orange-OpenSource/ouds-flutter/issues/57))
- [Library] `Switch` component (tokens library v0.11.0) ([##182](https://github.com/Orange-OpenSource/ouds-flutter/issues/182)
- [DemoApp] Create component - Radio Button ([#48](https://github.com/Orange-OpenSource/ouds-flutter/issues/48))
- [Tool] Added Dependabot configuration for automatic dependency updates ([#154](https://github.com/Orange-OpenSource/ouds-flutter/issues/154))
- [Library] `Divider` component (tokens library v0.11.0) ([#151](https://github.com/Orange-OpenSource/ouds-flutter/issues/151))

### Changed
- [DemoApp][Library] Enrich components documentation ([#133](https://github.com/Orange-OpenSource/ouds-flutter/issues/133))
- [DemoApp] Update translation files for consistency between platforms ([#194](https://github.com/Orange-OpenSource/ouds-flutter/issues/194))
- [DemoApp][Library] Token `grid` and `space` values now adapt based on device type ([#137](https://github.com/Orange-OpenSource/ouds-flutter/issues/137))
- [Library] Update LICENSE package ([#188](https://github.com/Orange-OpenSource/ouds-flutter/issues/188))
- [Library] Update README for OUDS libraries ([#186](https://github.com/Orange-OpenSource/ouds-flutter/issues/186))
- [DemoApp][Library] Refactor : create class global for icons names ([#152](https://github.com/Orange-OpenSource/ouds-flutter/issues/152))

### Fixed

- [DemoApp][Library] Use `context` access; removed `ouds_core/ouds_theme_contract` interdependency ([#136](https://github.com/Orange-OpenSource/ouds-flutter/issues/136))
- [DemoApp][Library] Clean project ouds_core ([#185](https://github.com/Orange-OpenSource/ouds-flutter/issues/185))

## [0.2.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.1.0...0.2.0) - 2025-05-13

### Added

- [DemoApp][Library] Create component - `Checkbox` ([#47](https://github.com/Orange-OpenSource/ouds-flutter/issues/47))
- [DemoApp][Library] RTL : activation of RTL mode / manage arabic language ([#134](https://github.com/Orange-OpenSource/ouds-flutter/issues/134))
- [DemoApp] Tokens: screen opacity ([#123](https://github.com/Orange-OpenSource/ouds-flutter/issues/84))
- [DemoApp] Migration of PNG Illustrations to SVG ([#143](https://github.com/Orange-OpenSource/ouds-flutter/issues/143))
- [DemoApp] Tokens: screen color ([#124](https://github.com/Orange-OpenSource/ouds-flutter/issues/124))
- [Library] `RadioButton` component (tokens library v0.11.0) ([#145](https://github.com/Orange-OpenSource/ouds-flutter/issues/145))
- [Library] `ControlItem` component (tokens library v0.11.0) ([#132](https://github.com/Orange-OpenSource/ouds-flutter/issues/132))
- [DemoApp] Tokens: screen elevation ([#84](https://github.com/Orange-OpenSource/ouds-flutter/issues/84))
- [Library] `Chekbox` component (tokens library v0.8.0) ([#120](https://github.com/Orange-OpenSource/ouds-flutter/issues/120))

### Changed

- [Library] Update of tokens (library version 0.11.0) ([#126](https://github.com/Orange-OpenSource/ouds-flutter/issues/126))
- Add @nouha06 and @AhmedAmineZr as new contributor in project ([#127](https://github.com/Orange-OpenSource/ouds-flutter/issues/127))
- [Library] Update of tokens (library version 0.10.0) ([#125](https://github.com/Orange-OpenSource/ouds-flutter/issues/125))
- [Library] Update of tokens (library version 0.9.0) ([#121](https://github.com/Orange-OpenSource/ouds-flutter/issues/121))

### Fixed

- [DemoApp] Limited `bottomsheet` height to half screen ([#89](https://github.com/Orange-OpenSource/ouds-flutter/issues/89))
- [DemoApp] A11y improvements for `bottomsheet` component ([#89](https://github.com/Orange-OpenSource/ouds-flutter/issues/89))
- [DemoApp] Update dart-define env to retrieve flavor ([#110](https://github.com/Orange-OpenSource/ouds-flutter/issues/110))
- [DemoApp] Icon system not adapting to light/dark mode ([#112](https://github.com/Orange-OpenSource/ouds-flutter/issues/112))

## [0.1.0](https://github.com/Orange-OpenSource/ouds-flutter/compare/0.0.0...0.1.0) - 2025-03-20

### Added

- [DemoApp][Library] Update GitHub configuration files ([#106](https://github.com/Orange-OpenSource/ouds-flutter/issues/106))
- [DemoApp][Library] Create component - Button ([#45](https://github.com/Orange-OpenSource/ouds-flutter/issues/45))
- [DemoApp] About page correct spacing and add flutter label ([#80](https://github.com/Orange-OpenSource/ouds-flutter/issues/80))
- [DemoApp] Update Flutter SDK to v3.6.0 ([#81](https://github.com/Orange-OpenSource/ouds-flutter/issues/81))
- [Library] Fix workflow to use dart doc ([#75](https://github.com/Orange-OpenSource/ouds-flutter/issues/75))
- [DemoApp] Add the about page ([#58](https://github.com/Orange-OpenSource/ouds-flutter/issues/58))
- [Library] Add typography tokens ([#43](https://github.com/Orange-OpenSource/ouds-flutter/issues/43))
- [Library] Add grid tokens ([#42](https://github.com/Orange-OpenSource/ouds-flutter/issues/42))
- [Library] Add size tokens ([#41](https://github.com/Orange-OpenSource/ouds-flutter/issues/41))
- [Library] Add space tokens ([#40](https://github.com/Orange-OpenSource/ouds-flutter/issues/40))
- [Library] Add elevation tokens ([#39](https://github.com/Orange-OpenSource/ouds-flutter/issues/39))
- [Library] Add border tokens ([#38](https://github.com/Orange-OpenSource/ouds-flutter/issues/38))
- [Library] Add opacity tokens ([#36](https://github.com/Orange-OpenSource/ouds-flutter/issues/36))
- [DemoApp] Rename demo app to DesignToolbox ([#28](https://github.com/Orange-OpenSource/ouds-flutter/issues/28))
- [Library] Implement tokens architecture ([#37](https://github.com/Orange-OpenSource/ouds-flutter/issues/37))
- [Library] Create the basics of a documentation ([#7](https://github.com/Orange-OpenSource/ouds-flutter/issues/7))
- [Library] Create the basic architecture of the library ([#4](https://github.com/Orange-OpenSource/ouds-flutter/issues/4))
- [DemoApp] Distribute demo app for validation ([#5](https://github.com/Orange-OpenSource/ouds-flutter/issues/13))
- [DemoApp] Create the basic architecture of the demo application ([#5](https://github.com/Orange-OpenSource/ouds-flutter/issues/5))