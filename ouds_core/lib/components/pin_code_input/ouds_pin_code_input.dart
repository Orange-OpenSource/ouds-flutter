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
/// {@category PIN code input}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/pin_code_input/digit_input/ouds_digit_input.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The [OudsPinCodeInputLength] defines the length of OudsPinCodeInput.
enum OudsPinCodeInputLength {
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

/// [OUDS PIN Code Input Design Guidelines](https://r.orange.fr/r/S-ouds-doc-pin-code-input)
///
/// **Reference design version : 1.2.0**
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
/// ### You can use [OudsPinCodeInput] component in your project, customizing parameters as needed :
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
  bool hasAnyFocus = false;
  bool? _previousHasFocus;

  @override
  void initState() {
    super.initState();
    _isHovered = List.filled(widget.length.digits, false); // init hover states
    for (int i = 0; i < widget.length.digits; i++) {
      final focusNode = FocusNode();
      focusNode.addListener(() => _handleFocusChange(focusNode, i));
      _focusNodes.add(focusNode);
    }
    FocusManager.instance.addListener(_onGlobalFocusChange);
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

  @override
  void dispose() {
    if (!mounted) return;
    FocusManager.instance.removeListener(_onGlobalFocusChange);
    for (final node in _focusNodes) {
      node.removeListener(() => _handleFocusChange(node, _focusNodes.indexOf(node)));
      node.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange(FocusNode focusNode, int index) {
    if (focusNode.hasFocus) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final digitsCount = widget.length.digits;
    final isError = widget.errorText != null || (widget.errorText != null && widget.errorText!.isEmpty);
    final l10n = OudsLocalizations.of(context);
    final hintSemanticText = "${ widget.errorText != null && isError ? widget.errorText! : widget.helperText != null ? widget.helperText! : ''}"
        " , ${l10n?.core_common_hint_a11y}";

    return Container(
      constraints: BoxConstraints(
        minHeight: textInputToken.sizeMinHeight,
        minWidth: textInputToken.sizeMinWidth,
        maxWidth: widget.digitInputDecoration.constrainedMaxWidth ? textInputToken.sizeMaxWidth : double.infinity,
      ),
      child: Column(
        mainAxisAlignment: widget.digitInputDecoration.constrainedMaxWidth ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Semantics(
            hint: hintSemanticText,
            label: isError ? l10n?.core_common_onError_a11y : l10n?.core_pinCodeInput_pinCode_label_a11y(digitsCount),
            child: Row(
              mainAxisAlignment: widget.digitInputDecoration.constrainedMaxWidth ? MainAxisAlignment.start : MainAxisAlignment.center,
              spacing: widget.length == OudsPinCodeInputLength.eight ? 6 : pinCodeToken.spaceColumnGapDigitInput,
              children: List.generate(digitsCount, (index) {
                return Flexible(
                  fit: FlexFit.loose,
                  child: Semantics(
                    liveRegion: true,
                    label: "${l10n?.core_pinCodeInput_digitCode_label_a11y(index + 1)}, "
                        "${!widget.digitInputDecoration.hiddenPassword  && widget.controllers != null? widget.controllers![index].text : ''}, "
                        "${l10n?.core_pinCodeInput_trait_a11y}",
                    child: OudsDigitInput(
                      index: index,
                      isError: isError,
                      length: widget.length,
                      digitInputDecoration: OudsDigitInputDecoration(
                        hintText: _hintText(index),
                        hiddenPassword: widget.digitInputDecoration.hiddenPassword,
                        isOutlined: widget.digitInputDecoration.isOutlined,
                      ),
                      focusNode: _focusNodes[index],
                      isHovered: _isHovered[index],
                      controller: widget.controllers?[index],
                      onChanged: (value, index) {
                        _handleDigitInput(value, index);
                        if (!_hasEdited) {
                          setState(() {
                            _hasEdited = true; // The user has interacted with the PIN at least once
                          });
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          if (widget.helperText != null || (widget.errorText != null && isError)) ...[
            Container(
              constraints: BoxConstraints(
                maxWidth: widget.digitInputDecoration.constrainedMaxWidth ? double.infinity : digitsCount * pinCodeToken.sizeMaxWidth + (digitsCount - 1) * pinCodeToken.spaceColumnGapDigitInput,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: textInputToken.spacePaddingBlockTopHelperText,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ExcludeSemantics(
                    child: Text(
                      softWrap: true,
                      widget.errorText != null && isError ? widget.errorText! : widget.helperText!,
                      style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
                            color: OudsPinCodeInputTextColorModifier(context).getPinCodeHelperTextColor(isError),
                          ),
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

  // This method updates focus between fields, assembles the full PIN code,
  // and calls the appropriate callbacks:
  void _handleDigitInput(String value, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final totalDigits = widget.length.digits;
      final controllers = widget.controllers!;
      // Case 1: user pasted a code (more than 3 characters)
      if (value.length > 3) {
        _handlePaste(value);
        return;
      }

      // Case 2: user tried to add another character into a filled field
      if (value.length == 2) {
        controllers[index]
          ..text = value.characters.last
          ..selection = TextSelection.collapsed(offset: 1);
        return;
      }

      final code = controllers.map((c) => c.text).join();
      widget.onChanged?.call(code);

      // Case 3: deletion  stay in the same field
      if (value.isEmpty) return;

      // Case 4: normal input  move focus forward
      if (index < totalDigits - 1) {
        _focusNodes[index + 1].requestFocus();
      } else if (code.length == totalDigits) {
        _focusNodes[index].unfocus();
        widget.onEditingComplete?.call(code);
      }
    });
  }

  //handle copy past pin code
  void _handlePaste(String value) {
    final totalDigits = widget.length.digits;
    final controllers = widget.controllers!;
    final digits = value.characters.take(totalDigits).toList();

    for (int i = 0; i < digits.length; i++) {
      controllers[i].text = digits[i];
    }

    final code = controllers.map((c) => c.text).join();
    widget.onChanged?.call(code);

    final isComplete = code.length == totalDigits;

    if (isComplete) {
      for (final node in _focusNodes) {
        node.unfocus();
      }
      widget.onEditingComplete?.call(code);
    } else {
      final nextIndex = digits.length.clamp(0, totalDigits - 1);
      _focusNodes[nextIndex].requestFocus();
    }
  }

  // This method is called whenever the global focus changes, using a FocusManager listener.
  // It updates the internal `hasAnyFocus` state to reflect whether any of the PIN input fields currently have focus.
  //
  // - If the focus state has not changed since the last check, the method returns immediately.
  // - Otherwise, it updates the `_previousHasFocus` to the new state.
  // - If all fields have lost focus (`hasAnyFocus == false`) and the user has interacted with the PIN (`_hasEdited`),
  //   it triggers the `onEditingComplete` callback with the current PIN code.
  // - If any field still has focus (`hasAnyFocus == true`), it triggers the `onChanged` callback with the current PIN code.
  //
  // This ensures that the component reacts only to real focus changes, and that the PIN validation
  // or change callbacks are called at the appropriate time.
  void _onGlobalFocusChange() {
    setState(() {
      hasAnyFocus = _focusNodes.any((f) => f.hasFocus);
    });

    if (_previousHasFocus == hasAnyFocus) return;

    _previousHasFocus = hasAnyFocus;
    final code = widget.controllers?.map((c) => c.text).join() ?? "";

    if (!hasAnyFocus && _hasEdited) {
      widget.onEditingComplete?.call(code);
    } else if (hasAnyFocus) {
      widget.onChanged?.call(code);
    }
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
