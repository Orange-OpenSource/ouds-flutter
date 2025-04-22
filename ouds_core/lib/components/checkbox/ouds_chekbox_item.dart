import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

/// An OUDS checkbox item is a layout containing an OudsCheckbox, an associated text and several other optional elements.
class OudsCheckboxItem extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? helperText;
  final Widget? icon;
  final bool inverted;
  final bool readOnly;
  final bool isError;
  final bool enabled;
  final bool divider;

  const OudsCheckboxItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.helperText,
    this.icon,
    this.inverted = false,
    this.readOnly = false,
    this.isError = false,
    this.enabled = false,
    this.divider = false,
  });

  @override
  State<OudsCheckboxItem> createState() => _OudsCheckboxItemState();
}

class _OudsCheckboxItemState extends State<OudsCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return OudsControlItem(
      text: widget.title,
      value: widget.value,
      helperText: widget.helperText,
      icon: widget.icon,
      onChanged: widget.onChanged != null
          ? (newValue) {
              widget.onChanged!(!widget.value);
            }
          : null,
      error: widget.isError,
      errorComponentName: "OudsCheckboxItem or OudsTriStateCheckboxItem",
      indicator: () => OudsCheckbox(
        value: widget.value,
        onChanged: !widget.readOnly && widget.onChanged != null
            ? (newValue) {
                widget.onChanged!(newValue);
              }
            : null,
        error: widget.isError,
      ),
      divider: widget.divider,
      inverted: widget.inverted,
    );
  }
}
