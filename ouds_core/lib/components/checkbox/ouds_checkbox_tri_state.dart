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
import 'package:ouds_core/components/checkbox/internal/checkbox_background_modifier.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_border_modifier.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_state.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_tick_modifier.dart';
import 'package:ouds_core/ouds_theme.dart';

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
/// - [state]: Controls the TriStateCheckbox state (checked, unchecked, or indeterminate).
/// - [onChanged]: Callback invoked when the checkbox is clicked, requesting a change in the [ToggleableState]. If `null`,
///   the state is entirely controlled by a higher-level component.
/// - [enabled]: Controls whether the checkbox is clickable. If `false`, the checkbox will be disabled.
/// - [error]: Controls the error state of the checkbox.
///
/// See also: [OudsTriStateCheckboxSample] for usage example.

enum ToggleableState { off, indeterminate, on }

class OudsTriStateCheckbox extends StatefulWidget {
  final ToggleableState? state;
  final ValueChanged<ToggleableState>? onChanged;
  final bool enabled;
  final bool error;

  const OudsTriStateCheckbox({
    super.key,
    this.state,
    this.onChanged,
    this.enabled = true,
    this.error = false,
  });

  @override
  State<OudsTriStateCheckbox> createState() => _OudsTriStateCheckboxState();
}

class _OudsTriStateCheckboxState extends State<OudsTriStateCheckbox> {
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
    // Create an instance of CheckboxStateDeterminer
    final checkboxStateDeterminer = CheckboxStateDeterminer(
      enabled: widget.enabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    final checkboxState = checkboxStateDeterminer.determineCheckboxState();

    // Create an instance of CheckboxBorderModifier
    final checkboxBorderModifier = CheckboxBorderModifier(context);

    // Create an instance of CheckboxBackgroundModifier
    final checkboxBackgroundModifier = CheckboxBackgroundModifier(context);

    // Create an instance of CheckboxTickModifier
    final checkboxTickModifier = CheckboxTickModifier(context);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: OudsTheme.of(context).componentsTokens.checkbox.sizeMaxHeight,
        child: InkWell(
          onTap: widget.enabled
              ? () {
                  /// Handling the case where the checkbox state is null,
                  ///allowing a higher-level component to control the state

                  // Check if the state is null
                  if (widget.onChanged != null && widget.state != null) {
                    // Change state based on current state
                    ToggleableState newState = getNextState(widget.state!);

                    // Call the onChanged callback with the new state
                    widget.onChanged!(newState);
                  }
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
              maxHeight: OudsTheme.of(context).componentsTokens.checkbox.sizeMaxHeight,
              minHeight: OudsTheme.of(context).componentsTokens.checkbox.sizeMinHeight,
              minWidth: OudsTheme.of(context).componentsTokens.checkbox.sizeMinWidth,
            ),
            color: checkboxBackgroundModifier.getBackgroundColor(checkboxState),
            child: Center(
              child: Container(
                width: OudsTheme.of(context).componentsTokens.checkbox.sizeIndicator,
                height: OudsTheme.of(context).componentsTokens.checkbox.sizeIndicator,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: checkboxBorderModifier.getBorderColor(checkboxState, widget.error, isCheckedOrIndeterminate(widget.state)),
                    width: checkboxBorderModifier.getBorderWidth(checkboxState, isCheckedOrIndeterminate(widget.state)),
                  ),
                ),
                child: widget.state == ToggleableState.on
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: SvgPicture.string(
                            svgChecked,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              checkboxTickModifier.getTickColor(checkboxState, widget.error),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : widget.state == ToggleableState.off || widget.state == null
                        ? null
                        : Align(
                            alignment: Alignment.center,
                            child: SvgPicture.string(
                              svgIndeterminate,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                checkboxTickModifier.getTickColor(checkboxState, widget.error),
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

  /// Checks if the given checkbox state is either checked or indeterminate.
  ///
  /// This function is useful for determining if the checkbox is in a state
  /// that indicates some form of selection.
  ///
  /// @param [state] The current state of the checkbox, which can be:
  /// - `ToggleableState.on`: Indicates that the checkbox is checked.
  /// - `ToggleableState.off`: Indicates that the checkbox is unchecked.
  /// - `ToggleableState.indeterminate`: Indicates that the checkbox is in an indeterminate state.
  ///
  /// @returns `true` if the state is either `ToggleableState.on` or
  /// `ToggleableState.indeterminate`; otherwise, returns `false`.
  ///
  bool isCheckedOrIndeterminate(ToggleableState? state) {
    return state == ToggleableState.on || state == ToggleableState.indeterminate;
  }

  /// Determines the next state of the checkbox based on the current state.
  ///
  /// This function encapsulates the logic for transitioning between the three
  /// possible states of the checkbox: on, off, and indeterminate.
  ///
  /// @param [currentState] The current state of the checkbox, which can be:
  /// - `ToggleableState.on`: Indicates that the checkbox is currently checked.
  /// - `ToggleableState.off`: Indicates that the checkbox is currently unchecked.
  /// - `ToggleableState.indeterminate`: Indicates that the checkbox is currently in an indeterminate state.
  ///
  /// @returns The next state of the checkbox based on the provided `currentState`
  ///
  ToggleableState getNextState(ToggleableState? currentState) {
    if (currentState == null) {
      return ToggleableState.off;
    }
    switch (currentState) {
      case ToggleableState.on:
        return ToggleableState.off;
      case ToggleableState.off:
        return ToggleableState.indeterminate;
      case ToggleableState.indeterminate:
        return ToggleableState.on;
    }
  }
}
