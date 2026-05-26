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
library;

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
/// Visual decoration configuration for each digit cell in an [OudsPinCodeInput].
///
/// Parameters:
/// - [hintText]: Placeholder shown in an empty, unfocused cell (e.g. `"-"`).
/// - [hiddenPassword]: When `true` (default), filled cells show `●` instead of
///   the actual character.
/// - [isOutlined]: `false` (default) for a filled style, `true` for outlined.
/// - [constrainedMaxWidth]: When `true`, cells are capped to the design-token
///   maximum width. Defaults to `false`.
/// - [keyboardType]: Keyboard variant for the cells. Defaults to
///   [OudsPinCodeInputKeyboardType.numeric].
///
class OudsDigitInputDecoration {
  final String? hintText;
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

/// A purely visual widget that renders a single digit cell of a PIN code input.
///
/// Keyboard input is handled entirely by the parent [OudsPinCodeInput] via a
/// single hidden [TextField]; [displayValue] is simply passed down for rendering.
///
/// ## Visual states
///
/// | Condition | Content shown |
/// |---|---|
/// | Not focused, empty | Hint placeholder |
/// | Not focused, filled | Value (`●` when `hiddenPassword` is `true`) |
/// | Focused, empty | Blinking cursor |
/// | Focused, filled — normal mode | Blinking cursor only |
/// | Focused, filled — accessibility mode | Value **+** blinking cursor |
///
/// The last row applies when [isAccessibilityActive] is `true`, giving
/// assistive-technology users a clear indicator that the cell is selected even
/// after it has been filled.
///
/// ## Example
///
/// ```dart
/// // Typically created by OudsPinCodeInput — shown here for illustration.
/// OudsDigitInput(
///   index: 0,
///   isFocused: true,
///   displayValue: '3',
///   isAccessibilityActive: false,
///   digitInputDecoration: OudsDigitInputDecoration(
///     hintText: '-',
///     hiddenPassword: true,
///   ),
/// )
/// ```
///
/// Parameters:
/// - [index]: Zero-based position of this cell in the PIN sequence.
/// - [isError]: When `true`, the cell adopts the error visual style.
/// - [isFocused]: Whether this cell is the currently active position.
/// - [displayValue]: Character to display; empty string when the cell is empty.
/// - [isAccessibilityActive]: Enables the combined value + cursor display.
/// - [digitInputDecoration]: Decoration options (hint, masking, style, …).
///
class OudsDigitInput extends StatefulWidget {
  final int index;
  final bool isError;
  final OudsDigitInputDecoration? digitInputDecoration;
  final bool isFocused;
  final String displayValue;
  final bool isAccessibilityActive;

  const OudsDigitInput({
    super.key,
    required this.index,
    this.isError = false,
    this.digitInputDecoration,
    this.isFocused = false,
    this.displayValue = '',
    this.isAccessibilityActive = false,
  });

  @override
  State<OudsDigitInput> createState() => _OudsDigitInputState();
}

class _OudsDigitInputState extends State<OudsDigitInput>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  /// Drives the blinking cursor animation (530 ms, repeating).
  late final AnimationController _cursorBlink;

  @override
  void initState() {
    super.initState();
    _cursorBlink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    );
    // Start blinking immediately if the cell is already focused.
    if (widget.isFocused) {
      _cursorBlink.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(OudsDigitInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync cursor animation with focus state.
    if (widget.isFocused && !_cursorBlink.isAnimating) {
      _cursorBlink.repeat(reverse: true);
    } else if (!widget.isFocused && _cursorBlink.isAnimating) {
      _cursorBlink.stop();
      _cursorBlink.value = 0;
    }
  }

  @override
  void dispose() {
    _cursorBlink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinCodeToken = OudsTheme.of(
      context,
    ).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(
      context,
    ).componentsTokens(context).textInput;
    final backgroundModifier = OudsPinCodeInputBackgroundColorModifier(context);
    final borderModifier = OudsPinCodeInputBorderModifier(context);
    final formBorderModifier = OudsFormFieldsBorderModifier(context);
    final theme = OudsTheme.of(context);
    final cursorColorModifier = OudsPinCodeInputTextColorModifier(context);

    final isOutlined = widget.digitInputDecoration?.isOutlined ?? false;
    final hiddenPassword = widget.digitInputDecoration?.hiddenPassword ?? true;

    final state = OudsPinCodeInputControlStateDeterminer(
      isFocused: widget.isFocused,
      isHovered: _isHovered,
    ).determineControlState();

    // Show hint only when the cell is empty and not focused.
    final showHint = widget.displayValue.isEmpty && !widget.isFocused;

    // Mask filled value with a bullet when hiddenPassword is enabled.
    final displayText = widget.displayValue.isNotEmpty
        ? (hiddenPassword ? '●' : widget.displayValue)
        : '';

    // Show cursor whenever the cell is focused.
    final showCursor = widget.isFocused;

    // In accessibility mode: show value + cursor together on a focused filled
    // cell. In normal mode: cursor only.
    final showValueWithCursor =
        showCursor &&
        widget.displayValue.isNotEmpty &&
        widget.isAccessibilityActive;

    final cursorColor = cursorColorModifier.getPinCodeCursorColor(
      widget.isError,
    );
    final cursorHeight = theme.fontTokens.lineHeightLabelLarge;

    // Builds the animated blinking cursor.
    Widget buildCursor() => AnimatedBuilder(
      animation: _cursorBlink,
      builder: (context, _) => Opacity(
        opacity: _cursorBlink.value,
        child: Container(width: 2, height: cursorHeight, color: cursorColor),
      ),
    );

    return ExcludeSemantics(
      child: MouseRegion(
        onEnter: (_) {
          if (mounted) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (mounted) setState(() => _isHovered = false);
        },
        child: Container(
          height: textInputToken.sizeMinHeight,
          constraints: BoxConstraints(
            maxWidth: pinCodeToken.sizeMaxWidth,
            minWidth: pinCodeToken.sizeMinWidth,
          ),
          decoration: BoxDecoration(
            color: backgroundModifier.getPinCodeBackgroundColor(
              state,
              widget.isError,
              isOutlined,
            ),
            border: borderModifier.getPinCodeBorder(
              state,
              widget.isError,
              isOutlined,
            ),
            borderRadius: formBorderModifier.getBorderRadius(context),
          ),
          child: Center(
            child: showValueWithCursor
                // Accessibility + focused + filled: value and cursor side-by-side.
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        displayText,
                        style: theme.typographyTokens
                            .typeLabelDefaultLarge(context)
                            .copyWith(
                              color: theme.colorScheme(context).contentDefault,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      buildCursor(),
                    ],
                  )
                // Focused: cursor only.
                : showCursor
                ? buildCursor()
                // Not focused, empty: hint placeholder.
                : showHint && widget.digitInputDecoration?.hintText != null
                ? Text(
                    widget.digitInputDecoration!.hintText!,
                    style: theme.typographyTokens
                        .typeLabelDefaultLarge(context)
                        .copyWith(
                          color: theme.colorScheme(context).contentMuted,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  )
                // Not focused, filled: masked or plain value.
                : Text(
                    displayText,
                    style: theme.typographyTokens
                        .typeLabelDefaultLarge(context)
                        .copyWith(
                          color: theme.colorScheme(context).contentDefault,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
