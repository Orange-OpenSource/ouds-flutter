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
/// OudsPinCodeInput
library;

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
/// - [helperText] Supporting text conveys additional information about the input field, such as how it will be used.
///   eg. 'Enter the 4-digit code sent to your phone.'.
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
/// - [controllers]: List of controllers managing the text of each digit input field.
/// - [onEditingComplete]: Callback triggered when the PIN input is completely filled.
///   Provides the concatenated PIN value as a string.
/// - [onChanged]: Callback triggered when the pin code value changes. Provides the new value of the pin code input.
/// - [digitInputDecoration]: Defines the decoration of each digit input box [OudsDigitInputDecoration]
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
///        hintText : "-",
///        roundedCorner: true,
///        style: OudsTextInputStyle.defaultStyle
///        ),
///    onEditingComplete: (value){},
///    onChanged: (value){},
///      );
/// ```
///
class OudsPinCodeInput extends StatefulWidget {
  final OudsPinCodeInputLength length;
  final String? helperText;
  late String? errorText;
  final List<TextEditingController>? controllers;
  final void Function(String)? onEditingComplete;
  final void Function(String)? onChanged;
  final OudsDigitInputDecoration digitInputDecoration;

  OudsPinCodeInput({
    super.key,
    this.length = OudsPinCodeInputLength.six,
    this.helperText,
    this.errorText,
    this.controllers,
    this.onEditingComplete,
    this.onChanged,
    required this.digitInputDecoration,
  });

  @override
  State<OudsPinCodeInput> createState() => _OudsPinCodeInputState();

}

class _OudsPinCodeInputState extends State<OudsPinCodeInput> {

  final List<FocusNode> _focusNodes = [];
  late List<bool> _isHovered;
  int currentIndex = 0;
  bool _hasEdited = false;

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

  // This method updates focus between fields, assembles the full PIN code,
  // and calls the appropriate callbacks:
  // - Moves focus to the next field if the current field is filled.
  // - Moves focus to the previous field if the current field is emptied.
  // - Unfocuses the current field if it's the last one.
  // - Calls [onChanged] with the current full PIN code.
  // - Calls [onEditingComplete] when the PIN is fully entered or completely cleared.
  void _onChanged(String value, int index) {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (value.isNotEmpty) {
        if (index < widget.length.digits - 1) {
          _focusNodes[index + 1].requestFocus();
        } else {
          _focusNodes[index].unfocus();
        }
      } else if (value.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    });

    final code = widget.controllers?.map((c) => c.text).join() ?? "";
    widget.onChanged?.call(code);

    final isComplete = code.length == widget.length.digits;
    final hasAnyFocus = _focusNodes.any((f) => f.hasFocus);

    if (isComplete) {
      widget.onEditingComplete?.call(code);
    } else if (code.isEmpty) {
      widget.onEditingComplete?.call("");
    } else if (!hasAnyFocus) {
      widget.onChanged?.call(code);
    }
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
    final isError = widget.errorText != null ||  (widget.errorText != null && widget.errorText!.isEmpty);

    return  Container(
      constraints: BoxConstraints(
          minHeight: textInputToken.sizeMinHeight
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: widget.length == OudsPinCodeInputLength.eight
                ? 6
                : pinCodeToken.spaceColumnGapDigitInput,
            children: List.generate(digitsCount, (index) {

              return Flexible(
                  fit: FlexFit.loose,
                  child: OudsDigitInput(
                      index: index,
                      isError: isError,
                      length: widget.length,
                      digitInputDecoration: OudsDigitInputDecoration(
                        hintText: _hintText(index),
                        roundedCorner: widget.digitInputDecoration.roundedCorner,
                        hiddenPassword: widget.digitInputDecoration.hiddenPassword,
                        isOutlined: widget.digitInputDecoration.isOutlined,
                      ),
                      focusNode: _focusNodes[index],
                      isHovered: _isHovered[index],
                      controller:  widget.controllers?[index],
                      onChanged: (value, index) {
                        _onChanged(value, index);
                        if (!_hasEdited) {
                          setState(() {
                            _hasEdited = true; // The user has interacted with the PIN at least once
                          });
                        }
                      },
                    ),

              );
            }),
          ),
          if (widget.helperText != null ||
              (widget.errorText != null && isError)) ...[
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
                    widget.errorText != null && isError
                        ? widget.errorText!
                        : widget.helperText!,
                    style: theme.typographyTokens
                        .typeLabelDefaultMedium(context)
                        .copyWith(
                      color: OudsPinCodeInputTextColorModifier(context)
                          .getPinCodeHelperTextColor(isError),
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

  String? _hintText(int index) {
    final hint = widget.digitInputDecoration.hintText;
    if (hint == null) return null;

    final hasFocus = _focusNodes[index].hasFocus;
    final text = widget.controllers?[index].text;

    // Special case: all fields are empty, user has already edited, and cursor is invisible
    final isPinCompletelyEmpty = widget.controllers?.every((c) => c.text.isEmpty);
    if (isPinCompletelyEmpty != null && isPinCompletelyEmpty && hasFocus && _hasEdited) {
      return hint;
    }

    // No hint if the field is focused (cursor visible)
    if (hasFocus) return null;

    // Show hint if the field is empty
    if (text != null && text.isEmpty) return hint;

    // Otherwise, no hint
    return null;
  }
}
