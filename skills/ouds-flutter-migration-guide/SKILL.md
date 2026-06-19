---
name: ouds-flutter-migration-guide
description: How to migrate to OUDS Flutter — from native Flutter components, custom/branded components, or across OUDS library versions — with before/after mappings and required actions
license: MIT
---

# OUDS Flutter Migration Guide

> **Agent optimization**: See [copilot-instructions.md §9](../../.github/copilot-instructions.md#9-agent-response-optimization-) for token-efficient response guidelines.

This skill applies to migration work in the OUDS Flutter repository. Use it for Flutter adoption and version migrations, not for OUDS web, Android native, or iOS native platforms.

Use this skill when a user asks how to:

- **adopt** OUDS Flutter in a new or existing app (from native Flutter widgets or custom components)
- **migrate** existing OUDS Flutter code across library versions
- **understand** breaking changes between released OUDS versions

> ⚙️ Always load **`ouds-flutter-framework-usage`** alongside this skill to get accurate component APIs, token accessors and state patterns.

---

## Part 1 — Adoption: Native Flutter / Material → OUDS Flutter

### 1.1 Quick decision checklist

Before touching any widget, answer these questions:

1. Is the app already wrapped in `OudsTheme`? → if not, do §1.2 first.
2. Does a direct OUDS equivalent exist for the widget? → use the mapping table in §1.3.
3. Does the widget use hardcoded colors / sizes / text styles? → replace them using §1.4.
4. Is the widget interactive? → verify accessibility in §1.6.

---

### 1.2 App setup — add `OudsTheme` once

**Before:**

```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: const HomeScreen(),
    );
  }
}
```

**After:**

```dart
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange/orange_font_service.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OrangeFontService.instance.loadFromCdn();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = OrangeTheme(OrangeFontService.instance.fontFamily);
    return MaterialApp(
      theme: theme.themeData,
      darkTheme: theme.darkThemeData,
      builder: (context, child) => OudsTheme(
        themeContract: theme,
        themeMode: ThemeMode.system,
        onColoredSurface: false,
        child: child ?? const SizedBox.shrink(),
      ),
      localizationsDelegates: const [
        OudsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: OudsLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
```

> Choose the theme that matches the brand: `OrangeTheme`, `OrangeCompactTheme`, `SoshTheme`, `WireframeTheme`.

---

### 1.3 Component mapping — Material / Flutter → OUDS

| Native Flutter / Material | OUDS equivalent | Import path |
|---------------------------|-----------------|-------------|
| `ElevatedButton` / `FilledButton` / `OutlinedButton` / `TextButton` | `OudsButton` (use `appearance:`) | `package:ouds_core/components/button/ouds_button.dart` |
| `TextField` / `TextFormField` | `OudsTextField` | `package:ouds_core/components/form_input/ouds_text_input.dart` |
| `Switch` | `OudsSwitch` | `package:ouds_core/components/switch/ouds_switch.dart` |
| `Checkbox` | `OudsCheckbox` | `package:ouds_core/components/checkbox/ouds_checkbox.dart` |
| `Radio` / `RadioListTile` | `OudsRadioButton` | `package:ouds_core/components/radio_button/ouds_radio_button.dart` |
| `FilterChip` | `OudsFilterChip` | `package:ouds_core/components/chip/ouds_filter_chip.dart` |
| `ActionChip` / `SuggestionChip` | `OudsSuggestionChip` | `package:ouds_core/components/chip/ouds_suggestion_chip.dart` |
| `Divider` / `VerticalDivider` | `OudsDivider.horizontal()` / `OudsDivider.vertical()` | `package:ouds_core/components/divider/ouds_divider.dart` |
| `InkWell` / `GestureDetector` (link) | `OudsLink` | `package:ouds_core/components/link/ouds_link.dart` |
| `NavigationBar` / `BottomNavigationBar` | `OudsNavigationBar` | `package:ouds_core/components/navigation/ouds_navigation_bar.dart` |
| `AppBar` / `SliverAppBar` | `OudsTopBar` / `OudsTopAppBar` | `package:ouds_core/components/top_bar/` |
| `SnackBar` / `Banner` | `OudsAlertMessage` / `OudsInlineAlert` | `package:ouds_core/components/alert/` |
| `showModalBottomSheet` | `OudsModalBottomSheet` | `package:ouds_core/components/bottom_sheet/ouds_modal_bottom_sheet.dart` |
| `DraggableScrollableSheet` (persistent) | `OudsBottomSheetScaffold` | `package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart` |
| `CircularProgressIndicator` | `OudsCircularProgressIndicator` | `package:ouds_core/components/progress/` |
| `Badge` (Material 3) | `OudsBadge.standard()` / `.count()` / `.icon()` | `package:ouds_core/components/badge/ouds_badge.dart` |
| `Chip` (read-only label) | `OudsTag.text()` / `.icon()` / `.bullet()` | `package:ouds_core/components/tag/ouds_tag.dart` |

> If no OUDS equivalent exists yet, keep the native widget but replace hardcoded style values with OUDS tokens (see §1.4).

---

### 1.4 Replacing hardcoded values with OUDS tokens

Always use `OudsTheme.of(context)` — never hardcode colors, sizes or text styles.

#### Colors

```dart
// Before
Container(color: const Color(0xFFFF7900))

// After
final colors = OudsTheme.of(context).colorScheme(context);
Container(color: colors.actionEnabled)
```

Common semantic color accessors:

| Intent | Token example |
|--------|---------------|
| Primary action | `colors.actionEnabled` |
| Destructive / error | `colors.feedbackNegativeText` |
| Surface background | `colors.bgPrimary` |
| On-surface text | `colors.contentDefault` |
| Disabled | `colors.actionDisabled` |

#### Typography

```dart
// Before
Text('Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))

// After
final typography = OudsTheme.of(context).typographyTokens;
Text('Title', style: typography.typeHeadingMediumLarge(context))
```

Common typography token families: `typeDisplayLarge`, `typeHeadingMediumLarge`, `typeLabelDefaultMedium`, `typeBodyDefaultMedium`, `typeCodeMedium`.

#### Spacing

```dart
// Before
Padding(padding: const EdgeInsets.all(16))

// After
final spaces = OudsTheme.of(context).spaceScheme(context);
Padding(padding: EdgeInsets.all(spaces.fixedMedium))
```

Common space tokens: `fixedNone`, `fixedSmash`, `fixedShortest`, `fixedShorter`, `fixedShort`, `fixedMedium`, `fixedTall`, `fixedTaller`, `fixedTallest`.

---

### 1.5 Key migration examples

#### `ElevatedButton` → `OudsButton`

```dart
// Before
ElevatedButton(
  onPressed: () {},
  child: const Text('Confirm'),
)

// After
import 'package:ouds_core/components/button/ouds_button.dart';

OudsButton(
  label: 'Confirm',
  appearance: OudsButtonAppearance.defaultAppearance,
  onPressed: () {},
)
```

Available appearances: `defaultAppearance`, `strong`, `minimal`, `loading`, `negative`.

> ⚠️ `OudsButton` is full-width by default. Wrap in `SizedBox` or `IntrinsicWidth` if you need content-sized behavior.

---

#### `TextField` / `TextFormField` → `OudsTextField`

```dart
// Before
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
    hintText: 'you@example.com',
    errorText: 'Invalid email',
  ),
)

// After
import 'package:ouds_core/components/form_input/ouds_text_input.dart';

OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Email',
    hintText: 'you@example.com',
    errorText: 'Invalid email',
  ),
)
```

State parameters: `readOnly`, `enabled`, `OudsInputDecoration(loader: true)`.
> **⛔ Forbidden**: `loader: true` + `errorText != null` simultaneously → assertion error.

---

#### `Switch` → `OudsSwitch`

```dart
// Before
Switch(value: isOn, onChanged: (v) => setState(() => isOn = v))

// After
import 'package:ouds_core/components/switch/ouds_switch.dart';

OudsSwitch(
  value: isOn,
  onChanged: (v) => setState(() => isOn = v),
)
```

Disabled: `onChanged: null`. Read-only: `readOnly: true` (keep `onChanged` set).

---

#### `Checkbox` → `OudsCheckbox`

```dart
// Before
Checkbox(value: isChecked, onChanged: (v) => setState(() => isChecked = v ?? false))

// After
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';

OudsCheckbox(
  value: isChecked,
  onChanged: (v) => setState(() => isChecked = v),
)
```

Error state: add `isError: true`. Tristate / indeterminate: add `tristate: true, value: null`.

---

#### `BottomNavigationBar` / `NavigationBar` → `OudsNavigationBar`

```dart
// Before
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
)

// After
import 'package:ouds_core/components/navigation/ouds_navigation_bar.dart';

OudsNavigationBar(
  destinations: [
    OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
    OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
  ],
  selectedIndex: _selectedIndex,
  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
)
```

Supports 3–5 destinations. Translucent variant: add `translucent: true` + `Scaffold(extendBody: true)`.

---

#### `AppBar` → `OudsTopBar`

```dart
// Before
AppBar(
  title: const Text('Settings'),
  leading: BackButton(),
)

// After
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';

OudsTopBar(
  title: 'Settings',
  leadingActions: [
    OudsTopBarActionConfig.back(
      previousPageTitle: 'Back',
      onActionPressed: () {},
    ),
  ],
)
```

---

#### `SnackBar` → `OudsAlertMessage` / `OudsInlineAlert`

```dart
// Before
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Profile updated')),
)

// After — persistent alert in the content tree
import 'package:ouds_core/components/alert/ouds_alert_message.dart';

OudsAlertMessage(
  label: 'Profile updated.',
  status: Positive(),
  onClose: () {},
)

// After — lightweight inline alert (no close button)
import 'package:ouds_core/components/alert/ouds_inline_alert.dart';

OudsInlineAlert(label: 'Profile updated.', status: Positive())
```

---

### 1.6 Accessibility — migration-specific points

> For the full a11y reference, load the **`ouds-flutter-accessibility`** skill.

Migration-specific actions to perform after replacing native widgets with OUDS equivalents:

- [ ] Remove hardcoded `Semantics(label: '...')` strings → use `OudsLocalizations.of(context)` instead
- [ ] Remove `MediaQuery.textScalerOf(context)` overrides — OUDS typography tokens handle scaling automatically
- [ ] Remove `SystemChrome.setPreferredOrientations` locks — OUDS supports both orientations
- [ ] Replace `Icon(Icons.xxx)` with SVG asset paths where OUDS components require it (e.g. `OudsNavigationBarItem(icon: 'assets/...')`)
- [ ] Add `semanticsLabel` on every `OudsBadge` — color is the only visual differentiator
- [ ] Run TalkBack (Android) and VoiceOver (iOS) to verify after migration

---

## Part 2 — Adoption: Custom / branded components → OUDS Flutter

### 2.1 Decision tree

```
Custom component
       │
       ▼
Does an OUDS equivalent exist? (see §1.3)
  ├─ Yes → Replace entirely
  └─ No  ─┐
           ▼
   Is the custom widget purely visual (no interaction)?
     ├─ Yes → Keep widget structure, replace hardcoded values with OUDS tokens (§2.2 – §2.4)
     └─ No  → Wrap in Semantics, replace state management patterns (§2.5)
```

---

### 2.2 Migrating custom colors → OUDS color tokens

Custom components often define their own color palette (constants, extension on `ThemeData`, or `ColorScheme` overrides). Replace all of these with the OUDS color scheme.

**Before:**

```dart
class AppColors {
  static const primary = Color(0xFFFF7900);
  static const error   = Color(0xFFCD3C14);
  static const surface = Color(0xFFFFFFFF);
}

Container(color: AppColors.primary)
```

**After:**

```dart
final colors = OudsTheme.of(context).colorScheme(context);
Container(color: colors.actionEnabled)
```

**Mapping approach:**

| Semantic intent | OUDS accessor example |
|-----------------|-----------------------|
| Brand / primary action | `colors.actionEnabled` |
| Hover / pressed action | `colors.actionHover` / `colors.actionPressed` |
| Error / destructive | `colors.feedbackNegativeText` |
| Success | `colors.feedbackPositiveText` |
| Warning | `colors.feedbackWarningText` |
| Informational | `colors.feedbackInfoText` |
| Text on surface | `colors.contentDefault` |
| Muted / secondary text | `colors.contentMuted` |
| Background primary | `colors.bgPrimary` |
| Background secondary | `colors.bgSecondary` |
| Overlay / scrim | `colors.overlayDefault` |

> Browse the full list in `ouds_theme_contract/lib/tokens/semantic/` (generated by Tokenator — read-only).

---

### 2.3 Migrating custom text styles → OUDS typography tokens

**Before:**

```dart
const TextStyle titleStyle = TextStyle(
  fontFamily: 'HelvNeue',
  fontSize: 24,
  fontWeight: FontWeight.w700,
  height: 1.25,
);

Text('Title', style: titleStyle)
```

**After:**

```dart
final typography = OudsTheme.of(context).typographyTokens;
Text('Title', style: typography.typeHeadingMediumLarge(context))
```

**Typography token families:**

| Role | Token example |
|------|---------------|
| Hero / display | `typeDisplayLarge(context)` |
| Section heading (large) | `typeHeadingMediumLarge(context)` |
| Section heading (small) | `typeHeadingMediumSmall(context)` |
| Label / button text | `typeLabelDefaultMedium(context)` |
| Body paragraph | `typeBodyDefaultMedium(context)` |
| Caption / hint | `typeBodyDefaultSmall(context)` |
| Monospace / code | `typeCodeMedium(context)` |

> All tokens automatically respect the system font scale — never override `MediaQuery.textScalerOf`.

---

### 2.4 Migrating custom spacing → OUDS space tokens

**Before:**

```dart
const double kPaddingSmall  = 8.0;
const double kPaddingMedium = 16.0;
const double kPaddingLarge  = 24.0;

Padding(padding: const EdgeInsets.all(kPaddingMedium))
```

**After:**

```dart
final spaces = OudsTheme.of(context).spaceScheme(context);
Padding(padding: EdgeInsets.all(spaces.fixedMedium))
```

**Space token reference:**

| Custom value (example) | OUDS token |
|------------------------|------------|
| 0 | `spaces.fixedNone` |
| 2 | `spaces.fixedSmash` |
| 4 | `spaces.fixedShortest` |
| 8 | `spaces.fixedShorter` |
| 12 | `spaces.fixedShort` |
| 16 | `spaces.fixedMedium` |
| 24 | `spaces.fixedTall` |
| 32 | `spaces.fixedTaller` |
| 40+ | `spaces.fixedTallest` |

---

### 2.5 Migrating custom interactive components

Custom interactive widgets (custom buttons, toggles, selectors) usually combine a `GestureDetector` / `InkWell`, a custom `BoxDecoration` for visual state, and a `StatefulWidget` for selected / pressed / disabled states.

**Migration steps:**

1. Check §1.3 — if an OUDS equivalent exists, replace entirely.
2. If not, keep the widget skeleton and:
   - Replace `BoxDecoration` colors with `OudsTheme.of(context).colorScheme(context)`.
   - Replace `TextStyle` with `OudsTheme.of(context).typographyTokens`.
   - Replace padding / border-radius constants with `spaceScheme` / `sizeScheme` tokens.
   - Wrap the root in `Semantics` with the appropriate flags.

**Before — custom toggle button:**

```dart
class CustomToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const CustomToggle({required this.value, required this.onChanged, super.key});
  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          color: widget.value ? const Color(0xFFFF7900) : const Color(0xFFCCCCCC),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
```

**After — replace with `OudsSwitch` (preferred):**

```dart
import 'package:ouds_core/components/switch/ouds_switch.dart';

OudsSwitch(
  value: _isEnabled,
  onChanged: (v) => setState(() => _isEnabled = v),
)
```

**After — if no OUDS equivalent, apply tokens + Semantics:**

```dart
class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    final colors = OudsTheme.of(context).colorScheme(context);
    final sizes  = OudsTheme.of(context).sizeScheme(context);

    return Semantics(
      toggled: widget.value,
      button: true,
      child: GestureDetector(
        onTap: () => widget.onChanged(!widget.value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: sizes.iconWithLabelSizeShort,
          height: sizes.iconSizeMedium,
          decoration: BoxDecoration(
            color: widget.value
                ? colors.actionEnabled   // replaces hardcoded orange
                : colors.actionDisabled, // replaces hardcoded grey
            borderRadius: BorderRadius.circular(sizes.iconSizeMedium / 2),
          ),
        ),
      ),
    );
  }
}
```

---

### 2.6 Migrating custom cards and containers

| What | Replace with |
|------|-------------|
| `color: const Color(0xFF...)` | `colors.bgSecondary` or `colors.bgPrimary` |
| `border: Border.all(color: ...)` | `colors.borderDefault` or `colors.borderStrong` |
| `borderRadius: BorderRadius.circular(12)` | `theme.sizeScheme(context)` radius tokens when available |
| `Padding(padding: const EdgeInsets.all(16))` | `spaces.fixedMedium` |

**Before:**

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: const Color(0xFFDDDDDD)),
  ),
  child: content,
)
```

**After:**

```dart
final colors = OudsTheme.of(context).colorScheme(context);
final spaces = OudsTheme.of(context).spaceScheme(context);

