import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

///
/// <a href="https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox" class="external" target="_blank">OUDS Checkbox design guidelines</a>
///
/// Checkboxes are input controls that allow users to select one or more options from a number of choices.
///
/// The **checkbox item variant** can function as a simple input with a label, or it can be combined with optional elements such as helper text, a divider, or an icon,
/// allowing it to suit various use cases.
///
/// The OUDS checkbox item layout contains an [OudsCheckbox]. By clicking on a checkbox item, the user changes the checked state of its checkbox.
///
/// In most cases, OUDS checkbox items span the entire width of the screen. Thus an horizontal padding is applied to the content.
/// This behavior can be disabled by setting the [inverted] parameter to `true`.
///
/// If you want to use a standalone checkbox please use [OudsCheckbox].
///
/// If you need an indeterminate state for the item's checkbox, please use the [tristate] parameter.
///
/// - [value]: Controls checked state of the item's checkbox.
/// - [onChanged]:e Callback invoked on checkbox item click. If `null`, then this is passive and relies entirely on a higher-level component to control
///   the checked state.
/// - [title]: The main label of the checkbox item.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item. By default, it has a trailing position. If [reversed] is set to `true`, it is displayed as a leading element.
/// - [reversed]: When `false`, the checkbox has a leading position and the optional [icon] has a trailing position. Otherwise, it is reversed.
/// - [readOnly]: Controls the read only state of the checkbox item. When `true` the item's checkbox is disabled but the texts and the icon remain in
///   enabled color. Note that if it is set to `true` and [enabled] is set to `false`, the checkbox item will be displayed in disabled state.
/// - [isError]: Controls the error state of the checkbox item.
/// - [enabled]: Controls the enabled state of the checkbox item. When `false`, the checkbox, the texts and the optional icon are disabled, and the item
///   will not be clickable
/// - [divider]: Controls the display of a divider at the bottom of the checkbox item.
/// - [tristate]: Controls the tristate behavior of the checkbox item.
///
/// # You can use [OudsCheckboxItem] like this :
///
///
/// ## Ouds checkbox item with icon and helper text :
///
/// It is possible to display or hide an icon. If displayed, this option includes functionality to choose any Solaris icon.
/// It is possible to display or hide accompanying text for the main label.
///
/// ```dart
/// OudsCheckboxItem(
///   value: isChecked,
///   title: 'Label',
///   helperTitle: 'Helper text',
///   reversed: false,
///   readOnly: false,
///   icon: 'assets/ic_heart/svg',
///   isError: false,
///   divider: true,
///   onChanged: (bool? value) {
///      setState(() {
///         isChecked = value;
///       });
///     },
/// );
/// ```
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://zeroheight-uploads.s3.eu-west-1.amazonaws.com/20bde5199bc58c1d0200ff?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3AVNYHQKW6TV54VB%2F20250610%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20250610T160753Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=edfdd04d4087414c93482f01078359d11bcc26f1eff09d3730b47be03d26dd5b" alt="Light mode" width="100%">
///   </div>
/// </div>
///
///

class OudsCheckboxItem extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? helperTitle;
  final String? icon;
  final bool reversed;
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
    this.reversed = false,
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
        reversed: reversed,
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
