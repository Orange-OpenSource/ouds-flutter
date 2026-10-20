---
name: ouds-flutter-framework-usage
description: How to set up and use the OUDS Flutter framework with imports, themes, tokens, localizations, theme tweaks, and available components with code examples
license: MIT
---

# OUDS Flutter Framework Usage

> **Agent optimization**: See [copilot-instructions.md §9](../../.github/copilot-instructions.md#9-agent-response-optimization-) for token-efficient response guidelines.

This skill applies to the OUDS Flutter repository. Use it for Flutter components, themes, tokens and localizations, not for OUDS web, Android native, or iOS native platforms.

## 1. Basic setup

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange/orange_font_service.dart';

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
      builder: (context, child) {
        return OudsTheme(
          themeContract: theme,
          themeMode: ThemeMode.system,
          onColoredSurface: false,
          child: child ?? const SizedBox.shrink(),
        );
      },
      localizationsDelegates: const [
        OudsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: OudsLocalizations.supportedLocales,
      home: const Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}
```

---

## 2. Imports

Import components directly from their package path. Do **not** use or create a root barrel file for `ouds_core`.

| Package | When |
|---------|------|
| `package:ouds_core/components/...` | Use OUDS widgets |
| `package:ouds_theme_contract/ouds_theme.dart` | Read the active theme from context |
| `package:ouds_theme_orange/orange_theme.dart` | Orange brand theme |
| `package:ouds_theme_orange_compact/orange_compact_theme.dart` | Orange Compact theme |
| `package:ouds_theme_sosh/ouds_theme_sosh.dart` | Sosh theme |
| `package:ouds_theme_wireframe/ouds_theme_wireframe.dart` | Wireframe theme |
| `package:ouds_core/l10n/gen/ouds_localizations.dart` | OUDS accessibility and default strings |

Examples:

```dart
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
```

---

## 3. Themes

Inject an `OudsTheme` near the root of the app and consume it with `OudsTheme.of(context)`.

```dart
final theme = OudsTheme.of(context);
final colors = theme.colorScheme(context);
final spaces = theme.spaceScheme(context);
final typography = theme.typographyTokens;
final components = theme.componentsTokens(context);
```

Available themes in this repository:

- `OrangeTheme`
- `OrangeCompactTheme`
- `SoshTheme`
- `WireframeTheme`

### Theme config and tweaks

Use `OudsThemeConfigModel` to tune component configuration and `OudsThemeTweak` to locally force or invert theme mode.

```dart
OudsThemeConfigModel(
  button: OudsButtonConfig(rounded: false),
  textInput: OudsTextInputConfig(rounded: true),
  child: OudsTheme(
    themeContract: theme,
    themeMode: ThemeMode.system,
    onColoredSurface: false,
    child: child,
  ),
)
```

```dart
OudsThemeTweak(
  tweak: OudsThemeTweakType.forceDark,
  child: MyPreview(),
)
```

---

## 4. Token namespaces

| Accessor | Content |
|----------|---------|
| `theme.colorScheme(context)` | Active semantic color scheme |
| `theme.spaceScheme(context)` | Active spacing scheme |
| `theme.sizeScheme(context)` | Active size scheme |
| `theme.gridScheme(context)` | Active grid scheme |
| `theme.typographyTokens` | Typography tokens |
| `theme.componentsTokens(context)` | Component token groups |
| `theme.providersTokens(context)` | Combined theme providers |

Common component token groups include:

- `theme.componentsTokens(context).button`
- `theme.componentsTokens(context).badge`
- `theme.componentsTokens(context).chip`
- `theme.componentsTokens(context).divider`
- `theme.componentsTokens(context).icon`
- `theme.componentsTokens(context).link`
- `theme.componentsTokens(context).pinCodeInput`
- `theme.componentsTokens(context).radioButton`
- `theme.componentsTokens(context).switch`
- `theme.componentsTokens(context).tag`
- `theme.componentsTokens(context).textInput`

---

## 5. Common state patterns

These patterns apply to `OudsTextField`, `OudsPasswordInput`, `OudsPhoneNumberInput`, `OudsPinCodeInput`, `OudsCheckbox`, `OudsSwitch` and `OudsRadioButton` unless noted otherwise.

### Input widgets (`OudsTextField`, `OudsPasswordInput`, `OudsPhoneNumberInput`)

| Pattern | Parameter |
|---------|-----------|
| Helper text | `decoration: OudsInputDecoration(helperText: 'Hint message')` |
| Error state | `decoration: OudsInputDecoration(errorText: 'Field required')` |
| Read-only | `readOnly: true` |
| Disabled | `enabled: false` |
| Loading indicator | `decoration: OudsInputDecoration(loader: true)` |

> **⛔ Forbidden combination**: `loader: true` and `errorText != null` at the same time → assertion error at runtime. Loading and error states are mutually exclusive.

```dart
// Helper text
OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Email',
    helperText: 'We will never share your email.',
  ),
)

