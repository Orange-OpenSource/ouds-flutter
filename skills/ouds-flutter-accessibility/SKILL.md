---
name: ouds-flutter-accessibility
description: Reference guide for OUDS Flutter accessibility rules and patterns — Semantics, MergeSemantics, ExcludeSemantics, text scale, high-contrast, screen readers (TalkBack / VoiceOver), orientation, bug diagnosis and enhancement
license: MIT
---

# OUDS Flutter Accessibility Guide

> **Agent optimization**: See [copilot-instructions.md §9](../../.github/copilot-instructions.md#9-agent-response-optimization-) for token-efficient response guidelines.

This skill applies to accessibility work in the OUDS Flutter repository. Use it for Flutter widgets and semantics patterns, not for OUDS web, Android native, or iOS native platforms.

Use this skill when a user asks about:

- how to make an OUDS component accessible
- which `Semantics` flags to use on a widget
- how to support TalkBack (Android) or VoiceOver (iOS)
- how to handle text scale, high-contrast or orientation
- how to **diagnose and fix an accessibility bug**
- how to **enhance existing accessibility** (add missing labels, fix wrong flags, improve focus order)
- how to test accessibility on device or emulator

> 📖 Reference: [Orange accessibility guidelines (mobile)](https://a11y-guidelines.orange.com/fr/mobile/)

---

## 0. Agent workflow — fixing or enhancing accessibility

When asked to fix a bug or add/improve accessibility on an existing widget, follow this sequence:

```
1. READ the widget source file — identify all interactive, informational and decorative elements
2. DIAGNOSE — match the code against the bug catalogue in §9
3. PLAN the fix — choose the correct pattern from §2 or §10
4. APPLY the change — use before/after from §9 or §10 as template
5. VERIFY — run the checklist in §8 on the modified widget
6. FORMAT & ANALYZE — dart format . && flutter analyze --no-pub (zero errors required)
```

> Do not guess — always read the widget source before proposing a fix.

---

## 1. Core rules — 🔴 MANDATORY

These rules apply to **every** OUDS component and every custom widget built on top of OUDS.

| Rule | Detail |
|------|--------|
| Wrap every interactive root in `Semantics` | Use appropriate flags: `button`, `checked`, `toggled`, `label`, `hint`, `value` |
| Use `ExcludeSemantics` on decorative children | Icons, illustrations and dividers that carry no information must be hidden from screen readers |
| Use `MergeSemantics` to group related nodes | When several widgets form a single logical unit, merge them into one focusable node |
| Provide `semanticsLabel` on color-only components | `OudsBadge` and similar widgets convey meaning via color — always add a text alternative |
| Never hardcode accessibility strings | Use `OudsLocalizations.of(context)` — never pass raw string literals to `Semantics` |
| Never lock text size | Use OUDS typography tokens — never override `MediaQuery.textScalerOf` |
| Never lock portrait orientation | OUDS supports both orientations — never call `SystemChrome.setPreferredOrientations` |
| Support high-contrast mode | Use `ouds_accessibility_plugin` to detect system high-contrast and adapt visuals |

---

## 2. Semantics patterns

### 2.1 Interactive widget — button

```dart
Semantics(
  button: true,
  label: OudsLocalizations.of(context).myActionLabel,
  child: GestureDetector(
    onTap: onPressed,
    child: const MyButtonVisual(),
  ),
)
```

### 2.2 Toggle / switch

```dart
Semantics(
  toggled: isEnabled,
  button: true,
  child: GestureDetector(
    onTap: () => onChanged(!isEnabled),
    child: MyToggleVisual(isEnabled: isEnabled),
  ),
)
```

### 2.3 Checkbox / radio

```dart
Semantics(
  checked: isChecked,
  label: OudsLocalizations.of(context).myOptionLabel,
  child: GestureDetector(
    onTap: () => onChanged(!isChecked),
    child: MyCheckVisual(checked: isChecked),
  ),
)
```

### 2.4 Informational — value with unit

```dart
Semantics(
  label: 'Progress',
  value: '$progress %',
  child: MyProgressVisual(progress: progress),
)
```

### 2.5 Decorative element — excluded

```dart
ExcludeSemantics(
  child: SvgPicture.asset('assets/illustration.svg'),
)
```

### 2.6 Grouped label + control

```dart
MergeSemantics(
  child: Row(
    children: [
      Text('Notifications'),
      OudsSwitch(value: isOn, onChanged: (v) => setState(() => isOn = v)),
    ],
  ),
)
```

---

## 3. OUDS components — built-in semantics

These OUDS components handle semantics **automatically** via `OudsLocalizations`. Do **not** duplicate accessibility strings manually.

| Component | Handled automatically |
|-----------|-----------------------|
| `OudsCheckbox` | `checked`, `disabled`, `error` labels via `OudsLocalizations` |
| `OudsSwitch` | `toggled`, `disabled`, `readOnly` labels via `OudsLocalizations` |
| `OudsRadioButton` | `checked`, `disabled`, `error` labels via `OudsLocalizations` |
| `OudsButton` | `button` flag + `label` |
| `OudsLink` | `link` flag + `label` |

For `OudsBadge`, always pass `semanticsLabel` explicitly — color is the only visual differentiator:

```dart
OudsBadge.standard(
  status: Negative(),
  size: OudsBadgeSize.medium,
  semanticsLabel: 'Error',        // required — never omit
  child: Icon(Icons.mail),
)

OudsBadge.count(
  label: '12',
  status: Info(),
  size: OudsBadgeSize.large,
  semanticsLabel: '12 notifications',
  child: Icon(Icons.notifications),
)
```

---

## 4. Text scale

OUDS typography tokens automatically respect `MediaQuery.textScalerOf`. No manual intervention is needed.

```dart
// Correct — scales automatically
Text(
  'Label',
  style: OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context),
)

// ❌ Forbidden — breaks system text scale
MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
  child: child,
)
```

**Test at:** 100 %, 150 %, 200 % system text scale — no layout overflow should occur.

---

## 5. High-contrast mode

`ouds_accessibility_plugin` provides a platform-level signal. OUDS components use it internally.

When building a **custom component** that needs to adapt to high contrast:

```dart
import 'package:ouds_accessibility_plugin/ouds_accessibility_plugin.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});
  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  bool _isHighContrast = false;

  @override
  void initState() {
    super.initState();
    OudsAccessibilityPlugin.isHighContrastEnabled().then((value) {
      setState(() => _isHighContrast = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = OudsTheme.of(context).colorScheme(context);
    return Container(
      color: _isHighContrast ? colors.bgPrimary : colors.bgSecondary,
      child: const MyContent(),
    );
  }
}
```

> `OudsCheckbox`, `OudsSwitch` and `OudsRadioButton` already use `ouds_accessibility_plugin` internally — no action needed for those components.

---

## 6. Orientation support

Never lock the app to portrait mode. OUDS supports landscape and portrait.

```dart
// ❌ Forbidden
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// ✅ Correct — do nothing, let the OS handle rotation
```

Test both orientations on a physical device or emulator before marking work complete.

---

## 7. Screen reader support

### 7.1 Localizations — never hardcode strings

```dart
// ❌ Forbidden
Semantics(label: 'Close button', child: closeIcon)

// ✅ Correct
Semantics(
  label: OudsLocalizations.of(context).closeButtonLabel,
  child: closeIcon,
)
```

### 7.2 Focus order

Flutter traverses the widget tree top-to-bottom by default. To reorder:

```dart
FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: [
      FocusTraversalOrder(order: const NumericFocusOrder(1), child: myFirstWidget),
      FocusTraversalOrder(order: const NumericFocusOrder(2), child: mySecondWidget),
    ],
  ),
)
```

### 7.3 TalkBack (Android) testing

1. Enable TalkBack in **Settings → Accessibility → TalkBack**.
2. Navigate the component with swipe gestures.
3. Verify: focus ring visible, label announced, state changes announced (toggled / checked / error).
4. Verify: decorative elements are skipped.

### 7.4 VoiceOver (iOS) testing

1. Enable VoiceOver in **Settings → Accessibility → VoiceOver** (or triple-click the side button).
2. Navigate with swipe, activate with double-tap.
3. Verify same points as TalkBack above.

---

## 8. Custom component — full accessibility checklist

Apply this checklist before considering any new or migrated interactive widget complete:

- [ ] Root interactive element wrapped in `Semantics` with appropriate flags (`button`, `checked`, `toggled`, `label`, `hint`, `value`)
- [ ] `ExcludeSemantics` applied to all purely decorative children (icons, illustrations, dividers)
- [ ] `MergeSemantics` used where label + control form a single logical unit
- [ ] `semanticsLabel` provided on any widget where color is the only visual differentiator
- [ ] All accessibility strings sourced from `OudsLocalizations.of(context)` — no hardcoded strings
- [ ] Text uses OUDS typography tokens — no `MediaQuery.textScalerOf` override
- [ ] Landscape orientation supported — no `SystemChrome.setPreferredOrientations` call
- [ ] High-contrast adaptation verified (either via built-in OUDS tokens or `ouds_accessibility_plugin`)
- [ ] TalkBack (Android) tested on device or emulator
- [ ] VoiceOver (iOS) tested on device or emulator
- [ ] Text scale tested at 100 %, 150 %, 200 % — no layout overflow
- [ ] Focus order is logical and matches the visual reading order

---

## 9. Bug catalogue — diagnosis and fix

Each entry describes a **symptom** (what TalkBack/VoiceOver announces or skips), the **root cause** in code, and the **fix**.

---

### 9.1 Interactive widget not announced by screen reader

**Symptom:** TalkBack/VoiceOver skips a button, chip or card — user cannot focus or activate it.

**Root cause:** The widget uses `GestureDetector` or `InkWell` without a `Semantics` wrapper.

```dart
// ❌ Bug
GestureDetector(
  onTap: () => doSomething(),
  child: MyCardVisual(),
)
```

```dart
// ✅ Fix
Semantics(
  button: true,
  label: OudsLocalizations.of(context).myCardActionLabel,
  child: GestureDetector(
    onTap: () => doSomething(),
    child: MyCardVisual(),
  ),
)
```

---

### 9.2 Hardcoded accessibility string

**Symptom:** String is not translated when locale changes, or fails audit because it is a raw literal.

**Root cause:** `Semantics(label: 'Close')` passes a string literal.

```dart
// ❌ Bug
Semantics(label: 'Close', child: closeIcon)

// ❌ Also wrong — interpolated literal
Semantics(label: 'Badge: $count', child: badgeWidget)
```

```dart
// ✅ Fix — use OudsLocalizations
Semantics(
  label: OudsLocalizations.of(context).closeButtonLabel,
  child: closeIcon,
)

// ✅ Fix — for OudsBadge
OudsBadge.count(
  label: '$count',
  status: Info(),
  semanticsLabel: OudsLocalizations.of(context).notificationsCount(count),
  child: Icon(Icons.notifications),
)
```

---

### 9.3 Decorative element announced by screen reader

**Symptom:** TalkBack announces "unlabelled image" or reads an SVG file name — creates noise for screen reader users.

**Root cause:** Decorative icon or illustration has no `ExcludeSemantics` wrapper.

```dart
// ❌ Bug
SvgPicture.asset('assets/illustration_success.svg')
Icon(Icons.star)
```

```dart
// ✅ Fix
ExcludeSemantics(
  child: SvgPicture.asset('assets/illustration_success.svg'),
)

ExcludeSemantics(
  child: Icon(Icons.star),
)
```

---

### 9.4 Missing semanticsLabel on OudsBadge

**Symptom:** TalkBack announces the badge color or a numeric count without context — user cannot understand the meaning.

**Root cause:** `semanticsLabel` not provided on `OudsBadge`.

```dart
// ❌ Bug
OudsBadge.standard(status: Negative(), child: Icon(Icons.mail))

// ❌ Bug
OudsBadge.count(label: '5', status: Info(), child: Icon(Icons.notifications))
```

```dart
// ✅ Fix
OudsBadge.standard(
  status: Negative(),
  semanticsLabel: OudsLocalizations.of(context).mailError,
  child: Icon(Icons.mail),
)

OudsBadge.count(
  label: '5',
  status: Info(),
  semanticsLabel: OudsLocalizations.of(context).notificationsCount(5),
  child: Icon(Icons.notifications),
)
```

---

### 9.5 Wrong or missing Semantics flags

**Symptom:** TalkBack announces "button" for a toggle, or announces a state that does not change when the user interacts.

**Root cause:** Wrong flag used, or flag value is static (not bound to widget state).

```dart
// ❌ Bug — toggle announced as plain button, state never updates
Semantics(
  button: true,
  child: MyToggle(isOn: isOn, onChanged: onChanged),
)
```

```dart
// ✅ Fix — use toggled, bind to state
Semantics(
  toggled: isOn,   // reflects current state
  button: true,
  child: MyToggle(isOn: isOn, onChanged: onChanged),
)
```

**Flag reference:**

| Widget type | Correct flags |
|-------------|---------------|
| Button / action | `button: true, label: ...` |
| Toggle / switch | `toggled: value, button: true` |
| Checkbox | `checked: value, label: ...` |
| Radio button | `checked: value == groupValue, label: ...` |
| Text input | `textField: true, label: ...` |
| Informational value | `label: ..., value: ...` |
| Image with meaning | `image: true, label: ...` |

---

### 9.6 Duplicate semantics — OUDS component + manual Semantics wrapper

**Symptom:** TalkBack announces the label twice, or announces contradictory states.

**Root cause:** A manual `Semantics` wraps an OUDS component that already handles its own semantics.

```dart
// ❌ Bug — OudsCheckbox handles checked/label automatically
Semantics(
  checked: isChecked,
  label: 'Accept terms',
  child: OudsCheckbox(
    value: isChecked,
    onChanged: (v) => setState(() => isChecked = v),
  ),
)
```

```dart
// ✅ Fix — remove the outer Semantics, let OUDS handle it
OudsCheckbox(
  value: isChecked,
  onChanged: (v) => setState(() => isChecked = v),
)
```

Components that handle their own semantics: `OudsCheckbox`, `OudsSwitch`, `OudsRadioButton`, `OudsButton`, `OudsLink`.

---

### 9.7 Text size locked — scale not respected

**Symptom:** Text stays the same size regardless of system font scale setting.

**Root cause:** `MediaQuery.textScalerOf` is overridden, or `TextStyle` uses a literal `fontSize`.

```dart
// ❌ Bug — hardcoded font size, ignores system scale
Text('Label', style: const TextStyle(fontSize: 16))

// ❌ Bug — forces no scaling on subtree
MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
  child: child,
)
```

```dart
// ✅ Fix — use OUDS typography token
Text(
  'Label',
  style: OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context),
)
```

---

### 9.8 Label and interactive control not merged — announced separately

**Symptom:** TalkBack reads the label ("Notifications"), then separately reads the switch ("off, switch"). User must swipe twice to reach the control.

**Root cause:** `Text` and `OudsSwitch` are siblings without `MergeSemantics`.

```dart
// ❌ Bug
Row(
  children: [
    const Text('Notifications'),
    OudsSwitch(value: isOn, onChanged: (v) => setState(() => isOn = v)),
  ],
)
```

```dart
// ✅ Fix
MergeSemantics(
  child: Row(
    children: [
      const Text('Notifications'),
      OudsSwitch(value: isOn, onChanged: (v) => setState(() => isOn = v)),
    ],
  ),
)
```

---

### 9.9 Error / disabled state not announced

**Symptom:** TalkBack does not mention that a field is in error or that a button is disabled.

**Root cause:** State change not reflected in Semantics, or `isError` / `enabled` parameter missing.

```dart
// ❌ Bug — error state visually shown but not announced
Semantics(
  button: true,
  label: 'Submit',
  child: MyButtonVisual(hasError: true),
)

// ❌ Bug — text field error visually shown but not semantically set
OudsTextField(
  decoration: OudsInputDecoration(labelText: 'Email'),
  // errorText missing even though validation failed
)
```

```dart
// ✅ Fix — reflect error in Semantics
Semantics(
  button: true,
  label: OudsLocalizations.of(context).submitLabel,
  hint: hasError ? OudsLocalizations.of(context).formHasErrors : null,
  child: MyButtonVisual(hasError: hasError),
)

// ✅ Fix — use errorText so OudsTextField announces the error
OudsTextField(
  decoration: OudsInputDecoration(
    labelText: 'Email',
    errorText: _validationError, // non-null when invalid
  ),
)
```

---

### 9.10 Portrait orientation locked

**Symptom:** App does not rotate on a device held in landscape — accessibility users who mount devices in fixed positions cannot use the app.

**Root cause:** `SystemChrome.setPreferredOrientations` called somewhere (often in `main()` or `initState()`).

```dart
// ❌ Bug
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
```

```dart
// ✅ Fix — remove the call entirely; let the OS handle rotation
// No replacement needed — omit the call
```

---

## 10. Enhancement patterns — improving existing accessibility

Use these patterns when accessibility exists but is incomplete or can be improved.

### 10.1 Add a hint to clarify an action

A hint gives screen reader users extra context about what an action does.

```dart
// Before — label only
Semantics(
  button: true,
  label: OudsLocalizations.of(context).deleteLabel,
  child: deleteButton,
)

// After — with hint
Semantics(
  button: true,
  label: OudsLocalizations.of(context).deleteLabel,
  hint: OudsLocalizations.of(context).deleteHint, // e.g. "Removes the item permanently"
  child: deleteButton,
)
```

### 10.2 Announce live content changes

When content updates dynamically (e.g. a counter, a status message), use `liveRegion` so the change is announced without focus change.

```dart
Semantics(
  liveRegion: true,
  label: OudsLocalizations.of(context).statusMessage(currentStatus),
  child: MyStatusBanner(status: currentStatus),
)
```

### 10.3 Improve focus order on complex layouts

When the visual layout order does not match the logical reading order:

```dart
FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: [
      FocusTraversalOrder(order: const NumericFocusOrder(1), child: titleWidget),
      FocusTraversalOrder(order: const NumericFocusOrder(2), child: bodyWidget),
      FocusTraversalOrder(order: const NumericFocusOrder(3), child: actionButton),
    ],
  ),
)
```

### 10.4 Provide a value for progress or slider

```dart
// Before — announced as unlabelled
LinearProgressIndicator(value: progress)

// After — with semantic label and value
Semantics(
  label: OudsLocalizations.of(context).uploadProgress,
  value: '${(progress * 100).round()} %',
  child: LinearProgressIndicator(value: progress),
)
```

### 10.5 Group a form section into a single semantic node

When a form row has a label, a field and an inline error, group them so the user hears everything in one focus:

```dart
Semantics(
  label: OudsLocalizations.of(context).emailFieldLabel,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      OudsTextField(
        decoration: OudsInputDecoration(
          labelText: 'Email',
          errorText: _emailError,
        ),
      ),
    ],
  ),
)
```

---

