// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/control/internal/controller/interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

enum ToggleableState { off, indeterminate, on }

///
/// An [OUDS Checkbox](https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox) component as per the design guidelines of OUDS.
///
/// This widget represents a parent checkbox, which can have a parent-child relationship with other checkboxes.
/// When the parent checkbox is checked, all child checkboxes are also checked. If the parent checkbox is unchecked,
/// all child checkboxes are unchecked. If some, but not all, child checkboxes are checked, the parent checkbox becomes
/// an indeterminate checkbox.
///
/// The following parameters are available:
///
/// - [value]: Controls checked state of the checkbox.
/// - [onChanged]: Callback invoked when the checkbox is clicked, requesting a change in the [ToggleableState].
///   If `null`, the checkbox will be in a non-interactive state, meaning it will not respond to user interactions
///   and its state will be entirely controlled by a higher-level component.
///   In this case, the checkbox will not change its state when clicked, and the visual representation will remain static.
///   If provided, the callback will be invoked with the new state when the checkbox is clicked.
/// - [tristate]: If true, the checkboxes value can be true, false, or null. If false, only true and false states are managed.
/// - [isError]: Controls the error state of the checkbox.
///
/// See also: [OudsCheckboxSample] for usage example.
class OudsCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool isError;
  final bool tristate;

  const OudsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isError = false,
    this.tristate = false,
  });

  @override
  State<OudsCheckbox> createState() => _OudsCheckboxState();
}

class _OudsCheckboxState extends State<OudsCheckbox> {
  String svgChecked = '''<svg width="12" height="10" viewBox="0 0 12 10" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M11.2621 2.04661L5.22765 9.04663C5.05487 9.24679 4.78924 9.375 4.49138 9.375C4.1935 9.375 3.92806 9.24668 3.75525 9.04653L0.737872 5.54661C0.6086 5.39683 0.53125 5.20683 0.53125 5C0.53125 4.75837 0.636777 4.53964 0.807402 4.38129L1.18458 4.03129C1.3552 3.87293 1.59092 3.775 1.85129 3.775C2.08562 3.775 2.29985 3.85452 2.46476 3.98583L4.30279 5.87502L9.88099 0.861666C10.0496 0.714884 10.2764 0.625 10.5258 0.625C11.0466 0.625 11.4688 1.01676 11.4688 1.50002C11.4688 1.70681 11.3914 1.89683 11.2621 2.04661Z" fill="#F15E00"/>
</svg>''';

  String svgIndeterminate = '''<svg width="12" height="2" viewBox="0 0 12 2" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="12" height="2" fill="#F15E00"/>
</svg>''';

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Get controller GetX states
    final interactionController = Get.isRegistered<InteractionStateController>() ? Get.find<InteractionStateController>() : Get.put(InteractionStateController());

    final checkboxStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onChanged != null,
      isPressed: interactionController.isPressed.value || _isPressed,
      isHovered: interactionController.isHovered.value || _isHovered,
    );

    final checkboxState = checkboxStateDeterminer.determineControlState();
    final checkboxBorderModifier = OudsControlBorderModifier(context);
    final checkboxBackgroundModifier = OudsControlBackgroundModifier(context);
    final checkboxTickModifier = OudsControlTickModifier(context);
    final checkbox = OudsTheme.of(context).componentsTokens.checkbox;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: checkbox.sizeMaxHeight,
        child: InkWell(
          onTap: widget.onChanged != null
              ? () {
                  bool? newValue;
                  if (widget.tristate) {
                    // Cycle through false -> true -> null
                    if (widget.value == true) {
                      newValue = null; // From true to null
                    } else if (widget.value == null) {
                      newValue = false; // From null to false
                    } else {
                      newValue = true; // From false to true
                    }
                  } else {
                    newValue = !widget.value!; // Toggle between true and false
                  }
                  widget.onChanged!(newValue);
                }
              : null,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: (hovering) {
            setState(() {
              _isHovered = hovering;
            });
          },
          onHighlightChanged: (highlighted) {
            setState(() {
              _isPressed = highlighted;
            });
          },
          child: Container(
            constraints: BoxConstraints(
              maxHeight: checkbox.sizeMaxHeight,
              minHeight: checkbox.sizeMinHeight,
              minWidth: checkbox.sizeMinWidth,
            ),
            color: !interactionController.isPressed.value ? checkboxBackgroundModifier.getBackgroundColor(checkboxState) : Colors.transparent,
            child: Center(
              child: Container(
                width: checkbox.sizeIndicator,
                height: checkbox.sizeIndicator,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: checkboxBorderModifier.getBorderColor(checkboxState, widget.isError, isCheckedOrIndeterminate(widget.value)),
                    width: checkboxBorderModifier.getBorderWidth(checkboxState, isCheckedOrIndeterminate(widget.value), checkbox),
                  ),
                ),
                child: widget.value == true
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: SvgPicture.string(
                            svgChecked,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              checkboxTickModifier.getTickColor(checkboxState, widget.isError),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : widget.value == false
                        ? null
                        : Align(
                            alignment: Alignment.center,
                            child: SvgPicture.string(
                              svgIndeterminate,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                checkboxTickModifier.getTickColor(checkboxState, widget.isError),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isCheckedOrIndeterminate(bool? value) {
    return value == true || value == null; // Only check for true state
  }
}