// Error state
OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Email',
    errorText: 'Invalid email address',
  ),
)

// Read-only
OudsTextField(
  readOnly: true,
  decoration: OudsInputDecoration(labelText: 'Email'),
)

// Disabled
OudsTextField(
  enabled: false,
  decoration: OudsInputDecoration(labelText: 'Email'),
)

// Loading (mutually exclusive with errorText)
OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Search',
    loader: true,
    // errorText: '…' ← FORBIDDEN when loader: true
  ),
)
```

### Control widgets (`OudsCheckbox`, `OudsSwitch`, `OudsRadioButton`)

| Pattern | How |
|---------|-----|
| Disabled | Pass `onChanged: null` |
| Read-only | `readOnly: true` |
| Error state | `isError: true` (Checkbox, RadioButton only) |
| Indeterminate (tristate) | `tristate: true`, `value: null` (Checkbox only) |

```dart
// Enabled checkbox
OudsCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
)

// Disabled checkbox (onChanged: null)
OudsCheckbox(
  value: false,
  onChanged: null,
)

// Error checkbox
OudsCheckbox(
  value: false,
  onChanged: (value) => setState(() => isChecked = value),
  isError: true,
)

// Tristate / indeterminate
OudsCheckbox(
  value: null,           // null = indeterminate
  tristate: true,
  onChanged: (value) => setState(() => isChecked = value),
)

// Disabled switch (onChanged: null)
OudsSwitch(
  value: true,
  onChanged: null,
)

// Read-only switch (keeps handler, prevents interaction)
OudsSwitch(
  value: true,
  onChanged: (value) {},
  readOnly: true,
)

// Radio button group
OudsRadioButton<String>(
  value: 'option_a',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
)

// Radio button — error
OudsRadioButton<String>(
  value: 'option_b',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
  isError: true,
)
```

---

## 6. Common patterns

### Tokens only

Never hardcode colors, dimensions or strings in OUDS code.

```dart
final theme = OudsTheme.of(context);

Padding(
  padding: EdgeInsets.all(theme.spaceScheme(context).fixedMedium),
  child: Text(
    'Label',
    style: theme.typographyTokens.typeLabelDefaultMedium(context),
  ),
)
```

### Localizations

Use OUDS or app localizations instead of hardcoded strings.

```dart
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';

