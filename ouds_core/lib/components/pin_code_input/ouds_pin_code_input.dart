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
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';

/// The [OudsPinCodeInputLength] defines the length of OudsPinCodeInput.
enum OudsPinCodeInputLength{
  four(4),
  six(6),
  eight(8);

  final int value;
  const OudsPinCodeInputLength(this.value);
}

/// Configuration for decorating the [OudsPinCodeInput] widget.
///
/// Provides properties to customize  hints, error status, hidden password and styling.
///
/// Parameters:
///
/// - [hintText]: A short placeholder or hint shown inside the input when empty.
/// - [hiddenPassword]: Controls whether the characters entered in the pin code input should be displayed as plain text or hidden.
///
class OudsDigitInputDecoration {
  final String? hintText; //placeholder
  final bool hiddenPassword;

  const OudsDigitInputDecoration({
    this.hintText = "-",
    this.hiddenPassword = true,
  });
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
/// - [length]: Defines the fixed number of digits required for the PIN code , Example [OudsPinCodeInputLength.six.value]
/// - [roundedCorner]: Defines the visual border shape of the Pin Code.
///   [False] for a square finish [True] For a finish with rounded corner.
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
/// - [helperText] Supporting text conveys additional information about the input field, such as how it will be used.
///   eg. 'Enter the 4-digit code sent to your phone.'.
///
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
  bool isError;
  final void Function(String)? onCompleted;
  final OudsDigitInputDecoration digitInputDecoration;

  OudsPinCodeInput({
    super.key,
    this.length = OudsPinCodeInputLength.six,
    this.roundedCorner = false,
    this.style = OudsTextInputStyle.defaultStyle,
    this.helperText,
    this.isError = false,
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

  @override
  void initState() {
    super.initState();
    _isHovered = List.filled(widget.length.value, false); // init hover states
    for (int i = 0; i < widget.length.value; i++) {
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

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length.value - 1) {
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
    double totalWidth = widget.length.value * pinCodeToken.sizeMaxWidth +
        (widget.length.value - 1) * pinCodeToken.spaceColumnGapDigitInput;

    return Semantics(
      textField: true,
      label: l10n?.core_components_pin_code_input_input_a11y,
        child: Container(
          width: totalWidth,
          constraints: BoxConstraints(
            minHeight: textInputToken.sizeMinHeight
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: pinCodeToken.spaceColumnGapDigitInput,
              children: List.generate(widget.length.value, (index) {

                return Flexible(child: _buildDigitInput(context,index));
              }),
            ),
            if (widget.helperText != null) ...[
              Padding(
                padding: EdgeInsets.only(
                  top: textInputToken.spacePaddingBlockTopHelperText,
                ),
                child:  Text(
                  softWrap: true,
                //  overflow: TextOverflow.visible,
                  widget.helperText!,
                  style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
                    color: OudsTextInputTextColorModifier(context).getPinCodeHelperTextColor(widget.isError),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );


  }

  Widget _buildDigitInput(BuildContext context, int index)
  {
    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    // Modifiers for background color, text color, and border based on state
    final pinCodeInputBackgroundModifier = OudsTextInputBackgroundColorModifier(context);
    final pinCodeInputBorderModifier = OudsTextInputBorderModifier(context);
    final pinCodeInputTextModifier = OudsTextInputTextColorModifier(context);

    final theme = OudsTheme.of(context);

    final isFocused = _focusNodes[index].hasFocus;
    final state = OudsTextInputControlStateDeterminer(
      isFocused: isFocused,
      isHovered: _isHovered[index],
      enabled: true,
    ).determineControlState();

    return InkWell(
      onHover: (hovering) {
        setState(() {
          _isHovered[index] = hovering;
        });
      },
      child: Container(
        constraints: BoxConstraints(
            minWidth: pinCodeToken.sizeMinWidth,
            minHeight: textInputToken.sizeMinHeight,
            maxWidth: pinCodeToken.sizeMaxWidth
        ),
        child: Container(
          constraints: BoxConstraints(
              minHeight: textInputToken.sizeMinHeight
          ),
          padding: EdgeInsets.only(
            top : textInputToken.spacePaddingBlockDefault,
            bottom: textInputToken.spacePaddingBlockDefault,
            right: textInputToken.spacePaddingInlineDefault,
            left: textInputToken.spacePaddingInlineDefault,

          ),
          decoration: BoxDecoration(
            color: pinCodeInputBackgroundModifier.getPinCodeBackgroundColor(state, widget.isError, widget.style),
            /// Bottom border styling; full border if style is not default
            border: pinCodeInputBorderModifier.getPinCodeBorder(state,widget.isError, widget.style),
            // Border radius if enabled in theme configuration
            borderRadius: pinCodeInputBorderModifier.getBorderRadius(context, widget.roundedCorner),
          ),
          child: TextField(
            cursorHeight: theme.fontTokens.lineHeightLabelLarge,
            obscureText: widget.digitInputDecoration.hiddenPassword,
            obscuringCharacter: "●",
            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
              color: theme.colorScheme(context).contentDefault,
            ),
            cursorColor: pinCodeInputTextModifier.getPinCodeCursorColor(widget.isError),
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLines: 1,
            maxLength: 1,
            buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null, // to hide the counter
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:  _hintText(index),
              hintStyle: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                color: theme.colorScheme(context).contentMuted,
              ),
            ),
            onChanged: (value) => _onChanged(value, index),
            onEditingComplete: _checkPin,
            onTapOutside: (_){
              _focusNodes[index].unfocus();
            },
          ),
        ),
      ),
    );
  }

  void _checkPin() {
    bool allFilled = _controllers.every((c) => c.text.isNotEmpty);

    setState(() {
      widget.isError = allFilled ? false : true;
    });

  }

  String? _hintText(int index) {
    if(_focusNodes[index].hasFocus
        || _controllers[index].text.isNotEmpty
        || widget.digitInputDecoration.hintText == null) {
      return null;
    }
    else{
      return widget.digitInputDecoration.hintText;
    }
  }
}
