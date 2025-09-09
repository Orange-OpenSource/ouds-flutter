import 'package:flutter/material.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_background_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_border_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';

/// Configuration for decorating the [OudsDigitInput] widget.
///
/// Provides properties to customize  hints, error status, hidden password and styling.
///
/// Parameters:
///
/// - [hintText]: A short placeholder or hint shown inside the input when empty.
///
/// - [hiddenPassword]: Controls whether the characters entered in the pin code input should be displayed as plain text or hidden.
///
///
class OudsDigitInputDecoration {
  final String? hintText; //placeholder
  final bool roundedCorner;


  const OudsDigitInputDecoration({
    this.hintText = "-",
    this.roundedCorner = false
  });
}

// TODO: Add documentation URL once it is available
///
/// A Digit Input refers to a single input box that accepts exactly one numeric character (0–9).
/// In the context of a PIN code or OTP, multiple digit inputs are placed side by side,
/// each holding one digit, to form the complete code.
///
/// Parameters:
/// - [style]: The [OudsPinCodeInputStyle] used for the Pin Code Input.
///   Use [OudsPinCodeInputStyle.defaultStyle] for a standard Pin Code Input,
///   or [OudsPinCodeInputStyle.alternative] outlined variant for lightweight or contextual use outside standard form pages
///
/// - [roundedCorner]: Defines the visual border shape of the Pin Code.
///   [False] for a square finish [True] For a finish with rounded corner.
///
/// - [isError]: The Error status indicates that the user input does not meet validation rules or expected formatting.
///   It provides immediate visual feedback, typically through a red border, error icon, and a clear, accessible error message positioned below the input
///
/// ## You can use [OudsDigitInput] like this :
///
/// This is the default style of the component.
///
///
/// ```dart
/// OudsDigitInput(
///       digitInputDecoration : OudsDigitInputDecoration()
///     );
/// ```
///
class OudsDigitInput extends StatefulWidget {

  final int index;
  final OudsTextInputStyle style;
  late final bool isError;
  final bool hiddenPassword;
  final OudsDigitInputDecoration? digitInputDecoration;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  late bool isHovered;
  final void Function(String,int)? onChanged;
  final void Function()? onEditingCompleting;

  OudsDigitInput({
    super.key,
    required this.index,
    this.style = OudsTextInputStyle.defaultStyle,
    this.isError = false,
    this.hiddenPassword = true,
    this.digitInputDecoration,

    this.controller,
    this.focusNode,
    this.isHovered = false,
    this.onChanged,
    this.onEditingCompleting,
  });

  @override
  State<OudsDigitInput> createState() => _OudsDigitInputState();

}

class _OudsDigitInputState extends State<OudsDigitInput> {


  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final l10n = OudsLocalizations.of(context);

    return Semantics(
      textField: true,
      label: l10n?.core_components_pin_code_input_input_a11y,
      child: _buildDigitInput(context,widget.index),
    );
  }

  Widget _buildDigitInput(BuildContext context, int index)
  {
    final pinCodeToken = OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(context).componentsTokens(context).textInput;
    // Modifiers for background color, text color, and border based on state
    final pinCodeInputBackgroundModifier = OudsPinCodeInputBackgroundColorModifier(context);
    final pinCodeInputBorderModifier = OudsPinCodeInputBorderModifier(context);
    final textInputBorderModifier = OudsTextInputBorderModifier(context);
    final pinCodeInputTextModifier = OudsPinCodeInputTextColorModifier(context);

    final theme = OudsTheme.of(context);

    final isFocused = widget.focusNode?.hasFocus;
    final state = OudsTextInputControlStateDeterminer(
      isFocused: isFocused!,
      isHovered: widget.isHovered,
      enabled: true,
    ).determineControlState();

    return InkWell(
      onHover: (hovering) {
        setState(() {
          widget.isHovered = hovering;
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
            borderRadius: textInputBorderModifier.getBorderRadius(context, widget.digitInputDecoration?.roundedCorner),
          ),
          child: TextField(
            cursorHeight: theme.fontTokens.lineHeightLabelLarge,
            obscureText: widget.hiddenPassword,
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
              hintText:  _hintText(index),
              hintStyle: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                color: theme.colorScheme(context).contentMuted,
              ),
            ),
            onChanged: (value) => widget.onChanged!(value, widget.index),
            onEditingComplete: widget.onEditingCompleting,
            onTapOutside: (_){
              widget.focusNode?.unfocus();
            },
          ),
        ),
      ),
    );
  }


  String? _hintText(int index) {
    if( (widget.focusNode != null &&  widget.focusNode!.hasFocus)
        || (widget.controller != null && widget.controller!.text.isNotEmpty)
        || widget.digitInputDecoration?.hintText == null) {
      return null;
    }
    else{
      return widget.digitInputDecoration?.hintText;
    }
  }
}