final l10n = OudsLocalizations.of(context);
```

### Accessibility

> Load the **`ouds-flutter-accessibility`** skill for the full a11y reference (Semantics patterns, text scale, high-contrast, TalkBack/VoiceOver, testing checklist).

Key reminders:
- Wrap every interactive root in `Semantics` with appropriate flags (`button`, `checked`, `toggled`, `label`, `hint`, `value`)
- Use `ExcludeSemantics` on decorative children
- Use `MergeSemantics` to group label + control into a single focusable node
- `OudsCheckbox`, `OudsSwitch` and `OudsRadioButton` handle semantics automatically via `OudsLocalizations` — do not duplicate
- Always provide `semanticsLabel` on `OudsBadge` — color is the only visual differentiator

### Demo registration

Every new component needs a demo screen in `app/lib/ui/components/<name>/` and must be registered in `app/lib/ui/components/components.dart`.

---

## 7. Components

**Index:** [Alert](#alert) [Avatar](#avatar) [Badge](#badge) [Bottom Sheet](#bottom-sheet) [Button](#button) [Checkbox / Switch / Radio](#checkbox--switch--radio-button) [Checkbox / Switch / Radio item](#checkbox--switch--radio-item) [Chips](#filter-chip--suggestion-chip) [Divider](#divider) [Flag](#flag) [Link](#link) [List item](#list-item) [Navigation Bar](#navigation-bar) [Progress indicator](#progress-indicator) [Tag](#tag) [Text inputs](#text-input--password--phone--pin-code) [Top bar](#top-bar--app-bar)

The repository currently exposes component families under:

`alert/` · `avatar/` · `badge/` · `bottom_sheet/` · `button/` · `checkbox/` · `chip/` · `control/` · `country_selector/` · `divider/` · `flag/` · `form_input/` · `link/` · `list_item/` · `navigation/` · `pin_code_input/` · `progress_indicator/` · `radio_button/` · `switch/` · `tag/` · `top_bar/`

The shared `OudsIcon` class (`package:ouds_core/components/common/ouds_icon.dart`) unifies icon configuration (asset path, `tinted`, `backgroundColor`, `semanticsLabel`) across `OudsButton`, `OudsLink`, `OudsFilterChip`, `OudsSuggestionChip`, `OudsTextInput`, `OudsPhoneNumberInput`, `OudsCheckboxItem`, `OudsRadioButtonItem` and `OudsSwitchButtonItem` — always prefer it over a raw `String` icon path.

---

### Alert

Two components: `OudsAlertMessage` (full-featured, persistent) and `OudsInlineAlert` (lightweight, inline in content flow).

Statuses for both: `Positive()`, `Info()`, `Warning()`, `Negative()`, `Neutral(icon: ...)`, `Accent(icon: ...)`

```dart
// --- OudsAlertMessage ---

// Minimal
OudsAlertMessage(
  label: 'Your profile has been updated.',
  status: Positive(),
)

// With close button
OudsAlertMessage(
  label: 'Session expired.',
  status: Warning(),
  onClose: () {},
)

// With description + action link at bottom
OudsAlertMessage(
  label: 'Verification required.',
  status: Info(),
  description: 'Please confirm your email to continue.',
  actionLayout: OudsAlertMessageActionLayout(
    text: 'Resend email',
    onClick: () {},
    layout: OudsAlertMessageActionLayoutEnum.bottom,
  ),
  onClose: () {},
)

// Neutral with custom icon and bullet list
OudsAlertMessage(
  label: 'New features available.',
  status: Neutral(icon: 'assets/ic_star.svg'),
  bulletList: ['Dark mode', 'Improved performance', 'New components'],
)

// --- OudsInlineAlert ---
// Lightweight, placed inline in the content flow. No close button, no action link.

OudsInlineAlert(label: 'This field is required.')                    // default: Neutral
OudsInlineAlert(label: 'Invalid format.', status: Negative())
OudsInlineAlert(label: 'Saved successfully.', status: Positive())
OudsInlineAlert(label: 'Check your connection.', status: Warning())
```

---

### Avatar

Displays a profile image or a monogram (initials). Used standalone or as leading content in `OudsTopAppBar` / `OudsListItem`.

```dart
// Image avatar
OudsAvatar(image: 'assets/user_photo.png')

// Monogram avatar
OudsAvatar(
  monogram: 'John Doe',
  contentDescription: 'John Doe',
)

// Tappable avatar
OudsAvatar(
  monogram: 'JD',
  onClick: () => openProfile(),
  contentDescription: 'Open profile',
)
```

---

### Badge

Always provide `semanticsLabel` — color is the only visual differentiator.

```dart
// Standard badge (dot)
OudsBadge.standard(
  status: Negative(),
  size: OudsBadgeSize.medium,
  semanticsLabel: 'Error',
  child: Icon(Icons.mail),
)