Container(
  padding: EdgeInsets.all(spaces.fixedMedium),
  decoration: BoxDecoration(
    color: colors.bgPrimary,
    borderRadius: BorderRadius.circular(12), // keep until radius tokens are available
    border: Border.all(color: colors.borderDefault),
  ),
  child: content,
)
```

---

### 2.7 Customization via `OudsThemeConfigModel` and `OudsThemeTweak`

When migrating a component that had local visual overrides (rounded corners, inverted theme), use the OUDS config and tweak mechanisms instead of custom style parameters.

```dart
// Local config override (e.g. non-rounded buttons in a specific area)
OudsThemeConfigModel(
  button: OudsButtonConfig(rounded: false),
  textInput: OudsTextInputConfig(rounded: true),
  child: MySection(),
)

// Force dark mode locally (e.g. hero banner on a colored surface)
OudsThemeTweak(
  tweak: OudsThemeTweakType.forceDark,
  child: MyHeroBanner(),
)
```

---

### 2.8 Migration validation checklist (custom components)

- [ ] No `Color(0xFF...)` literal remaining — all colors from `colorScheme(context)`
- [ ] No `TextStyle(fontSize: ...)` literal remaining — all styles from `typographyTokens`
- [ ] No magic number padding/margin — all values from `spaceScheme(context)` or `sizeScheme(context)`
- [ ] All user-facing strings use `OudsLocalizations.of(context)` or app localizations
- [ ] `dart format .` → `flutter analyze --no-pub` → zero errors
- [ ] Full accessibility checklist completed → load **`ouds-flutter-accessibility`** skill for details

---

## Part 3 — OUDS version-to-version migration

Use this part when the codebase **already uses OUDS Flutter** and you need to update to a newer OUDS version.

### 3.1 Quick triage

Before proposing changes:

1. Identify the source version and target version.
2. Check whether the migration is additive, deprecated-but-compatible, or breaking.
3. Search for deprecated constructors and theme config usage in the affected code.
4. Prefer direct API migrations shown in `MIGRATION.md` over guessed replacements.

---

### 3.2 Version summary

| Migration | Compatibility | Migration required | Main topics |
|-----------|---------------|--------------------|-------------|
| `v1.3.0 → v1.3.1` | Full | No | Maintenance release, bug fixes, accessibility improvements |
| `v1.2.0 → v1.3.0` | Partial | Yes for deprecated APIs | `OudsTag` named constructors, `OudsBadge` named constructors, `OudsPinCodeInput.keyboardType`, new alert/bottom-sheet components |
| `v1.1.x → v1.2.0` | No | Yes | `OudsTagConfig` removal from theme config, status icon updates, top bar components, French support |
| `v1.0.0 → v1.1.1` | Partial | Usually yes | `OrangeTheme` deprecation, `OudsButton` full-width behavior, Orange Compact theme, token updates |

---

### 3.3 High-impact migrations

#### 3.3.1 `OudsTag` → named constructors (`v1.2.x` → `v1.3.0`)

**Before:**

```dart
OudsTag(
  label: 'My Tag',
  status: OudsTagStatus.positive,
  size: OudsTagSize.small,
)

