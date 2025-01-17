import 'package:flutter/material.dart';

import 'ouds_border_style.dart';

class OudsBorderModifier {
  final OudsBorderStyle borderStyle;
  final Color borderColor;
  final double borderWidth;

  OudsBorderModifier({
    required this.borderStyle,
    required this.borderColor,
    required this.borderWidth,
  });

  Border toBorder() {
    switch (borderStyle) {
      case OudsBorderStyle.solid:
        return Border.all(color: borderColor, width: borderWidth);
      case OudsBorderStyle.dashed:
        // For dashed borders, custom implementation required.
        // Use a library like flutter_dash for complex dashed styles.
        return Border.all(
            color: borderColor, width: borderWidth); // Placeholder.
      case OudsBorderStyle.dotted:
        // Same as above, need a custom painter.
        return Border.all(
            color: borderColor, width: borderWidth); // Placeholder.
    }
  }
}
