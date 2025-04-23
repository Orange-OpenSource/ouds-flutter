import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

/// An OUDS checkbox item is a layout containing an OudsCheckbox, an associated text and several other optional elements.
class OudsCheckboxItem extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? helperTitle;
  final Widget? icon;
  final bool inverted;
  final bool readOnly;
  final bool isError;
  final bool enabled;
  final bool divider;
  final bool tristate;

  const OudsCheckboxItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.helperTitle,
    this.icon,
    this.inverted = false,
    this.readOnly = false,
    this.isError = false,
    this.enabled = false,
    this.divider = false,
    this.tristate = false,
  });

  @override
  State<OudsCheckboxItem> createState() => _OudsCheckboxItemState();
}

class _OudsCheckboxItemState extends State<OudsCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return OudsControlItem(
      value: widget.value,
      onChanged: widget.onChanged != null
          ? (newValue) {
              // Handle toggling based on tristate
              bool? newCheckboxValue;
              if (widget.tristate) {
                // Toggle: true -> null, null -> false, false -> true
                if (widget.value == true) {
                  newCheckboxValue = null; // From true to null
                } else if (widget.value == null) {
                  newCheckboxValue = false; // From null to false
                } else {
                  newCheckboxValue = true; // From false to true
                }
              } else {
                // Only toggle between true and false
                newCheckboxValue = !(widget.value ?? false); // Toggle between true and false
              }
              widget.onChanged!(newCheckboxValue);
            }
          : null,
      text: widget.title,
      helperText: widget.helperTitle,
      icon: widget.icon,
      error: widget.isError,
      errorComponentName: "OudsCheckboxItem or OudsTriStateCheckboxItem",
      indicator: () => OudsCheckbox(
        value: widget.value,
        onChanged: !widget.readOnly && widget.onChanged != null
            ? (newValue) {
                widget.onChanged!(newValue);
              }
            : null,
        isError: widget.isError,
        tristate: widget.tristate,
      ),
      divider: widget.divider,
      inverted: widget.inverted,
    );
  }
}
