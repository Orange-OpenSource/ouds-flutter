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
import 'package:flutter/services.dart';
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

/// The [OudsPinCodeInputKeyboardType] defines which soft keyboard the digit cells request.
///
/// - [numeric]: numeric keyboard (digits 0–9 only). Non-digit input is filtered out, including paste.
/// - [alphanumeric]: standard text keyboard. Any character is accepted.
///
/// Defaults to [numeric] to match the historical PIN behavior.
enum OudsPinCodeInputKeyboardType {
  numeric,
  alphanumeric;

  const OudsPinCodeInputKeyboardType();
}

/// [OUDS PIN Code Input Design Guidelines](https://r.orange.fr/r/S-ouds-doc-pin-code-input)
///
/// **Reference design version : 1.2.0**
///
/// PIN code input is a UI element that allows to capture short, fixed-length numeric codes,
/// typically for authentication or confirmation purposes, such as a four,
/// six or height-digit personal identification number (PIN).
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
  // Single capture controller — one TextInputConnection keeps the keyboard
  // state (current page, shift state, IME context) intact across "cell" transitions.
  late final TextEditingController _captureController;
  late final FocusNode _captureFocusNode;

  int _activeIndex = 0;
  bool _hasEdited = false;
  bool _previousHasFocus = false;

  @override
  void initState() {
    super.initState();
    final initialCode = widget.controllers?.map((c) => c.text).join() ?? '';
    _captureController = TextEditingController(text: initialCode);
    _captureFocusNode = FocusNode();
    _captureFocusNode.addListener(_onCaptureFocusChange);
    _activeIndex = initialCode.length.clamp(0, widget.length.digits - 1);
  }

  @override
  void didUpdateWidget(OudsPinCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Sync capture controller when the caller resets the external controllers
    // (e.g. clears the PIN after a failed attempt).
    final externalCode = widget.controllers?.map((c) => c.text).join() ?? '';
    if (_captureController.text != externalCode) {
      _captureController.value = TextEditingValue(
        text: externalCode,
        selection: TextSelection.collapsed(offset: externalCode.length),
      );
      setState(() {
        _activeIndex = externalCode.length.clamp(0, widget.length.digits - 1);
      });
    }
  }

  @override
  void dispose() {
    _captureFocusNode.removeListener(_onCaptureFocusChange);
    _captureFocusNode.dispose();
    _captureController.dispose();
    super.dispose();
  }

  // ─────────────────────────── input handling ───────────────────────────

  void _onCaptureChanged(String value) {
    if (!mounted) return;

    final totalDigits = widget.length.digits;
    final controllers = widget.controllers;

    // Distribute each character to the corresponding external controller.
    if (controllers != null && controllers.length >= totalDigits) {
      for (int i = 0; i < totalDigits; i++) {
        final char = i < value.length ? value[i] : '';
        if (controllers[i].text != char) {
          controllers[i].value = TextEditingValue(
            text: char,
            selection: TextSelection.collapsed(offset: char.length),
          );
        }
      }
    }

    if (!_hasEdited && value.isNotEmpty) _hasEdited = true;

    setState(() {
      _activeIndex = value.length.clamp(0, totalDigits - 1);
    });

    widget.onChanged?.call(value);

    if (value.length == totalDigits) {
      widget.onEditingComplete?.call(value);
      // Defer unfocus so the platform finishes processing the last keystroke
      // before we close the keyboard.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _captureFocusNode.unfocus();
      });
    }
  }

  void _onCaptureFocusChange() {
    if (!mounted) return;
    final hasFocus = _captureFocusNode.hasFocus;

    if (hasFocus) {
      setState(() {
        _activeIndex = _captureController.text.length.clamp(
          0,
          widget.length.digits - 1,
        );
      });
    }

    if (_previousHasFocus == hasFocus) return;
    _previousHasFocus = hasFocus;

    if (hasFocus) {
      widget.onChanged?.call(_captureController.text);
    }
  }

  // ─────────────────────────── paste pipeline ───────────────────────────

  Future<String?> _safeReadClipboard() async {
    try {
      final data = await Clipboard.getData(
        Clipboard.kTextPlain,
      ).timeout(const Duration(seconds: 2), onTimeout: () => null);
      return data?.text;
    } catch (_) {
      return null;
    }
  }

  Future<void> _pasteFromClipboard() async {
    final text = await _safeReadClipboard();
    if (!mounted) return;
    if (text == null || text.isEmpty) return;
    _distributeCode(text);
  }

  void _distributeCode(String raw) {
    final totalDigits = widget.length.digits;

    final sanitized =
        widget.digitInputDecoration.keyboardType ==
            OudsPinCodeInputKeyboardType.numeric
        ? raw.replaceAll(RegExp(r'\D'), '')
        : raw;
    if (sanitized.isEmpty) return;

    final truncated = sanitized.characters.take(totalDigits).toString();

    _captureController.value = TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(offset: truncated.length),
    );

    // TextField.onChanged does not fire for programmatic controller updates,
    // so trigger the distribution logic explicitly.
    _onCaptureChanged(truncated);
  }

  // ─────────────────────────────── build ────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final pinCodeToken = OudsTheme.of(
      context,
    ).componentsTokens(context).pinCodeInput;
    final textInputToken = OudsTheme.of(
      context,
    ).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final digitsCount = widget.length.digits;
    final isError =
        widget.errorText != null ||
        (widget.errorText != null && widget.errorText!.isEmpty);
    final l10n = OudsLocalizations.of(context);
    final hintSemanticText =
        "${widget.errorText != null && isError
            ? widget.errorText!
            : widget.helperText != null
            ? widget.helperText!
            : ''}"
        " , ${l10n?.core_common_hint_a11y}";
    final hasFocus = _captureFocusNode.hasFocus;

    return Container(
      constraints: BoxConstraints(
        minHeight: textInputToken.sizeMinHeight,
        minWidth: textInputToken.sizeMinWidth,
        maxWidth: widget.digitInputDecoration.constrainedMaxWidth
            ? textInputToken.sizeMaxWidth
            : double.infinity,
      ),
      child: Column(
        mainAxisAlignment: widget.digitInputDecoration.constrainedMaxWidth
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          // ── Hidden capture TextField ──────────────────────────────────
          // A single invisible TextField keeps one stable TextInputConnection
          // open for the entire PIN session, preventing the keyboard from
          // resetting its IME state (page, shift, suggestions) between cells.
          ExcludeSemantics(
            child: ClipRect(
              child: SizedBox(
                height: 0,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  alignment: Alignment.topCenter,
                  child: IgnorePointer(
                    child: TextField(
                      controller: _captureController,
                      focusNode: _captureFocusNode,
                      keyboardType:
                          widget.digitInputDecoration.keyboardType ==
                              OudsPinCodeInputKeyboardType.numeric
                          ? TextInputType.number
                          : TextInputType.text,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(digitsCount),
                        if (widget.digitInputDecoration.keyboardType ==
                            OudsPinCodeInputKeyboardType.numeric)
                          FilteringTextInputFormatter.digitsOnly,
                      ],
                      autocorrect: false,
                      enableSuggestions: false,
                      enableInteractiveSelection: false,
                      showCursor: false,
                      style: const TextStyle(color: Colors.transparent),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      buildCounter:
                          (
                            _, {
                            required currentLength,
                            required isFocused,
                            required maxLength,
                          }) => null,
                      onChanged: _onCaptureChanged,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Visible digit cells ───────────────────────────────────────
          Semantics(
            hint: hintSemanticText,
            label: isError
                ? l10n?.core_common_error_a11y
                : l10n?.core_pinCodeInput_pinCode_label_a11y(digitsCount),
            child: Row(
              mainAxisAlignment: widget.digitInputDecoration.constrainedMaxWidth
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              spacing: widget.length == OudsPinCodeInputLength.eight
                  ? 6
                  : pinCodeToken.spaceColumnGapDigitInput,
              children: List.generate(digitsCount, (index) {
                return Flexible(
                  fit: FlexFit.loose,
                  child: Semantics(
                    liveRegion: true,
                    label:
                        "${l10n?.core_pinCodeInput_digitCode_label_a11y(index + 1)}, "
                        "${!widget.digitInputDecoration.hiddenPassword && widget.controllers != null ? widget.controllers![index].text : ''}, "
                        "${l10n?.core_pinCodeInput_trait_a11y}",
                    child: OudsDigitInput(
                      index: index,
                      isError: isError,
                      length: widget.length,
                      digitInputDecoration: OudsDigitInputDecoration(
                        hintText: _hintText(index),
                        hiddenPassword:
                            widget.digitInputDecoration.hiddenPassword,
                        isOutlined: widget.digitInputDecoration.isOutlined,
                        keyboardType: widget.digitInputDecoration.keyboardType,
                      ),
                      isFocused: hasFocus && index == _activeIndex,
                      controller: widget.controllers?[index],
                      onTap: () => _captureFocusNode.requestFocus(),
                      onLongPress: _pasteFromClipboard,
                    ),
                  ),
                );
              }),
            ),
          ),

          // ── Helper / error text ───────────────────────────────────────
          if (widget.helperText != null ||
              (widget.errorText != null && isError)) ...[
            Container(
              constraints: BoxConstraints(
                maxWidth: widget.digitInputDecoration.constrainedMaxWidth
                    ? double.infinity
                    : digitsCount * pinCodeToken.sizeMaxWidth +
                          (digitsCount - 1) *
                              pinCodeToken.spaceColumnGapDigitInput,
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
                      widget.errorText != null && isError
                          ? widget.errorText!
                          : widget.helperText!,
                      style: theme.typographyTokens
                          .typeLabelDefaultMedium(context)
                          .copyWith(
                            color: OudsPinCodeInputTextColorModifier(
                              context,
                            ).getPinCodeHelperTextColor(isError),
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

  String? _hintText(int index) {
    final hint = widget.digitInputDecoration.hintText;
    if (hint == null) return null;
    final text = widget.controllers?[index].text ?? '';
    return text.isEmpty ? hint : null;
  }
}
