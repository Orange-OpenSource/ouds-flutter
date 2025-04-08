import 'package:flutter/material.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A reusable control item that can represent a checkbox, radio button, or switch item.
class OudsControlItem extends StatelessWidget {
  final OudsControlItemState state; // Current state of the control item
  final String text; // Main text of the control item
  final String? helperText; // Optional helper text displayed below the main text
  final Widget? icon; // Optional icon displayed in the item
  final bool divider; // Controls the display of a divider at the bottom
  final bool inverted; // Determines the position of the icon and indicator
  final bool enabled; // Controls whether the item is clickable
  final bool readOnly; // Controls the read-only state of the item
  final bool error; // Controls the error state of the item
  final String errorComponentName; // Name of the component for error messages
  final Widget Function() indicator; // Widget representing the control indicator (checkbox, radio, etc.)
  final String checkedContentPreviewStatus; // Preview status for checked content
  final String? additionalText; // Additional text displayed below the main text
  final VoidCallback? onTap; // Callback for tap events

  const OudsControlItem({
    super.key,
    required this.state,
    required this.text,
    this.helperText,
    this.icon,
    this.divider = false,
    this.inverted = false,
    this.enabled = true,
    this.readOnly = false,
    this.error = false,
    required this.errorComponentName,
    required this.indicator,
    required this.checkedContentPreviewStatus,
    this.additionalText,
    this.onTap, // Add onTap parameter
  });

  @override
  Widget build(BuildContext context) {
    // Check if the item is in a forbidden state due to error conditions
    final isForbidden = error && (readOnly || !enabled);
    if (isForbidden) {
      throw Exception("An $errorComponentName set to readOnly or disabled with error parameter activated is not allowed.");
    }

    return Padding(
      padding: const EdgeInsets.all(16.0), // Padding of 12px around the container
      child: Container(
        /*
        decoration: BoxDecoration(
          border: Border.all(
            color: error ? Colors.red : Colors.grey, // Change color based on error state
            width: OudsTheme.of(context).borderTokens.widthDefault, // Use token for border width
          ),
          borderRadius: BorderRadius.circular(4.0), // Optional: rounded corners
        ),

         */
        constraints: BoxConstraints(
          minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMinHeight,
          minWidth: OudsTheme.of(context).componentsTokens.controlItem.sizeMinWidth,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: enabled && !readOnly ? onTap : null, // Make the whole area clickable
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center align items vertically
                  children: [
                    // Display the indicator (checkbox, radio, etc.)
                    Container(
                      color: Colors.yellow,
                      height: 20.0,
                      width: 20.0,
                      constraints: BoxConstraints(
                        minHeight: 28.0,
                        maxHeight: 96.0, // Set max height for the icon container
                      ),
                      child: indicator(),
                    ),
                    SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap), // Space between indicator and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: OudsTheme.of(context).fontTokens.sizeLabelLarge,
                                    letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelLarge,
                                    fontWeight: OudsTheme.of(context).fontTokens.weightBodyDefault,
                                    color: OudsTheme.of(context).colorsScheme.contentDefault,
                                  ),
                                ),
                                if (additionalText != null) SizedBox(height: 0.0), // Gap of 16px between texts
                                if (additionalText != null)
                                  Text(
                                    additionalText!,
                                    style: TextStyle(
                                      fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                                      fontWeight: OudsTheme.of(context).fontTokens.weightBodyDefault,
                                      color: OudsTheme.of(context).colorsScheme.contentMuted,
                                    ),
                                  ),
                                if (helperText != null) SizedBox(height: 0.0), // Gap of 16px between texts
                                if (helperText != null)
                                  Text(
                                    helperText!,
                                    style: TextStyle(
                                      fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                                      fontWeight: OudsTheme.of(context).fontTokens.weightBodyDefault,
                                      color: OudsTheme.of(context).colorsScheme.contentMuted,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap), // Space between text and icon
                    if (icon != null) // Display the icon on the right
                      Container(
                        color: Colors.blue,
                        height: 28,
                        width: 28,
                        constraints: BoxConstraints(
                          maxHeight: 96.0, // Set max height for the icon container
                        ),
                        child: icon!,
                      ),
                  ],
                ),
              ),
            ),
            // Place the divider here, at the bottom of the container
            //if (divider)
            Divider(
              height: 1, // Height of the divider
              thickness: OudsTheme.of(context).borderTokens.widthDefault,
            ),
          ],
        ),
      ),
    );
  }
}

/// Enum representing the state of the control item.
enum OudsControlItemState {
  enabled,
  hovered,
  pressed,
  disabled,
  focused,
  readOnly,
}

/// Icon class for OudsControlItem
class OudsControlItemIcon {
  final Widget icon;

  OudsControlItemIcon({required this.icon});
}
