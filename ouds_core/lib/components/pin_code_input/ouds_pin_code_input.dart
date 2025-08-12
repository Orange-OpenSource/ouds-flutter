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


/// The [OudsPinCodeInputStyle] defines the pin code input's visual behavior and feedback.
enum OudsPinCodeInputStyle {
  defaultStyle,
  alternative,
}

enum OudsPinCodeInputState {
  enabled,
  hover,
  focus,
  disabled
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
/// - [lenght]: Defines the fixed number of digits required for the PIN code (4|6|8)
/// - [roundedCorner]: Defines the visual border shape of the Pin Code.
///   [False] for a square finish [True] For a finish with rounded corner.
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
/// - [helperText] Supporting text conveys additional information about the input field, such as how it will be used.
///   eg. 'Enter the 4-digit code sent to your phone.'. It's a boolean value
///
///
///
/// ## You can use [OudsPinCodeInput] like this :
///
/// This is the default style of the component.
///
///
/// ```dart
/// OudsPinCodeInput(
///       style: OudsPinCodeInputStyle.defaultStyle,
///     );
/// ```
///
class OudsPinCodeInput extends StatefulWidget {
  final int length;
  final bool? roundedCorner;
  final OudsPinCodeInputStyle style;
  final bool? isError;
  final String? helperText;
  final void Function(String)? onCompleted;

  const OudsPinCodeInput({
    super.key,
    required this.length,
    this.roundedCorner,
    this.style = OudsPinCodeInputStyle.defaultStyle,
    this.helperText,
    this.isError,
    this.onCompleted
  });

  @override
  State<OudsPinCodeInput> createState() => _OudsPinCodeInputState();

}

class _OudsPinCodeInputState extends State<OudsPinCodeInput> {

  final List<FocusNode> _focusNodes = [];
  final List<TextEditingController> _controllers = [];

  final bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      _focusNodes.add(FocusNode());
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
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
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
    switch (widget.style){
      case OudsPinCodeInputStyle.defaultStyle:
        return _buildDefaultStyle(context);
      case OudsPinCodeInputStyle.alternative:
        return _buildAlternativeStyle(context);
    }
  }

  Widget _buildDefaultStyle(BuildContext context) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTapUp: (_) {
            //focusNode.requestFocus();
          },
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: textInput.spaceColumnGapDefault,
            children: List.generate(widget.length, (index) {
              return SizedBox(
                width: 50,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,

                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => _onChanged(value, index),
                ),
              );
            }),
          ),
        ),
        if (widget.helperText != null) ...[
          Padding(
            padding: EdgeInsets.only(
              top: textInput.spacePaddingBlockTopHelperText,
              left: textInput.spacePaddingInlineDefault,
              right: textInput.spacePaddingInlineDefault,
            ),
            child: Text(
              widget.helperText!,
              style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
                //color: inputTextTextModifier.getHelperTextColor(inputTextState, widget.isError!),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAlternativeStyle(BuildContext context) {
    return Container();
  }
}