// Count badge — values >= 100 are displayed as "+99"
OudsBadge.count(
  label: '12',
  status: Info(),
  size: OudsBadgeSize.large,
  semanticsLabel: '12 notifications',
  child: Icon(Icons.notifications),
)

// Icon badge with functional status icon
OudsBadge.icon(
  status: Warning(),
  size: OudsBadgeSize.large,
  semanticsLabel: 'Warning',
  child: Icon(Icons.settings),
)

// Icon badge with custom icon (Neutral/Accent only)
OudsBadge.icon(
  status: Accent(icon: 'assets/heart.svg'),
  size: OudsBadgeSize.medium,
  semanticsLabel: 'Favorite',
  child: Icon(Icons.person),
)

// Icon badge with untinted custom icon and background (Neutral/Accent only)
OudsBadge.icon(
  status: Neutral(
    icon: 'assets/multicolor_icon.svg',
    tinted: false,
    backgroundColor: Colors.white,
    semanticsLabel: 'Custom status',
  ),
  size: OudsBadgeSize.medium,
  child: Icon(Icons.person),
)
```

> `Neutral` and `Accent` custom icons support `tinted` (default `true`), `backgroundColor` (only applied when `tinted: false`) and `semanticsLabel`.

> ⚠️ Deprecated: `OudsBadge(status: OudsBadgeStatus.positive)` → use named constructors above.

---

### Bottom Sheet

Two variants: **modal** (blocks the main screen) and **standard** (persistent, co-exists with main content).

```dart
// Modal bottom sheet
OudsModalBottomSheet(
  dragHandle: true,
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Sheet content'),
  ),
).show(context: context);

// Standard (persistent) bottom sheet — with programmatic control
final scaffoldKey = GlobalKey<OudsBottomSheetScaffoldState>();

OudsBottomSheetScaffold(
  key: scaffoldKey,
  sheetContent: (context) => Text('Sheet body'),
  content: (context) => Text('Main screen content'),
  onExpansionChanged: (expanded) => debugPrint('Expanded: $expanded'),
)

// Expand / collapse programmatically
scaffoldKey.currentState?.expand();
scaffoldKey.currentState?.partialExpand();
```

> For the standard variant: avoid wrapping `body` in `SafeArea` and set `Scaffold(extendBody: true)` if you want content to scroll behind the sheet.

---

### Button

```dart
OudsButton(
  label: 'Label',
  appearance: OudsButtonAppearance.defaultAppearance,
  onPressed: () {},
)

OudsButton(
  icon: OudsIcon('assets/ic_heart.svg'),
  appearance: OudsButtonAppearance.strong,
  onPressed: () {},
)
```

---

### Checkbox / Switch / Radio button

These use `ouds_accessibility_plugin` internally for high-contrast detection. Semantics strings are provided automatically via `OudsLocalizations`. See §5 for state patterns.

```dart
OudsCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
)

OudsSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)

OudsRadioButton<String>(
  value: 'option_a',
  groupValue: _selected,
  onChanged: (value) => setState(() => _selected = value!),
)
```

---

### Checkbox / Switch / Radio item

`OudsCheckboxItem`, `OudsRadioButtonItem` and `OudsSwitchButtonItem` combine a control with a title, optional helper text and icon in a single row (built on the internal `OudsControlItem`).

```dart
OudsCheckboxItem(
  value: isChecked,
  title: 'Label',
  helperTitle: 'Helper text',
  icon: OudsIcon('assets/ic_heart.svg'),
  divider: true,
  onChanged: (value) => setState(() => isChecked = value),
)

OudsRadioButtonItem<String>(
  value: 'option_a',
  groupValue: _selected,
  title: 'Option A',
  onChanged: (value) => setState(() => _selected = value),
)

OudsSwitchButtonItem(
  value: isEnabled,
  title: 'Enable notifications',
  onChanged: (value) => setState(() => isEnabled = value),
)
```

---

### Filter chip / Suggestion chip

```dart
OudsFilterChip(
  label: 'Label',
  selected: true,
  onSelected: (selected) {},
)

