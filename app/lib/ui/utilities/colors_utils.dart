import 'dart:ui';

const String colorUnspecified = "#FF0000";

class ColorTokenItem {
  const ColorTokenItem({required this.name, required this.value});

  final String name;
  final Color? value;

  String? colorToHex(Color? color) {
    if (color == null) {
      return null;
    }
    // Convert the individual RGBA components (Red, Green, Blue) from double to int
    String hex =
        '#${(color.r * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Red
        '${(color.g * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Green
        '${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}'; // Blue
    return hex.toUpperCase();
  }
}
