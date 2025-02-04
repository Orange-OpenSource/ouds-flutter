**Ouds Global Raw Tokens** defines a set of raw, primitive tokens used globally across the OUDS system. These tokens are essential for establishing the basic building blocks of a theme and allow for flexible customization.

## Features

- Defines raw tokens for colors, spacing, typography, etc.
- Provides a base set of values that can be referenced and overridden
- Supports global customization of tokens across different themes

## Getting started

To use **Ouds Global Raw Tokens**, add it as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  ouds_global_raw_tokens: ^1.0.0
```

## Usage

```dart
import 'package:ouds_global_raw_tokens/ouds_global_raw_tokens.dart';

void main() {
  // Accessing raw tokens for colors
  final Color primaryColor = OudsGlobalRawTokens.primaryColor;

  // Accessing other raw token values
  final double spacingUnit = OudsGlobalRawTokens.spacingUnit;

  print('Primary Color: $primaryColor');
  print('Spacing Unit: $spacingUnit');
}


```
## Additional information
Ouds Global Raw Tokens provides the fundamental raw values that serve as the foundation for creating and customizing themes within the OUDS framework. It defines a set of base tokens such as colors, spacing, typography, and other primitive design values that are globally used across different platforms and themes.



