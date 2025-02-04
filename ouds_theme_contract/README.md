**Theme Contract** defines the architecture and interface for implementing themes within the OUDS framework. It specifies the semantic and component tokens required for each theme and ensures that all themes are built consistently.

## Features

- Provides the interface for defining semantic tokens (e.g., colors, typography)
- Defines how themes must implement the `OudsThemeContract` interface
- Supports overriding and customizing component tokens
- Establishes a standard for cross-platform theme compatibility

## Getting started

To use **Theme Contract**, add it as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  theme_contract: ^1.0.0
```

## Usage

```dart
import 'package:theme_contract/theme_contract.dart';

class MyCustomTheme implements OudsThemeContract {
  @override
  Color get primaryColor => Colors.blue;
  @override
  TextStyle get textStyle => TextStyle(fontFamily: 'Roboto');
// Implement other required methods like spacing, typography, etc.
}

```
## Additional information
Theme Contract provides the standard interface that every theme must implement in the OUDS framework. It ensures consistency in how themes are structured and how tokens (such as colors, typography, and component tokens) are applied across apps. Themes are required to implement the OudsThemeContract interface, which ensures they comply with the OUDS system.



