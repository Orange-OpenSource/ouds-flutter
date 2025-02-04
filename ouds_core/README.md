**Ouds Core** provides the foundational logic and components for building and managing themes in a cross-platform application. It is responsible for integrating and applying semantic and component tokens, ensuring consistent UI elements across all apps using the OUDS system.

## Features

- Core components for integrating themes and tokens
- Basic setup for semantic and component token management
- Provides the foundation for theme-based customization
- Interacts with the `OudsTheme` for consistent styling across platforms

## Getting started

To use **Ouds Core**, add it as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  ouds_core: ^1.0.0
```

## Usage

```dart
import 'package:ouds_core/ouds_core.dart';

void main() {
  // Set up the Orange theme for the app
  OudsTheme.use(ThemeOrange());  // Set default theme

  // Optionally, create a custom theme
  MyCustomTheme();
}

class MyCustomTheme implements OudsThemeContract {
  @override
  Color get primaryColor => Colors.blue;
// Customize other tokens like typography, spacing, etc.
}

```
## Additional information
Ouds Core is the foundation of the entire theme architecture, enabling consistent theme management across various platforms. It ensures that semantic and component tokens are correctly applied, allowing for easy customization of UI elements like buttons, typography, and colors.



