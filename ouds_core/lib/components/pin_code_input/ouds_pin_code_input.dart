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
import 'package:flutter/scheduler.dart';
import 'package:ouds_core/components/button/internal/ouds_button_loading_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_style_modifier.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
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

  const OudsPinCodeInput({
    super.key,
    required this.length,
    this.roundedCorner,
    required this.style,
    this.helperText,
    this.isError
  });

  @override
  State<OudsPinCodeInput> createState() => _OudsPinCodeInputState();

}

class _OudsPinCodeInputState extends State<OudsPinCodeInput> {

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
    return Container();
  }

  Widget _buildAlternativeStyle(BuildContext context) {
    return Container();
  }
}
