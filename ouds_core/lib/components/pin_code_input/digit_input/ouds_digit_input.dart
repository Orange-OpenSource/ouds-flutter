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
/// @nodoc

import 'package:flutter/material.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_border_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_background_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_border_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';
import 'package:ouds_core/components/pin_code_input/internal/ouds_pin_code_input_control_state.dart';
import 'package:ouds_core/components/pin_code_input/ouds_pin_code_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// [OUDS Pin Code Input guidelines](https://unified-design-system.orange.com/472794e18/p/9767bc-pin-code-input-v1)
///
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
/// - [isOutlined]: A boolean value that defines the visual style of the Pin Code Input.
///   Set to `false` for the default filled style used in standard form pages,
///   or `true` for the outlined variant, which provides a lighter appearance suitable for contextual or secondary use.
/// - [constrainedMaxWidth]: When `true`, the item width is constrained to a maximum value defined by the design system.
///   When `false`, no specific width constraint is applied, allowing the component to size itself or follow external modifiers.
///   Defaults to `false`.
/// - [keyboardType]: Soft keyboard requested when a digit cell is focused. Defaults to [OudsPinCodeInputKeyboardType.numeric].
///   Use [OudsPinCodeInputKeyboardType.alphanumeric] to allow letters in addition to digits.
///
class OudsDigitInputDecoration {
  final String? hintText; //placeholder
  final bool hiddenPassword;
  final bool isOutlined;
  final bool constrainedMaxWidth;
  final OudsPinCodeInputKeyboardType keyboardType;

  const OudsDigitInputDecoration({
    this.hintText,
    this.hiddenPassword = true,
    this.isOutlined = false,
    this.constrainedMaxWidth = false,
    this.keyboardType = OudsPinCodeInputKeyboardType.numeric,
  });
}

// TODO: Add documentation URL once it is available
///
/// A display-only digit cell for the PIN code input. Renders a single character
/// (or a mask bullet when [OudsDigitInputDecoration.hiddenPassword] is true) and
/// delegates all keyboard interaction to the parent's single capture TextField.
///
class OudsDigitInput extends StatefulWidget {
  final int index;
  final bool isError;
  final OudsDigitInputDecoration? digitInputDecoration;
  final TextEditingController? controller;
  final bool isFocused;
  final OudsPinCodeInputLength length;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const OudsDigitInput({
    super.key,
    required this.index,
    this.isError = false,
    this.digitInputDecoration,
    this.controller,
    this.isFocused = false,
    required this.length,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<OudsDigitInput> createState() => _OudsDigitInputState();
}

class _OudsDigitInputState extends State<OudsDigitInput>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    if (widget.isFocused) _cursorController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(OudsDigitInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFocused && !oldWidget.isFocused) {
      _cursorController.repeat(reverse: true);
    } else if (!widget.isFocused && oldWidget.isFocused) {
      _cursorController.stop();
      _cursorController.value = 1.0; // keep opaque so next focus starts visible
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinCodeToken =
        OudsTheme.of(context).componentsTokens(context).pinCodeInput;
    final textInputToken =
        OudsTheme.of(context).componentsTokens(context).textInput;
    final pinCodeInputBackgroundModifier =
        OudsPinCodeInputBackgroundColorModifier(context);
    final pinCodeInputBorderModifier = OudsPinCodeInputBorderModifier(context);
    final textInputBorderModifier = OudsFormFieldsBorderModifier(context);
    final pinCodeInputTextModifier = OudsPinCodeInputTextColorModifier(context);
    final theme = OudsTheme.of(context);

    final state = OudsPinCodeInputControlStateDeterminer(
      isFocused: widget.isFocused,
      isHovered: _isHovered,
    ).determineControlState();

    final rawText = widget.controller?.text ?? '';
    final isObscured = widget.digitInputDecoration?.hiddenPassword ?? true;
    final displayText = isObscured && rawText.isNotEmpty ? '●' : rawText;
    final hint = rawText.isEmpty ? widget.digitInputDecoration?.hintText : null;
    final cursorColor =
        pinCodeInputTextModifier.getPinCodeCursorColor(widget.isError);
    final cursorHeight = theme.fontTokens.lineHeightLabelLarge;

    return ExcludeSemantics(
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onHover: (hovering) {
          if (!mounted) return;
          setState(() {
            _isHovered = hovering;
          });
        },
        child: Container(
          height: textInputToken.sizeMinHeight,
          constraints: BoxConstraints(
            maxWidth: pinCodeToken.sizeMaxWidth,
            minWidth: pinCodeToken.sizeMinWidth,
          ),
          decoration: BoxDecoration(
            color: pinCodeInputBackgroundModifier.getPinCodeBackgroundColor(
              state,
              widget.isError,
              widget.digitInputDecoration!.isOutlined,
            ),
            border: pinCodeInputBorderModifier.getPinCodeBorder(
              state,
              widget.isError,
              widget.digitInputDecoration!.isOutlined,
            ),
            borderRadius: textInputBorderModifier.getBorderRadius(context),
          ),
          child: Center(
            child: displayText.isNotEmpty
                ? Text(
                    displayText,
                    style: theme.typographyTokens
                        .typeLabelDefaultLarge(context)
                        .copyWith(
                          color: theme.colorScheme(context).contentDefault,
                        ),
                    textAlign: TextAlign.center,
                  )
                : widget.isFocused
                ? AnimatedBuilder(
                    animation: _cursorController,
                    builder: (_, _) => Opacity(
                      opacity: _cursorController.value,
                      child: Container(
                        width: 2,
                        height: cursorHeight,
                        color: cursorColor,
                      ),
                    ),
                  )
                : Text(
                    hint ?? '',
                    style: theme.typographyTokens
                        .typeLabelDefaultLarge(context)
                        .copyWith(
                          color: theme.colorScheme(context).contentMuted,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
