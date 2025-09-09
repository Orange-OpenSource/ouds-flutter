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
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
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
/// - [style]: The [OudsPinCodeInputStyle] used for the Pin Code Input.
///   Use [OudsPinCodeInputStyle.defaultStyle] for a standard Pin Code Input,
///   or [OudsPinCodeInputStyle.alternative] outlined variant for lightweight or contextual use outside standard form pages
///
/// - [length]: Defines the fixed number of digits required for the PIN code , Example [OudsPinCodeInputLength.six.value]
///
/// - [roundedCorner]: Defines the visual border shape of the Pin Code.
///   [False] for a square finish [True] For a finish with rounded corner.
///
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
///
/// - [helperText] Supporting text conveys additional information about the input field, such as how it will be used.
///   eg. 'Enter the 4-digit code sent to your phone.'.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///
/// ## You can use [OudsPinCodeInput] like this :
///
/// This is the default style of the component.
///
///
/// ```dart
/// OudsPinCodeInput(
///       style: OudsPinCodeInputStyle.alternative,
///       digitInputDecoration : OudsDigitInputDecoration(showPlaceholder : true)
///       length: OudsPinCodeInputLength.four
///     );
/// ```
///
class OudsPinCodeInput extends StatefulWidget {
  final OudsPinCodeInputLength length;
  final bool roundedCorner;
  final OudsTextInputStyle style;
  final String? helperText;
  final String? errorText;
  final bool? isError;
  final bool hiddenPassword;
  final void Function(String)? onCompleted;
  final OudsDigitInputDecoration digitInputDecoration;

  OudsPinCodeInput({
    super.key,
    this.roundedCorner = false,
    this.length = OudsPinCodeInputLength.six,
    this.style = OudsTextInputStyle.defaultStyle,
    this.helperText,
    this.errorText,
    this.isError,
    this.hiddenPassword = true,
    this.onCompleted,
    required this.digitInputDecoration,
  });

  @override
  State<OudsPinCodeInput> createState() => _OudsPinCodeInputState();

}

class _OudsPinCodeInputState extends State<OudsPinCodeInput> {

  final List<FocusNode> _focusNodes = [];
  final List<TextEditingController> _controllers = [];
  late List<bool> _isHovered;
  int currentIndex = 0;
  bool _isError = false;

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
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focus in _focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }

  /// Called when the widget configuration changes (e.g., the pin code length changes).
  /// This updates the internal lists of controllers, focus nodes, and hover states
  /// to match the new length, ensuring the UI rebuilds correctly without errors.
  @override
  void didUpdateWidget(covariant OudsPinCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newLength = widget.length.digits;
    final oldLength = oldWidget.length.digits;

    if (newLength != oldLength) {
      _isHovered = List.filled(newLength, false);

      if (newLength > oldLength) {
        for (int i = oldLength; i < newLength; i++) {
          final focusNode = FocusNode();
          focusNode.addListener(() {
            if (focusNode.hasFocus) {
              setState(() {
                currentIndex = i;
              });
            }
          });
          _focusNodes.add(focusNode);
          _controllers.add(TextEditingController());
        }
      } else {
        for (int i = _controllers.length - 1; i >= newLength; i--) {
          _controllers[i].dispose();
          _focusNodes[i].dispose();
          _controllers.removeAt(i);
          _focusNodes.removeAt(i);
        }
      }

      setState(() {});
    }
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length.digits - 1) {
      _focusNodes[index + 1].requestFocus();
    }else {
      _focusNodes[index].unfocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    String code = _controllers.map((controller) => controller.text).join();
    if (code.length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(code);
    }
  }


  @override
  Widget build(BuildContext context) {

    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final l10n = OudsLocalizations.of(context);
    final digitsCount = widget.length.digits;
    double totalWidth = digitsCount * pinCodeToken.sizeMaxWidth +
        (widget.length.digits - 1) * pinCodeToken.spaceColumnGapDigitInput;

    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: pinCodeToken.spaceColumnGapDigitInput,
              children: List.generate(digitsCount, (index) {

                return Expanded(
                    child: OudsDigitInput(
                    index: index,
                    style: widget.style,
                    isError: widget.isError != null ? widget.isError! : _isError,
                    hiddenPassword: widget.hiddenPassword,
                    digitInputDecoration: OudsDigitInputDecoration(
                        roundedCorner: widget.roundedCorner
                    ),
                      focusNode: _focusNodes[index],
                      isHovered: _isHovered[index],
                      controller: _controllers[index],
                      onChanged: (value, index) => _onChanged(value, index),
                      onEditingCompleting: () => _checkPin,
                    )
                );
              }),
            ),
            if (widget.helperText != null ||widget.errorText != null) ...[
              Padding(
                padding: EdgeInsets.only(
                  top: textInputToken.spacePaddingBlockTopHelperText,
                ),
                child:  Text(
                  softWrap: true,
                  widget.errorText != null ? widget.errorText! : widget.helperText!,
                  style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
                    color: OudsPinCodeInputTextColorModifier(context).getPinCodeHelperTextColor(widget.isError!),
                  ),
                ),
              )
            ],
          ],
      );
  }

  void _checkPin() {
    bool allFilled = _controllers.every((c) => c.text.isNotEmpty);
    setState(() {
      _isError = !allFilled;
    });

  }
}
