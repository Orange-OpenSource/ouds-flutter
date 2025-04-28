import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

/// An OUDS checkbox item is a layout containing an OudsCheckbox, an associated text and several other optional elements.
class OudsCheckboxItem extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? helperTitle;
  final String? icon;
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
    this.enabled = true,
    this.divider = false,
    this.tristate = false,
  });

  @override
  Widget build(BuildContext context) {
    return OudsControlItem(
      text: title,
      helperText: helperTitle,
      icon: icon,
      error: isError,
      readOnly: readOnly,
      errorComponentName: "OudsCheckboxItem",
      divider: divider,
      inverted: inverted,
      onTap: onChanged != null
          ? () {
              bool? newValue;
              if (tristate) {
                if (value == true) {
                  newValue = null;
                } else if (value == null) {
                  newValue = false;
                } else {
                  newValue = true;
                }
              } else {
                newValue = !(value ?? false);
              }
              onChanged!(newValue);
            }
          : null,
      indicator: () => OudsCheckbox(
        value: value,
        onChanged: !readOnly && onChanged != null ? onChanged : null,
        isError: isError,
        tristate: tristate,
      ),
    );
  }
}
