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
/// OudsDigitInput
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_background_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_border_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/ouds_pin_code_input_control_state.dart';

/// Configuration for decorating the [OudsDigitInput] widget.
///
/// Provides properties to customize  hints, error status, hidden password and styling.
///
/// Parameters:
///
/// - [hintText]: A short placeholder or hint shown inside the input when empty.
///
/// - [roundedCorner]: Defines the visual border shape of the Pin Code.
///   `false` for a square finish , `true` For a finish with rounded corner.
///
/// - [hiddenPassword]: Controls whether the characters entered in the pin code input should be displayed as plain text or hidden.
///
/// - [style]: The [OudsPinCodeInputStyle] used for the Pin Code Input.
///   Use [OudsPinCodeInputStyle.defaultStyle] for a standard Pin Code Input,
///   or [OudsPinCodeInputStyle.alternative] outlined variant for lightweight or contextual use outside standard form pages
///
///
class OudsDigitInputDecoration {
  final String? hintText; //placeholder
  final bool roundedCorner;
  final bool hiddenPassword;
  final bool isOutlined;

  const OudsDigitInputDecoration({
    this.hintText,
    this.roundedCorner = false,
    this.hiddenPassword = true,
    this.isOutlined = false,
  });
}

// TODO: Add documentation URL once it is available
///
/// A Digit Input refers to a single input box that accepts exactly one numeric character (0–9).
/// In the context of a PIN code or OTP, multiple digit inputs are placed side by side,
/// each holding one digit, to form the complete code.
///
/// Parameters:
/// - [index]: The index of this digit input within the PIN code sequence.
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
/// - [digitInputDecoration]: Defines the decoration of each digit input box [OudsDigitInputDecoration]
/// - [controller]: Controller for managing the text value of this digit.
/// - [focusNode]: Focus node to manage keyboard focus for this digit input.
/// - [isHovered]:  Whether the digit input is currently hovered.
/// - [onChanged]: Callback triggered when the digit value changes. Provides the new value and the index of this digit.
///
///
/// ## You can use [OudsDigitInput] like this :
///
/// This is the default style of the component.
///
///
/// ```dart
/// OudsDigitInput(
///    index: index,
///    isError: true,
///    hiddenPassword: widget.hiddenPassword,
///    digitInputDecoration: OudsDigitInputDecoration(
///          hintText: widget.hintText,
///          style: widget.style,
///          roundedCorner: widget.roundedCorner
///        ),
///     focusNode: _focusNodes[index],
///     isHovered: _isHovered[index],
///     controller:  widget.controllers[index],
///     onChanged: (value, index) {},
///   )
/// ```
///
class OudsDigitInput extends StatefulWidget {

  final int index;
  late final bool isError;
  final OudsDigitInputDecoration? digitInputDecoration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  late final bool isHovered;
  final void Function(String,int)? onChanged;
  final OudsPinCodeInputLength length;

  OudsDigitInput({
    super.key,
    required this.index,
    this.isError = false,
    this.digitInputDecoration,
    this.controller,
    this.focusNode,
    this.isHovered = false,
    this.onChanged,
    this.length = OudsPinCodeInputLength.six,
  });

  @override
  State<OudsDigitInput> createState() => _OudsDigitInputState();

}

class _OudsDigitInputState extends State<OudsDigitInput> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final pinCodeInputBackgroundModifier = OudsPinCodeInputBackgroundColorModifier(context);
    final pinCodeInputBorderModifier = OudsPinCodeInputBorderModifier(context);
    final textInputBorderModifier = OudsTextInputBorderModifier(context);
    final pinCodeInputTextModifier = OudsPinCodeInputTextColorModifier(context);
    final theme = OudsTheme.of(context);
    final isFocused = widget.focusNode?.hasFocus;

    final state = OudsPinCodeInputControlStateDeterminer(
      isFocused: isFocused!,
      isHovered: _isHovered,
    ).determineControlState();

    return InkWell(
        onHover: (hovering) {
          if (!mounted) return;
          setState(() {
            _isHovered = hovering;
          });
        },
        child: Container(
          constraints: BoxConstraints(
              minHeight: textInputToken.sizeMinHeight,
              maxWidth: pinCodeToken.sizeMaxWidth,
            minWidth: pinCodeToken.sizeMinWidth
          ),
          child: Container(
            constraints: BoxConstraints(
                minHeight: textInputToken.sizeMinHeight
            ),
            padding: EdgeInsets.only(
              top : textInputToken.spacePaddingBlockDefault,
              bottom: textInputToken.spacePaddingBlockDefault,
              right: widget.length == OudsPinCodeInputLength.eight ? 0 : textInputToken.spacePaddingInlineDefault,
              left: widget.length == OudsPinCodeInputLength.eight ? 0 : textInputToken.spacePaddingInlineDefault,

            ),
            decoration: BoxDecoration(
              color: pinCodeInputBackgroundModifier.getPinCodeBackgroundColor(state, widget.isError, widget.digitInputDecoration!.isOutlined),
              border: pinCodeInputBorderModifier.getPinCodeBorder(state,widget.isError, widget.digitInputDecoration!.isOutlined),
              borderRadius: textInputBorderModifier.getBorderRadius(context, widget.digitInputDecoration?.roundedCorner),
            ),
            child: TextField(
              cursorHeight: theme.fontTokens.lineHeightLabelLarge,
              obscureText: widget.digitInputDecoration!.hiddenPassword,
              obscuringCharacter: "●",
              style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                color: theme.colorScheme(context).contentDefault,
              ),
              cursorColor: pinCodeInputTextModifier.getPinCodeCursorColor(widget.isError),
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLines: 1,
              maxLength: 1,
              buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null, // to hide the counter
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText:  widget.digitInputDecoration?.hintText,
                hintStyle: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                  color: theme.colorScheme(context).contentMuted,
                ),
              ),
              onChanged: (value) {
                widget.onChanged!(value, widget.index);
                setState(() {});
                },
              onTap: () {
                //cursor should be always at the end of digit input
                final text = widget.controller?.text;
                widget.controller?.selection = TextSelection.fromPosition(
                  TextPosition(offset: text!.length),
                );
                },
              ),
            ),
      ),
    );
  }
}
