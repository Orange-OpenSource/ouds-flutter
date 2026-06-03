---
name: ouds-vocabulary
description: Use when the user asks about OUDS-specific terms such as Tokenator, token, raw token, semantic token, component token, theme, theme tweak, theme config, token provider, or component
license: MIT
---

# OUDS Vocabulary

| Term | Definition |
|------|------------|
| **Tokenator** | Internal tool that converts Figma-exported token specifications into generated Dart token source files and theme implementations |
| **token** | Named variable holding a design value; in OUDS many tokens are generated from Figma via Tokenator |
| **raw token** | Primitive token value defined in `ouds_global_raw_tokens/lib/` such as dimensions, colors, borders, opacity or fonts |
| **semantic token** | Token abstraction that carries UI meaning and is exposed through theme providers such as colors, borders, spaces, sizes, typography or elevation |
| **component token** | Token scoped to one component, exposed from `OudsTheme.of(context).componentsTokens(context)` for component-specific styling |
| **theme** | Concrete implementation of `OudsThemeContract` that provides semantic tokens, component tokens, Material `ThemeData`, assets and fonts |
| **theme contract** | The `OudsThemeContract` interface defined in `ouds_theme_contract`, implemented by all OUDS brand themes |
| **theme tweak** | Local subtree override applied with `OudsThemeTweak` to force or invert light/dark mode for a portion of the widget tree |
| **theme config** | Lightweight component-specific tuning injected with `OudsThemeConfigModel`, e.g. rounded button or text input configuration |
| **token provider** | Grouping of semantic or component tokens made accessible by the active theme |
| **component** | Reusable Flutter widget shipped by OUDS, usually under `ouds_core/lib/components/<name>/` and prefixed with `Ouds` |
| **demo app** | The `app/` package, also called "Design System Toolbox", used to showcase themes, tokens and components interactively |
| **direct package import** | Repository convention of importing components by their package path such as `package:ouds_core/components/button/ouds_button.dart` instead of a root barrel file |

## When to load which skill

| Task | Skill to load |
|------|---------------|
| Ask about or explain OUDS-specific terms (Tokenator, token, raw token, semantic token, component token, theme, …) | `ouds-vocabulary` (this skill) |
| Write or review Dart / Flutter code using OUDS components, themes or tokens | `ouds-framework-usage` |
| Translate a Figma token or token family into the corresponding Flutter package / token layer / naming pattern | `ouds-figma-to-flutter` |
| Adopt OUDS from native Flutter or custom components, migrate between versions, remove deprecated APIs | `ouds-migration-guide` |
| Implement or review accessibility — Semantics, screen readers, text scale, high-contrast, orientation | `ouds-accessibility` |
