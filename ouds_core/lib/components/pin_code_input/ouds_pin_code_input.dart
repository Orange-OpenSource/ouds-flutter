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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/pin_code_input/digit_input/ouds_digit_input.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';

/// The [OudsPinCodeInputLength] defines the length of OudsPinCodeInput.
enum OudsPinCodeInputLength{
  four,
  six,
  eight;

  int get digits {
    switch (this) {
      case OudsPinCodeInputLength.four:
        return 4;
      case OudsPinCodeInputLength.six:
        return 6;
      case OudsPinCodeInputLength.eight:
        return 8;
    }
  }
  const OudsPinCodeInputLength();
}

// TODO: Add documentation URL once it is available
///
/// A PIN code input is a specialized form field used to capture short, fixed-length numeric codes,
/// typically for authentication or confirmation purposes, such as a 4, 6 or 8-digit personal identification number (PIN).
///
/// It is often presented as a series of individual input fields or boxes, each representing a single digit,
/// to enhance readability and encourage accurate input.
///
/// This component must support smooth keyboard navigation (automatic focus shift, backspace handling),
/// secure input masking if needed. It is commonly used in sensitive flows like login, verification,
/// or transaction confirmation.
///
/// Parameters:
///
/// - [length]: Defines the fixed number of digits required for the PIN code , Example [OudsPinCodeInputLength.six.value]
///
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
///
/// - [helperText] Supporting text conveys additional information about the input field, such as how it will be used.
///   eg. 'Enter the 4-digit code sent to your phone.'.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///
/// - [controllers]: List of controllers managing the text of each digit input field.
///
/// - [onError]: Callback triggered when the error state changes.
///  `true` if the input is invalid, `false` otherwise.
///
/// - [onCompleted]: Callback triggered when the PIN input is completely filled.
/// Provides the concatenated PIN value as a string.
///
/// - [digitInputDecoration]: Defines the decoration of each digit input box [OudsDigitInputDecoration]
///
///
/// ## You can use [OudsPinCodeInput] like this :
///
/// ```dart
/// OudsPinCodeInput(
///   controllers: controllers,
///   helperText: "Please enter the 4-digit code sent to your phone.",
///   style: OudsTextInputStyle.defaultStyle,
///   length: OudsPinCodeInputLength.four,
///   digitInputDecoration: OudsDigitInputDecoration(
///        roundedCorner: true,
///        ),
///    onCompleted: (value){},
///    onError: (isError) {},
///      );
/// ```
///
class OudsPinCodeInput extends StatefulWidget {
  final OudsPinCodeInputLength length;
  final String? helperText;
  final String? errorText;
  late bool isError;
  final List<TextEditingController> controllers;
  final void Function(bool)? onError;
  final void Function(String)? onCompleted;
  final OudsDigitInputDecoration digitInputDecoration;

  OudsPinCodeInput({
    super.key,
    this.length = OudsPinCodeInputLength.six,
    this.helperText,
    this.errorText,
    required this.isError,
    required this.controllers,
    this.onError,
    this.onCompleted,
    required this.digitInputDecoration,
  });

  @override
  State<OudsPinCodeInput> createState() => _OudsPinCodeInputState();

}

class _OudsPinCodeInputState extends State<OudsPinCodeInput> {

  final List<FocusNode> _focusNodes = [];
  late List<bool> _isHovered;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _isHovered = List.filled(widget.length.digits, false); // init hover states
    for (int i = 0; i < widget.length.digits; i++) {
      final focusNode = FocusNode();
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          setState(() {
            currentIndex = i;
          });
        }
      });
      _focusNodes.add(focusNode);
    }
  }


  @override
  void didUpdateWidget(OudsPinCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.length.digits != widget.length.digits) {
      for (final node in _focusNodes) {
        node.dispose();
      }
      _focusNodes.clear();

      for (int i = 0; i < widget.length.digits; i++) {
        final focusNode = FocusNode();
        focusNode.addListener(() {
          if (!mounted) return;
          if (focusNode.hasFocus) {
            setState(() {
              currentIndex = i;
            });
          }
        });
        _focusNodes.add(focusNode);

        _isHovered = List.filled(widget.length.digits, false);
      }
    }
  }

  void _onChanged(String value, int index) {

    // Gestion du focus de manière sécurisée après la frame actuelle
    if (value.isNotEmpty && index < widget.length.digits - 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _focusNodes[index + 1].requestFocus();
      });
    } else {
      // Si on est sur le dernier digit et que c'est rempli, on unfocus
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _focusNodes[index].unfocus();
      });
    }

    if (value.isEmpty && index > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _focusNodes[index - 1].requestFocus();
      });
    }

    // Concatène les valeurs de tous les digits
    final code = widget.controllers.map((c) => c.text).join();

    // Déclenche onCompleted si tous les digits sont remplis
    if (code.length == widget.length.digits) {
      widget.onCompleted?.call(code);
    }

    bool allFilled =  widget.controllers.every((c) => c.text.isNotEmpty);
    widget.onError?.call(!allFilled);
  }


  @override
  void dispose() {
    if (!mounted) return;
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final digitsCount = widget.length.digits;

    return  Container(
      constraints: BoxConstraints(
          minHeight: textInputToken.sizeMinHeight
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: pinCodeToken.spaceColumnGapDigitInput,
            children: List.generate(digitsCount, (index) {

              return Flexible(
                  fit: FlexFit.loose,
                  child: OudsDigitInput(
                    index: index,
                    isError: widget.isError,
                    digitInputDecoration: OudsDigitInputDecoration(
                        roundedCorner: widget.digitInputDecoration.roundedCorner,
                      hiddenPassword: widget.digitInputDecoration.hiddenPassword,
                      style: widget.digitInputDecoration.style,
                    ),
                    focusNode: _focusNodes[index],
                    isHovered: _isHovered[index],
                    controller:  widget.controllers[index],
                    onChanged: (value, index) => _onChanged(value, index),
                  )
              );
            }),
          ),
          if (widget.helperText != null ||
              (widget.errorText != null && widget.isError)) ...[
            Container(
              constraints: BoxConstraints(
                maxWidth: digitsCount *
                    pinCodeToken.sizeMaxWidth +
                    (digitsCount - 1) *
                        pinCodeToken.spaceColumnGapDigitInput,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: textInputToken.spacePaddingBlockTopHelperText,
                ),
                child:
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    softWrap: true,
                    widget.errorText != null && widget.isError
                        ? widget.errorText!
                        : widget.helperText!,
                    style: theme.typographyTokens
                        .typeLabelDefaultMedium(context)
                        .copyWith(
                      color: OudsPinCodeInputTextColorModifier(context)
                          .getPinCodeHelperTextColor(widget.isError),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