OudsTag(
  label: 'Custom',
  layout: OudsTagLayout.textAndIcon,
  status: OudsTagStatus.neutral,
  icon: 'assets/custom_icon.svg',
)
```

**After:**

```dart
OudsTag.text(
  label: 'My Tag',
  status: Positive(),
  size: OudsTagSize.small,
)

OudsTag.icon(
  label: 'Custom',
  status: Neutral(icon: 'assets/custom_icon.svg'),
)
```

**Required actions:**

- Replace `OudsTag(...)` with `OudsTag.text(...)`, `OudsTag.icon(...)`, or `OudsTag.bullet(...)`.
- Replace `OudsTagStatus` enum values with `OudsIconStatus` classes.
- Remove `layout` and `icon` parameters — move the icon into `Accent(icon: ...)` or `Neutral(icon: ...)`.

**Status mapping:**

| Old | New |
|-----|-----|
| `OudsTagStatus.positive` | `Positive()` |
| `OudsTagStatus.negative` | `Negative()` |
| `OudsTagStatus.info` | `Info()` |
| `OudsTagStatus.warning` | `Warning()` |
| `OudsTagStatus.accent` | `Accent()` |
| `OudsTagStatus.neutral` | `Neutral()` |

---

#### 3.3.2 `OudsBadge` → named constructors (`v1.2.x` → `v1.3.0`)

**Before:**

```dart
OudsBadge(
  status: OudsBadgeStatus.positive,
  size: OudsBadgeSize.medium,
)

