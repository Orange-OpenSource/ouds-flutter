import 'package:flutter/material.dart';
import 'package:ouds_flutter/core/ouds_theme.dart';

class OudsButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OudsButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorTokens.primaryColor,
          textStyle: theme.fontTokens.bodyTextStyle,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(theme.borderTokens.borderRadius),
          ),
          minimumSize: Size(
              theme.sizeTokens.buttonHeight, theme.sizeTokens.buttonHeight)),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
