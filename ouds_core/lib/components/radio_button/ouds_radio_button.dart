/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///
/// [OUDS Radio Button Design Guidelines](https://unified-design-system.orange.com/472794e18/p/90c467-radio-button)
///
/// An OUDS radio button widget.
///
/// This widget displays a radio button that is part of a group. It determines its selected state
/// by comparing its own [value] with the current [groupValue]. It also supports an error state
/// and notifies changes through [onChanged].
///
///  Parameters:
///  [value] The value represented by this radio button. Used to determine selection.
///  [groupValue] The currently selected value in the radio button group.
/// This radio button is considered selected if [value] == [groupValue].
///  [onChanged] Callback triggered when the user selects this radio button.
/// If `null`, the radio button is disabled and non-interactive.
///  [isError] Indicates whether the radio button is in an error state.
///
/// ## You can use [OudsRadioButton] like this :
///
/// ### Selection status
///
/// Typically, a radio button has two main states: Selected and Unselected.
///
///  'selected' : The radio button is actively chosen by the user, indicating the associated option is selected.
///  'unselected' : The radio button is not chosen, showing the user that the associated option is available but not selected.
///
///
///
/// ```dart
///  OudsRadioButton<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///        // Handle radio button change state.
///    }
///    isError: false,
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://zeroheight-uploads.s3.eu-west-1.amazonaws.com/1bcee8b7a28f2d66fbdc94?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3AVNYHQKW6TV54VB%2F20250610%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Date=20250610T160753Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=0a6568cb646a0538dbc3a2e5f499c56c17ee5080383d12817c84b15b19a1dfc4" alt="Light mode" width="100%">
///   </div>
/// </div>
///
///
///
///

class OudsRadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final bool isError;

  const OudsRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isError = false,
  });

  @override
  OudsRadioButtonState<T> createState() => OudsRadioButtonState<T>();
}

class OudsRadioButtonState<T> extends State<OudsRadioButton<T>> {
  String packageName = 'ouds_core';

  bool _isHovered = false;
  bool _isPressed = false;
  bool get _selected => widget.value == widget.groupValue;

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final isEnabled = widget.onChanged != null;

    final radioButtonStateDeterminer = OudsControlStateDeterminer(
      enabled: isEnabled,
      isPressed: isPressed || _isPressed,
      isHovered: isHovered || _isHovered,
    );

    final radioButtonState = radioButtonStateDeterminer.determineControlState();
    final radioButtonBorderModifier = OudsControlBorderModifier(context);
    final radioButtonBackgroundModifier = OudsControlBackgroundModifier(context);
    final radioButtonTickModifier = OudsControlTickModifier(context);
    final radioButton = OudsTheme.of(context).componentsTokens(context).radioButton;

    return SizedBox(
      width: radioButton.sizeMaxHeight,
      child: InkWell(
        onTap: widget.onChanged != null ? () => widget.onChanged!(widget.value) : null,
        splashColor: Colors.transparent,
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
            maxHeight: radioButton.sizeMaxHeight,
            minHeight: radioButton.sizeMinHeight,
            minWidth: radioButton.sizeMinWidth,
          ),
          color: !isPressed ? radioButtonBackgroundModifier.getBackgroundColor(radioButtonState) : Colors.transparent,
          child: Center(
            child: Container(
              width: radioButton.sizeIndicator,
              height: radioButton.sizeIndicator,
              decoration: BoxDecoration(
                border: Border.all(
                  color: radioButtonBorderModifier.getBorderColor(radioButtonState, widget.isError, _selected),
                  width: radioButtonBorderModifier.getBorderWidth(radioButtonState, _selected, radioButton),
                ),
                borderRadius: BorderRadius.circular(radioButtonBorderModifier.getBorderRadius(radioButton)),
              ),
              child: _selected
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: SvgPicture.asset(
                          AppAssets.symbols.symbolsRadioSelected,
                          package: packageName,
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            radioButtonTickModifier.getTickColor(radioButtonState, widget.isError),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  void updateValue(T value) {
    widget.onChanged!(value);
  }
}
