# Migration Guide

- [v1.3.1 → v2.0.0](#v131--v200)
- [v1.3.0 → v1.3.1](#v130--v131)
- [v1.2.0 → v1.3.0](#v120--v130)
- [v1.1.x → v1.2.0](#v11x--v120)
- [v1.0.0 → v1.1.1](#v100--v111)
- [Support](#support)

## v1.3.1 → v2.0.0

### Overview

This is a **major release** introducing rich text support across multiple components, significant design version updates, major token updates (v2.4.0 and v2.5.0), and an updated icon library (v1.6). It also brings improvements to the `Tab Bar`, `Toolbar Top`, `Badge`, `Tag`, `Input Tag`, `Text Input`, `Password Input`, `Phone Number Input`, `Filter Chip`, and `Suggestion Chip` components.

### Before You Begin

#### Prerequisites

- Use version 1.3.1 or older

### Breaking Changes

#### 1. Rich text support in multiple components

Several components have been updated to support rich text for their label/content parameters. The `label` (or equivalent text parameter) now accepts `InlineSpan` (e.g., `TextSpan`) in addition to plain `String`, enabling styled text, links, and mixed formatting.

**Affected components**: `OudsAlertMessage`, `OudsSwitch`, `OudsRadioButton`, `OudsCheckbox`, `OudsTextInput`, `OudsPinCodeInput`, `OudsPhoneNumberInput`

**Impact**: High (if you passed plain `String` labels, verify that the new API is compatible with your usage)

**Before (v1.3.x)**:
```dart
OudsSwitch(
  label: 'Enable notifications',
  value: _enabled,
  onChanged: (val) => setState(() => _enabled = val),
)

OudsTextInput(
  label: 'Email address',
  controller: _controller,
)
```

**After (v2.0.0)**:
```dart
OudsSwitch(
  label: TextSpan(text: 'Enable notifications'),
  value: _enabled,
  onChanged: (val) => setState(() => _enabled = val),
)

OudsTextInput(
  label: TextSpan(text: 'Email address'),
  controller: _controller,
)
```

**Required Action**:
- Wrap plain `String` labels with `TextSpan(text: '...')` where the API now expects `InlineSpan`
- Optionally use rich text to add styled portions, links, or mixed formatting

**Reason for Change**: Provide richer content support across input and control components

#### 2. Token breaking changes — v2.4.0 and v2.5.0

Design tokens have been updated to versions 2.4.0 and 2.5.0. These major token updates may rename or restructure token keys.

**Impact**: Medium (only if overriding tokens directly in a custom theme)

**Required Action**:
- If you override tokens in a custom theme, audit your overrides against the new token names
- Rebuild and check for compilation errors related to missing or renamed token properties

**Reason for Change**: Align with latest design system token specification

#### 3. Icon library update — v1.6

The OUDS icon library has been updated to version 1.6. Some icon names or asset paths may have changed.

**Impact**: Medium (if using icon constants from the library)

**Required Action**:
- Review any icon constants or asset paths you reference directly
- Update to the new icon names from v1.6 if you receive compilation errors or missing asset warnings

### Component Design Version Updates

Several components have been updated to align with new design specification versions. These changes are primarily visual and do not require code changes unless you override component tokens in a custom theme.

**Impact**: Low–Medium (visual changes; verify rendering after upgrading)

**Required Action**:
- Verify the visual appearance and accessibility behaviour of each updated component after upgrading
- If you override component tokens in a custom theme, check that your overrides are still valid

| Component | New Design Version |
|-----------|--------------------|
| `OudsTextInput` | v1.4 |
| `OudsPasswordInput` | v1.3 |
| `OudsFilterChip` / `OudsSuggestionChip` | v1.4 |
| `OudsBadge` (icon variant) | v1.3.0 |
| `OudsPhoneNumberInput` | v1.3 |
| `OudsTag` | v1.5 |
| `OudsInputTag` | v1.2 |

### Component Updates (Non-breaking)

| Component | Change |
|-----------|--------|
| Tab Bar | Updated selected tab indicator animation |
| Toolbar Top | Badge support added in trailing actions |
| Bottom Bar | Fixed inconsistent accessible order and zoom overlap |
| Password Input | Fixed label truncation when zoom is applied |
| Filter Chip | Fixed keyboard/Switch Access focus issue |
| Phone Number Input | Added interaction hint for accessibility |
| Input Tag | Fixed button role for accessibility |

### Compatibility

- **Backward Compatibility**: No (breaking changes in token API, icon API, and component label parameters)
- **v1.3.1 Support**: Ended with this release

---

> **Note**: v1.3.1 is a maintenance release with bug fixes and improvements. No migration is required.

## v1.3.0 → v1.3.1

### Overview

This is a maintenance and patch release focusing on bug fixes and accessibility improvements.

### Compatibility

- **Backward Compatibility**: Full (no breaking changes)
- **Migration Required**: No

---

## v1.2.0 → v1.3.0

### Overview

This release adds new components (`Bottom sheet`, `Alert message`, `Inline alert`), updates the `Pin code input` with optional keyboard type, and introduces new named constructors for `OudsTag` and `OudsBadge` components with deprecated old APIs.

### Before You Begin

#### Prerequisites

- Use version 1.2.0 or older

### Breaking Changes

#### 1. `OudsTag` — Migration to named constructors

The generic `OudsTag()` constructor is now **deprecated**. Use the new named constructors based on your tag type.

**Impact**: High

**Before (v1.2.x)**:
```
// Text only tag
OudsTag(
  label: 'My Tag',
  status: OudsTagStatus.positive,
  size: OudsTagSize.small,
)

// Tag with icon
OudsTag(
  label: 'Custom',
  layout: OudsTagLayout.textAndIcon,
  status: OudsTagStatus.neutral,
  icon: 'assets/custom_icon.svg',
)

// Tag with bullet
OudsTag(
  label: 'Info',
  layout: OudsTagLayout.textAndBullet,
  status: OudsTagStatus.info,
)
```

**After (v1.3.0)**:
```
// Text only tag
OudsTag.text(
  label: 'My Tag',
  status: Positive(),
  size: OudsTagSize.small,
)

// Tag with icon
OudsTag.icon(
  label: 'Custom',
  status: Neutral(icon: 'assets/custom_icon.svg'),
)

// Tag with bullet
OudsTag.bullet(
  label: 'Info',
  status: Info(),
)
```

**Required Action**:
- Replace `OudsTag(...)` with `OudsTag.text()`, `OudsTag.icon()`, or `OudsTag.bullet()`
- Replace `OudsTagStatus` enum values with `OudsIconStatus` classes:

| Old (`OudsTagStatus`)         | New (`OudsIconStatus`)   |
|-------------------------------|--------------------------|
| `OudsTagStatus.positive`     | `Positive()`             |
| `OudsTagStatus.negative`     | `Negative()`             |
| `OudsTagStatus.info`         | `Info()`                 |
| `OudsTagStatus.warning`      | `Warning()`              |
| `OudsTagStatus.accent`       | `Accent()`               |
| `OudsTagStatus.neutral`      | `Neutral()`              |

- Remove `icon` parameter; pass icon via status: `Accent(icon: 'path')` or `Neutral(icon: 'path')`
- Remove `layout` parameter; the layout is now determined by the named constructor

**Reason for Change**: Improve type safety, simplify API, and align `Tag` with the unified `OudsIconStatus` model shared with `Badge`

#### 2. `OudsBadge` — Migration to named constructors

The generic `OudsBadge()` constructor is now **deprecated**. Use the new named constructors.

**Impact**: High

**Before (v1.2.x)**:
```
// Standard badge (dot)
OudsBadge(
  status: OudsBadgeStatus.positive,
  size: OudsBadgeSize.medium,
)

// Badge with count
OudsBadge(
  status: OudsBadgeStatus.negative,
  size: OudsBadgeSize.large,
  label: '5',
)

// Badge with icon
OudsBadge(
  status: OudsBadgeStatus.info,
  size: OudsBadgeSize.large,
  icon: Icons.check,
)
```

**After (v1.3.0)**:
```
// Standard badge (dot)
OudsBadge.standard(
  status: Positive(),
  size: OudsBadgeSize.medium,
)

// Badge with count
OudsBadge.count(
  status: Negative(),
  size: OudsBadgeSize.large,
  label: '5',
)

// Badge with icon
OudsBadge.icon(
  status: Info(),
  size: OudsBadgeSize.large,
)
```

**Required Action**:
- Replace `OudsBadge(...)` with `OudsBadge.standard()`, `OudsBadge.count()`, or `OudsBadge.icon()`
- Replace `OudsBadgeStatus` enum values with `OudsIconStatus` classes (same mapping as Tag above)
- Remove `icon` parameter; icon is now driven by the `status` parameter

**Reason for Change**: Align Badge API with the unified `OudsIconStatus` model

#### 3. `OudsPinCodeInput` — new `keyboardType` parameter

A new optional `keyboardType` parameter has been added to `OudsPinCodeInput`. The default remains numeric.

**Impact**: Low (non-breaking, additive)

**Before (v1.2.x)**:
```
OudsPinCodeInput(
  length: 6,
  onCompleted: (code) => print(code),
)
```

**After (v1.3.0)**:
```
OudsPinCodeInput(
  length: 6,
  keyboardType: OudsPinCodeKeyboardType.alphanumeric, // optional, default is numeric
  onCompleted: (code) => print(code),
)
```

**Required Action**:
- No action required (backward compatible)
- Optionally use `keyboardType: OudsPinCodeKeyboardType.alphanumeric` if needed

#### 4. Tokens update — Bullet List and Alert component tokens

Component tokens for Bullet List and Alert have been updated to align with design tokens v1.9.0.

**Impact**: Low (only if using raw token values directly)

**Required Action**:
- If you override bullet list or alert tokens in a custom theme, verify your overrides still apply

### New Components Added

| Component | Class | Description |
|-----------|-------|-------------|
| Bottom Sheet | `OudsBottomSheetScaffold`, `OudsModalBottomSheet` | Standard and modal bottom sheets |
| Alert Message | `OudsAlertMessage` | Contextual alert messages with status |
| Inline Alert | `OudsInlineAlert` | Inline alert banners within content |

### Compatibility

- **Backward Compatibility**: Partial (deprecated constructors still work with warnings)
- **v1.2.0 Support**: Until release of next major version

---

## v1.1.x → v1.2.0

### Overview

This release introduces the `Toolbar Top` and `Top App Bar` components, adds French language support, and includes breaking changes to the `Tag` component configuration API.

### Before You Begin

#### Prerequisites

- Use version 1.1.x or older

### Breaking Changes

#### 1. Removal of `OudsTagConfig` from theme configuration

`OudsTagConfig` usage in `OudsThemeConfigModel` is now **deprecated**. Rounded corners are now built directly into the `OudsTag` component via the `roundedCorners` parameter.

**Impact**: High

**Before (v1.1.x)**:
```
OudsThemeConfigModel(
  tag: OudsTagConfig(roundedCorners: true),
  child: MyApp(),
)

OudsTag(
  label: 'My Tag',
  // corner style came from theme config
)
```

**After (v1.2.0)**:
```
OudsThemeConfigModel(
  // tag config deprecated, remove it
  child: MyApp(),
)

OudsTag(
  label: 'My Tag',
  roundedCorners: true, // now a direct parameter on the component
)
```

**Required Action**:
- Remove `tag: OudsTagConfig(...)` from `OudsThemeConfigModel`
- Use `roundedCorners` parameter directly on `OudsTag` widget

**Reason for Change**: Simplify the Tag API and align with design specifications ([#598](https://github.com/Orange-OpenSource/ouds-flutter/issues/598))

#### 2. Updated status icons in `Badge` and `Tag`

The icon assets used for status indicators in `OudsBadge` and `OudsTag` have been updated to use OUDS icon status system.

**Impact**: Medium

**Required Action**:
- If you referenced specific icon assets for badge/tag status, update to the new icon set
- Verify your custom status icons still render correctly

**Reason for Change**: Align with updated design specifications ([#597](https://github.com/Orange-OpenSource/ouds-flutter/issues/597))

### New Components Added

| Component | Class | Description |
|-----------|-------|-------------|
| Toolbar Top | `OudsToolbarTop` | iOS-style toolbar with leading/trailing actions |
| Top App Bar | `OudsTopAppBar` | Material-style top app bar with title and actions |

Configuration uses `OudsTopBarActionConfig` factory constructors:
```
OudsTopBarActionConfig.icon(icon: 'assets/icon.svg', onActionPressed: () {})
OudsTopBarActionConfig.text(actionLabel: 'Done', onActionPressed: () {})
OudsTopBarActionConfig.back(onActionPressed: () => Navigator.pop(context))
OudsTopBarActionConfig.close(onActionPressed: () => Navigator.pop(context))
OudsTopBarActionConfig.none() // No action
```

### Compatibility

- **Backward Compatibility**: No (due to `OudsTagConfig` deprecation)
- **v1.1.x Support**: Until release of next minor version

---

## v1.0.0 → v1.1.1

### Overview

This release introduces the `Orange Compact` theme, adds `Navigation bar` and `Bottom Navigation` components, deprecates `OrangeTheme`, updates `OudsButton` to full width, and updates tokens to v1.9.0.

### Before You Begin

#### Prerequisites

- Use version 1.0.0

### Breaking Changes

#### 1. Deprecated `OrangeTheme` — Use `OudsOrangeTheme` instead

`OrangeTheme` has been marked as `@deprecated`. Use `OudsOrangeTheme` instead.

**Impact**: Medium

**Before (v1.0.0)**:
```
import 'package:ouds_theme_orange/ouds_theme_orange.dart';

OrangeTheme(
  child: MyApp(),
)
```

**After (v1.1.x)**:
```
import 'package:ouds_theme_orange/ouds_theme_orange.dart';

OudsOrangeTheme(
  child: MyApp(),
)
```

**Required Action**:
- Replace all `OrangeTheme` usages with `OudsOrangeTheme`

**Reason for Change**: Consistent naming convention with `Ouds` prefix ([#610](https://github.com/Orange-OpenSource/ouds-flutter/issues/610))

#### 2. `OudsButton` — Full width by default

`OudsButton` now takes the full available width by default.

**Impact**: Medium

**Before (v1.0.0)**:
```
// Button sized to its content
OudsButton(
  label: 'Click me',
  onPressed: () {},
)
```

**After (v1.1.x)**:
```
// Button now takes full width by default
// To restore old behavior, constrain it:
SizedBox(
  width: 200, // or use IntrinsicWidth
  child: OudsButton(
    label: 'Click me',
    onPressed: () {},
  ),
)
```

**Required Action**:
- If you relied on the button being sized to its content, wrap it in a `SizedBox` or `IntrinsicWidth`

**Reason for Change**: Align with design specifications ([#577](https://github.com/Orange-OpenSource/ouds-flutter/issues/577))

#### 3. New `Orange Compact` theme package

A new theme `ouds_theme_orange_compact` is available for compact layouts.

**Impact**: Low (additive)

```
// Add to pubspec.yaml
dependencies:
  ouds_theme_orange_compact: ^1.1.1
```

```
import 'package:ouds_theme_orange_compact/ouds_theme_orange_compact.dart';

OudsOrangeCompactTheme(
  child: MyApp(),
)
```

**Required Action**:
- No action required unless you want to use the compact theme

#### 4. Token updates — v1.9.0

Input tag tokens and Orange Compact theme tokens have been updated.

**Impact**: Low

**Required Action**:
- If you override input tag tokens in a custom theme, verify your overrides still apply

### New Components Added

| Component | Class | Description |
|-----------|-------|-------------|
| Navigation Bar | `OudsNavigationBar` | Material navigation bar with items |
| Bottom Navigation | `OudsBottomBar` | Bottom navigation bar |
| Navigation Bar Item | `OudsNavigationBarItem` | Individual navigation item |

```
OudsNavigationBar(
  selectedIndex: _currentIndex,
  onDestinationSelected: (index) => setState(() => _currentIndex = index),
  items: [
    OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
    OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
    OudsNavigationBarItem(icon: 'assets/profile.svg', label: 'Profile'),
  ],
)
```

### Compatibility

- **Backward Compatibility**: Partial (deprecated APIs still work with warnings)
- **v1.0.0 Support**: Until release of next minor version

---

## Support

If you encounter issues during migration:
- [Open an issue](https://github.com/Orange-OpenSource/ouds-flutter/issues)
- [Check existing discussions](https://github.com/Orange-OpenSource/ouds-flutter/discussions)
- Contact the maintainers listed in [MAINTAINERS.md](.github/MAINTAINERS.md)

