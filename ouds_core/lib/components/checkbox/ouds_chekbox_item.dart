import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control_item/ouds_control_item.dart';

/// An OUDS checkbox item is a layout containing an OudsCheckbox, an associated text and several other optional elements.
class OudsCheckboxItem extends StatelessWidget {
  final bool checked; // Controls checked state of the item's checkbox
  final String text; // The main text of the checkbox item
  final ValueChanged<bool>? onCheckedChange; // Callback invoked on checkbox item click
  final String? helperText; // Optional text displayed below the main text
  final Widget? icon; // Optional icon displayed in the item
  final bool enabled; // Controls the enabled state of the checkbox item
  final bool readOnly; // Controls the read-only state of the checkbox item
  final bool error; // Controls the error state of the checkbox item

  const OudsCheckboxItem({
    super.key,
    required this.checked,
    required this.text,
    this.onCheckedChange,
    this.helperText,
    this.icon,
    this.enabled = true,
    this.readOnly = false,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return OudsControlItem(
      state: enabled && !readOnly ? OudsControlItemState.enabled : OudsControlItemState.disabled,
      text: text,
      helperText: helperText,
      icon: icon,
      divider: false, // You can set this to true if you want a divider
      inverted: false, // Set to true if you want to invert the icon and checkbox
      enabled: enabled,
      readOnly: readOnly,
      error: error,
      errorComponentName: "OudsCheckboxItem",
      indicator: () => OudsCheckbox(
        value: checked,
        onChanged: onCheckedChange,
        enabled: enabled && !readOnly,
        error: error,
      ),
      checkedContentPreviewStatus: checked ? "Selected" : "Unselected",
      onTap: () {
        bool currentCheckedState = checked;
        if (onCheckedChange != null) {
          onCheckedChange!(!currentCheckedState);
        }
      },
    );
  }
}