OudsFilterChip.icon(
  label: 'Label',
  icon: OudsIcon('assets/ic_chip_heart.svg', tinted: true),
  selected: true,
  onSelected: (selected) {},
)

OudsSuggestionChip(
  label: 'Label',
  onPressed: () {},
)

OudsSuggestionChip.icon(
  label: 'Label',
  icon: OudsIcon('assets/ic_chip_heart.svg', tinted: true),
  onPressed: () {},
)
```

> `avatar` is deprecated on both `OudsFilterChip` and `OudsSuggestionChip` default constructors — use the `.icon` named constructor with its `icon` parameter instead.

---

### Divider

```dart
OudsDivider.horizontal()                                        // full width, default color
OudsDivider.horizontal(color: OudsDividerColor.emphasized)
OudsDivider.horizontal(color: OudsDividerColor.brandPrimary, margin: EdgeInsets.symmetric(horizontal: 16))

OudsDivider.vertical()                                          // default color
OudsDivider.vertical(color: OudsDividerColor.muted)
```

Available colors: `defaultColor`, `muted`, `emphasized`, `brandPrimary`, `onBrandPrimary`, `alwaysBlack`, `alwaysOnBlack`, `alwaysWhite`, `alwaysOnWhite`.

---

### Flag

Purely decorative country/region flag, always excluded from the semantics tree — pair it with a sibling text label carrying the country name.

```dart
OudsFlag('fr')
OudsFlag('US')   // case-insensitive

// Inside a list item
OudsListItem(
  label: 'France',
  leading: OudsListItemLeadingFlag(OudsFlag('fr')),
)
```

---

### Link

Prefer dedicated named constructors for icon/navigation variants. `OudsLink()` (default constructor) is for text-only links.

```dart
OudsLink(label: 'Learn more', onPressed: () {})

OudsLink.icon(
  label: 'Favorite',
  icon: OudsIcon('assets/ic_heart.svg', tinted: true),
  onPressed: () {},
)

OudsLink.previous(label: 'Back', onPressed: () {})
OudsLink.next(label: 'Next', onPressed: () {})
OudsLink.external(label: 'Visit website', onPressed: () {})
```

> ⚠️ Deprecated: `OudsLink(layout: OudsLinkLayout.back/textAndIcon/next)` → use `OudsLink.previous`, `OudsLink.icon` or `OudsLink.next`/`OudsLink.external` instead.

---

### List item

`OudsListItem` mirrors Flutter's `ListTile` spirit (leading / label / trailing) using OUDS tokens. Static (read-only) by default, becomes a navigation item when `onTap` is provided. `OudsSmallListItem` is a compact variant restricted to icon/image leading content; `OudsCardItem` / `OudsSmallCardItem` apply card styling.

```dart
// Static, with leading icon
OudsListItem(
  label: 'Title',
  description: 'Secondary text',
  leading: OudsListItemLeadingIcon(Neutral(icon: 'assets/icons/star.svg')),
  background: true,
)

// Navigation item — chevron indicator shown automatically
OudsListItem(
  label: 'Navigate',
  onTap: () => Navigator.of(context).push(route),
)

// Compact variant
OudsSmallListItem(
  label: 'Compact row',
  leading: OudsSmallListItemLeadingIcon(Positive()),
)
```

---

### Navigation bar

Supports 3 to 5 destinations. For the translucent variant, set `Scaffold(extendBody: true)` and avoid wrapping body in `SafeArea`.

```dart
// Opaque (default)
OudsNavigationBar(
  destinations: [
    OudsNavigationBarItem(icon: 'assets/home.svg', label: 'Home'),
    OudsNavigationBarItem(icon: 'assets/search.svg', label: 'Search'),
    OudsNavigationBarItem(icon: 'assets/profile.svg', label: 'Profile'),
  ],
  selectedIndex: _selectedIndex,
  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
)