OudsBadge(
  status: OudsBadgeStatus.negative,
  size: OudsBadgeSize.large,
  label: '5',
)
```

**After:**

```dart
OudsBadge.standard(
  status: Positive(),
  size: OudsBadgeSize.medium,
)

OudsBadge.count(
  status: Negative(),
  size: OudsBadgeSize.large,
  label: '5',
)
```

**Required actions:**

- Replace `OudsBadge(...)` with `OudsBadge.standard(...)`, `OudsBadge.count(...)`, or `OudsBadge.icon(...)`.
- Replace `OudsBadgeStatus` with `OudsIconStatus` classes (same mapping as `OudsTag`).
- Remove the `icon` parameter — icon is now derived from `status`.

---

#### 3.3.3 Remove `OudsTagConfig` from `OudsThemeConfigModel` (`v1.1.x` → `v1.2.0`)

**Before:**

```dart
OudsThemeConfigModel(
  tag: OudsTagConfig(roundedCorners: true),
  child: MyApp(),
)
```

**After:**

```dart
OudsThemeConfigModel(
  child: MyApp(),
)

OudsTag.text(
  label: 'My Tag',
  roundedCorners: true,
  status: Positive(),
)
```

**Required actions:**

- Remove `tag: OudsTagConfig(...)` from `OudsThemeConfigModel`.
- Move tag corner styling to the widget itself via `roundedCorners`.

---

#### 3.3.4 `OrangeTheme` deprecation (`v1.0.0` → `v1.1.1`)

`MIGRATION.md` documents a move from `OrangeTheme` to `OudsOrangeTheme`.

Use `MIGRATION.md` as source of truth, but verify the currently available theme API in the repository first — the current codebase exposes `OrangeTheme` via `ouds_theme_orange/lib/orange_theme.dart`.

**Migration-safe approach:**

1. Inspect the imports and currently installed package version.
2. Align the code with the version actually installed.
3. Do not blindly apply this step without confirming the theme API surface.

---

### 3.4 Medium and low impact migrations

#### `OudsButton` full width by default (`v1.0.0` → `v1.1.1`)

If legacy UI relied on content-sized buttons, constrain width explicitly:

```dart
SizedBox(
  width: 200,
  child: OudsButton(
    label: 'Click me',
    onPressed: () {},
    appearance: OudsButtonAppearance.defaultAppearance,
  ),
)
```

Alternative: `IntrinsicWidth` wrapper.

#### `OudsPinCodeInput.keyboardType` (`v1.2.0` → `v1.3.0`)

Additive, not breaking:

```dart
OudsPinCodeInput(
  controllers: List.generate(6, (_) => TextEditingController()),
  keyboardType: OudsPinCodeKeyboardType.alphanumeric,
)
```

If not needed, keep the default numeric behavior.

#### Token updates

When the migration guide mentions token updates:

- review any custom theme overrides,
- verify that component-specific overrides still apply,
- do **not** manually edit generated token files.

---

### 3.5 New components introduced by version

#### `v1.2.0 → v1.3.0`

| Component | Class |
|-----------|-------|
| Bottom Sheet | `OudsBottomSheetScaffold`, `OudsModalBottomSheet` |
| Alert Message | `OudsAlertMessage` |
| Inline Alert | `OudsInlineAlert` |

#### `v1.1.x → v1.2.0`

| Component | Class |
|-----------|-------|
| Toolbar Top | `OudsToolbarTop` |
| Top App Bar | `OudsTopAppBar` |

#### `v1.0.0 → v1.1.1`

| Component | Class |
|-----------|-------|
| Navigation Bar | `OudsNavigationBar` |
| Bottom Navigation | `OudsBottomBar` |
| Navigation Bar Item | `OudsNavigationBarItem` |

---

### 3.6 Migration workflow for code changes

When performing a version-to-version migration:

1. Search for deprecated symbols:
   - `OudsTag(`
   - `OudsBadge(`
   - `OudsTagStatus`
   - `OudsBadgeStatus`
   - `OudsTagConfig`
2. Replace APIs using the before/after mappings in §3.3.
3. Update related demo screens if public APIs changed.
4. Update dartdoc examples if they still show deprecated usage.
5. Run the required verification steps:

```bash
dart format .
flutter analyze --no-pub
(cd app && flutter test)
(cd ouds_core && flutter test)
```

Also run tests in every other modified package that has a `test/` directory.

---

## Support

If a migration is unclear or incomplete:

- read `MIGRATION.md` first,
- inspect current implementations in `ouds_core/lib/components/` and theme packages,
- then use the repository support channels documented in `MIGRATION.md`:
  - GitHub issues
  - GitHub discussions
  - `.github/MAINTAINERS.md`

