---
name: ouds-flutter-figma-to-dart
description: Reference guide for deriving Dart naming and token layer from Figma token families in the OUDS Flutter project (raw, semantic and component tokens)
license: MIT
---

# OUDS Flutter Figma-to-Dart Mapping

> **Agent optimization**: See [copilot-instructions.md §9](../../.github/copilot-instructions.md#9-agent-response-optimization-) for token-efficient response guidelines.

This skill applies to token mapping in the OUDS Flutter repository. Use it when translating Figma tokens to Flutter/Dart naming, not for OUDS web, Android native, or iOS native platforms.

## 1. Quick-reference cheat sheet

```text
TOKEN LAYERS IN THIS REPOSITORY
  Raw tokens        → `ouds_global_raw_tokens/lib/*.dart`
  Semantic tokens   → `ouds_theme_contract/lib/theme/tokens/semantic/*.dart`
  Component tokens  → `ouds_theme_contract/lib/theme/tokens/components/*.dart`
  Theme values      → implemented in `ouds_theme_orange/`, `ouds_theme_sosh/`, etc.

LOOKUP ORDER
  1. Identify whether the Figma item is raw / semantic / component scoped
  2. Find the corresponding generated abstract token file in `ouds_theme_contract`
  3. Find the concrete brand implementation in each theme package
  4. Consume the value through `OudsTheme.of(context)` — never by editing generated files

STOP IMMEDIATELY
  - If the task asks to manually edit generated token files
  - If the token file is under `ouds_global_raw_tokens`, `ouds_theme_contract`,
    `ouds_theme_orange`, `ouds_theme_orange_compact`, `ouds_theme_sosh`, or `ouds_theme_wireframe`
```

---

## 2. Layer mapping in Flutter

### Layer 1 — Raw tokens

Raw token files live in `ouds_global_raw_tokens/lib/`.

| Family | File | Example names |
|--------|------|---------------|
| Border | `border_raw_tokens.dart` | raw border constants |
| Color | `color_raw_tokens.dart` | raw color constants |
| Dimension | `dimension_raw_tokens.dart` | `dimension200`, `dimensionOutOfSystem25` |
| Effect | `effect_raw_tokens.dart` | raw effect constants |
| Elevation | `elevation_raw_tokens.dart` | raw elevation constants |
| Font | `font_raw_tokens.dart` | raw font constants |
| Grid | `grid_raw_tokens.dart` | raw grid constants |
| Opacity | `opacity_raw_tokens.dart` | raw opacity constants |

Example:

```dart
DimensionRawTokens.dimension200
DimensionRawTokens.dimensionOutOfSystem25
```

### Layer 2 — Semantic tokens

Semantic token interfaces live in `ouds_theme_contract/lib/theme/tokens/semantic/`.

| Semantic family | File | Typical access |
|-----------------|------|----------------|
| Border | `ouds_border_semantic_tokens.dart` | via theme border / scheme APIs |
| Color | `ouds_color_semantic_tokens.dart` | `theme.colorScheme(context)` |
| Elevation | `ouds_elevation_semantic_tokens.dart` | via theme providers |
| Font | `ouds_font_semantic_tokens.dart` | `theme.typographyTokens` / font tokens |
| Grid | `ouds_grid_semantic_tokens.dart` | `theme.gridScheme(context)` |
| Opacity | `ouds_opacity_semantic_tokens.dart` | via providers |
| Size | `ouds_size_semantic_tokens.dart` | `theme.sizeScheme(context)` |
| Space | `ouds_space_semantic_tokens.dart` | `theme.spaceScheme(context)` |

### Layer 3 — Component tokens

Component token interfaces live in `ouds_theme_contract/lib/theme/tokens/components/`.

| Component | File | Typical access |
|-----------|------|----------------|
| Alert | `ouds_alert_tokens.dart` | `theme.componentsTokens(context).alert` |
| Badge | `ouds_badge_tokens.dart` | `theme.componentsTokens(context).badge` |
| Bar | `ouds_bar_tokens.dart` | `theme.componentsTokens(context).bar` |
| Bullet list | `ouds_bulletList_tokens.dart` | `theme.componentsTokens(context).bulletList` |
| Button | `ouds_button_tokens.dart` | `theme.componentsTokens(context).button` |
| Button mono | `ouds_buttonMono_tokens.dart` | mono button token group |
| Checkbox | `ouds_checkbox_tokens.dart` | `theme.componentsTokens(context).checkbox` |
| Chip | `ouds_chip_tokens.dart` | `theme.componentsTokens(context).chip` |
| Control item | `ouds_controlItem_tokens.dart` | shared item tokens |
| Divider | `ouds_divider_tokens.dart` | `theme.componentsTokens(context).divider` |
| Icon | `ouds_icon_tokens.dart` | `theme.componentsTokens(context).icon` |
| Input tag | `ouds_inputTag_tokens.dart` | `theme.componentsTokens(context).inputTag` |
| Link | `ouds_link_tokens.dart` | `theme.componentsTokens(context).link` |
| Link mono | `ouds_linkMono_tokens.dart` | mono link token group |
| Pin code input | `ouds_pinCodeInput_tokens.dart` | `theme.componentsTokens(context).pinCodeInput` |
| Radio button | `ouds_radioButton_tokens.dart` | `theme.componentsTokens(context).radioButton` |
| Skeleton | `ouds_skeleton_tokens.dart` | `theme.componentsTokens(context).skeleton` |
| Switch | `ouds_switch_tokens.dart` | `theme.componentsTokens(context).switch` |
| Tag | `ouds_tag_tokens.dart` | `theme.componentsTokens(context).tag` |
| Text input | `ouds_textInput_tokens.dart` | `theme.componentsTokens(context).textInput` |

Observed naming patterns:

- Component file names and accessors are lowerCamelCase with preserved internal capitals when part of the domain name: `textInput`, `pinCodeInput`, `radioButton`
- Token properties flatten the Figma hierarchy into lowerCamelCase names
- Common prefixes describe the token domain: `border`, `color`, `size`, `space`

Examples from generated files:

```dart
// Button tokens
borderRadiusDefault
colorBgDefaultEnabled
colorContentBrandPressed
sizeMinHeight
spacePaddingInlineIconStart

// Text input tokens
colorBorderEnabled
sizeCountrySelectorFlagHeight
spaceColumnGapLabelAsterisk
spacePaddingInlineCountrySelectorStart
spaceRowGapLabelInput
```

---

## 3. Practical lookup workflow

When a user gives you a Figma token name or token family:

1. Decide the layer:
   - primitive design value → raw token
   - reusable semantic meaning (space, color, border, size, typography) → semantic token
   - component-specific styling → component token
2. Search the generated interfaces first in `ouds_theme_contract/lib/theme/tokens/`
3. If needed, inspect the matching theme implementation in:
   - `ouds_theme_orange/`
   - `ouds_theme_orange_compact/`
   - `ouds_theme_sosh/`
   - `ouds_theme_wireframe/`
4. In component code, consume through `OudsTheme.of(context)` accessors
5. If no dedicated component token exists, reuse existing theme accessors instead of creating a token file manually

---

## 4. Examples

| Need | Flutter lookup |
|------|----------------|
| Raw spacing / dimension scale | `ouds_global_raw_tokens/lib/dimension_raw_tokens.dart` |
| Semantic spacing token | `OudsTheme.of(context).spaceScheme(context).fixedMedium` |
| Semantic responsive spacing | `OudsTheme.of(context).spaceScheme(context).scaled3xsmallMobile` |
| Component button background token | `OudsTheme.of(context).componentsTokens(context).button.colorBgDefaultEnabled` |
| Component text input spacing token | `OudsTheme.of(context).componentsTokens(context).textInput.spaceColumnGapLabelAsterisk` |
| Typography token | `OudsTheme.of(context).typographyTokens` |
| Component token interface definition | `ouds_theme_contract/lib/theme/tokens/components/...` |
| Raw token definition | `ouds_global_raw_tokens/lib/...` |

---

## 5. Critical rules

- Token files in `ouds_global_raw_tokens`, `ouds_theme_contract`, `ouds_theme_orange`, `ouds_theme_orange_compact`, `ouds_theme_sosh`, and `ouds_theme_wireframe` are generated by Tokenator and must not be edited manually.
- If a new component does **not** have a generated token file, do **not** invent one manually.
- Reuse existing tokens from:
  - `OudsTheme.of(context).spaceScheme(context)`
  - `OudsTheme.of(context).colorScheme(context)`
  - `OudsTheme.of(context).typographyTokens`
  - `OudsTheme.of(context).componentsTokens(context)`
- When unsure about an exact Figma-to-Dart property mapping, inspect the generated token interfaces instead of guessing.