// Translucent (blurred background, content scrolls behind)
Scaffold(
  extendBody: true,
  bottomNavigationBar: OudsNavigationBar(
    translucent: true,
    destinations: [...],
    selectedIndex: _selectedIndex,
    onDestinationSelected: (index) => setState(() => _selectedIndex = index),
  ),
  body: MyScrollableContent(),
)
```

---

### Progress indicator

`OudsCircularProgressIndicator` (ring) and `OudsLinearProgressIndicator` (bar). Both support `determinate`/`indeterminate` modes and a `status` color; always provide `semanticsLabel`.

```dart
// Indeterminate circular
OudsCircularProgressIndicator(
  progressType: OudsProgressIndicatorType.indeterminate,
  semanticsLabel: 'Loading',
)

// Determinate linear with helper text
OudsLinearProgressIndicator(
  progressType: OudsProgressIndicatorType.determinate,
  value: 0.42,
  status: Info(),
  semanticsLabel: 'Upload progress',
  helperText: OudsLinearProgressIndicatorHelperText(progress: true),
)
```

---

### Tag

Prefer named constructors. Statuses: `Positive()`, `Negative()`, `Info()`, `Warning()`, `Accent()`, `Neutral()`.

```dart
OudsTag.text(label: 'Label', status: Positive())
OudsTag.text(label: 'Label', status: Warning(), size: OudsTagSize.small)
OudsTag.icon(label: 'Label', status: Neutral(icon: 'assets/ic_heart.svg'))
OudsTag.bullet(label: 'Label', status: Info())
```

> ⚠️ Deprecated: `OudsTag(label: ..., status: OudsTagStatus.positive)` → use named constructors above.

---

### Text input / password / phone / pin code

See §5 for error / helper / readOnly / disabled / loading state patterns.

```dart
// Text field — with prefix icon and helper link
OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Email',
    hintText: 'you@example.com',
    prefixIcon: OudsIcon('assets/ic_mail.svg'),
    helperText: 'We will never share your address.',
  ),
  helperLink: OudsLink(label: 'Privacy policy', onPressed: () {}),
)

// Password input
OudsPasswordInput(
  decoration: OudsPasswordInputDecoration(
    labelText: 'Password',
    helperText: 'At least 8 characters.',
  ),
)

// Phone number input with country selector
OudsPhoneNumberInput(
  decoration: OudsInputDecoration(
    labelText: 'Phone number',
    hintText: '06 12 34 56 78',
  ),
  countrySelector: CountrySelector(
    countryFilter: CountryFilter.custom,
    codes: ['FR', 'TN', 'US'],
    onCountryChanged: (country) {},
    readOnly: false,
  ),
)

// Pin code input
OudsPinCodeInput(
  controllers: List.generate(6, (_) => TextEditingController()),
  digitInputDecoration: OudsDigitInputDecoration(hintText: '-'),
  helperText: 'Enter the 6-digit code sent to your email.',
)
```

---

### Top bar / App bar

```dart
OudsTopBar(
  title: 'Title',
  leadingActions: [
    OudsTopBarActionConfig.back(
      previousPageTitle: 'Back',
      onActionPressed: () {},
    ),
  ],
)
```

Use `OudsTopAppBar` when you need the full Material top app bar implementation (search, actions overflow, etc.).

---

## 8. Testing and verification

Before considering code complete, run all of the following:

```bash
dart format .
flutter analyze --no-pub
(cd app && flutter test)
(cd ouds_core && flutter test)
```

Also run tests in every other modified package that has a `test/` directory:

```bash
(cd ouds_global_raw_tokens && flutter test)
(cd ouds_theme_contract && flutter test)
(cd ouds_theme_orange && flutter test)
(cd ouds_theme_sosh && flutter test)
(cd ouds_theme_wireframe && flutter test)
```

If ARB localization files changed:

```bash
cd app && flutter gen-l10n
cd ouds_core && flutter gen-l10n
```

### Multi-theme and display checklist

- [ ] Component tested with all 4 themes: **Orange**, **Orange Compact**, **Sosh**, **Wireframe**
- [ ] Component tested in **light** and **dark** mode
- [ ] Full accessibility checklist completed → load **`ouds-flutter-accessibility`** skill for details

