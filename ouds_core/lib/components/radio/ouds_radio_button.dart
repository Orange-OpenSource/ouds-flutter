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

/// <a href="https://unified-design-system.orange.com/472794e18/p/90c467-radio-button" class="external" target="_blank"> OUDS Radio Button design guidelines</a>
///
/// An OUDS Radio Button.
///
/// @param [value] Controls checked state of the radioButton.
/// @param [updateGlobalValue] Callback invoked on radioButton click. If `null`, then this is passive and relies entirely on a higher-level component to control
/// the checked state.
/// @param [enabled] Controls the enabled state of the radioButton. When `false`, this radioButton will not be clickable.
/// @param [isError] Controls the error state of the radioButton.
///
/// @sample com.orange.ouds.core.component.samples.OudsRadiobuttonSample
///

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

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
  String svgPressed =
  '''<svg width="10" height="10" viewBox="0 0 10 10" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M9.06348 5C9.06348 7.24366 7.24463 9.0625 5.00098 9.0625C2.75732 9.0625 0.938477 7.24366 0.938477 5C0.938477 2.75634 2.75732 0.9375 5.00098 0.9375C7.24463 0.9375 9.06348 2.75634 9.06348 5Z" fill="#F15E00"/>
</svg>''';

  bool _isHovered = false;
  bool _isPressed = false;
  bool get _selected => widget.value == widget.groupValue;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onChanged != null;

    final radioButtonStateDeterminer = OudsControlStateDeterminer(
      enabled: isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );
    final radioButtonState = radioButtonStateDeterminer.determineControlState();
    final radioButtonBorderModifier = OudsControlBorderModifier(context);
    final radioButtonBackgroundModifier = OudsControlBackgroundModifier(context);
    final radioButtonTickModifier = OudsControlTickModifier(context);
    final radioButton = OudsTheme.of(context).componentsTokens.radioButton;

    return SizedBox(
      width: radioButton.sizeMaxHeight,
      child: InkWell(
        onTap:widget.onChanged != null
            ? () => widget.onChanged!(widget.value)
            : null,
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
          color: radioButtonBackgroundModifier
              .getBackgroundColor(radioButtonState),
          child: Center(
            child: Container(
              width: radioButton.sizeIndicator,
              height: radioButton.sizeIndicator,
              decoration: BoxDecoration(
                border: Border.all(
                  color: radioButtonBorderModifier.getBorderColor(
                      radioButtonState, widget.isError, _selected),
                  width: radioButtonBorderModifier.getBorderWidth(
                      radioButtonState, _selected, radioButton),
                ),
                borderRadius: BorderRadius.circular(radioButtonBorderModifier.getBorderRadius(radioButton)),
              ),
              child: _selected
                  ? Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: SvgPicture.string(
                    svgPressed,
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

