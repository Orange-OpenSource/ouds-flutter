import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

///
/// <a href="https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox" class="external" target="_blank">OUDS Checkbox design guidelines</a>
///
/// An OUDS checkbox item is a layout containing an [OudsCheckbox], an associated text and several other optional elements.
/// It can be used in a list as a list item or as a single element to validate general conditions.
/// By clicking on a checkbox item, the user changes the checked state of its checkbox.
///
/// In most cases, OUDS checkbox items span the entire width of the screen. Thus an horizontal padding is applied to the content.
/// This behavior can be disabled by setting the [inverted] parameter to `true`.
///
/// If you want to use a standalone checkbox please use [OudsCheckbox].
///
/// If you need an indeterminate state for the item's checkbox, please use the [tristate] parameter.
///
/// - [value]: Controls checked state of the item's checkbox.
/// - [onChanged]: Callback invoked on checkbox item click. If `null`, then this is passive and relies entirely on a higher-level component to control
///   the checked state.
/// - [title]: The main label of the checkbox item.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item.
/// - [inverted]: When `true`, the checkbox has a reversed layout.
/// - [readOnly]: Controls the read-only state of the checkbox item. When `true`, the item's checkbox is disabled but the texts remain in enabled color.
/// - [isError]: Controls the error state of the checkbox item.
/// - [enabled]: Controls the enabled state of the checkbox item.
/// - [divider]: Controls the display of a divider at the bottom of the checkbox item.
/// - [tristate]: Controls the tristate behavior of the checkbox item.
///
/// @sample OudsCheckboxItemSample

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
    return Semantics(
      checked: value,
      readOnly: readOnly,
      child: OudsControlItem(
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
      ),
    );
  }
}
