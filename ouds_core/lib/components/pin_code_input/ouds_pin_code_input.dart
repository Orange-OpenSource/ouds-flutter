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
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ouds_core/components/pin_code_input/digit_input/ouds_digit_input.dart';
import 'package:ouds_core/components/pin_code_input/internal/modifier/ouds_pin_code_input_text_color_modifier.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Number of digit cells in an [OudsPinCodeInput]: [four], [six] or [eight].
enum OudsPinCodeInputLength {
  four,
  six,
  eight;

  /// Returns the actual number of digits for this variant.
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

/// Keyboard variant used by [OudsPinCodeInput].
///
/// - [numeric]: digits-only keyboard; non-digit input is stripped automatically.
/// - [alphanumeric]: standard keyboard; any character is accepted.
enum OudsPinCodeInputKeyboardType {
  numeric,
  alphanumeric;

  const OudsPinCodeInputKeyboardType();
}

/// [OUDS PIN Code Input Design Guidelines](https://r.orange.fr/r/S-ouds-doc-pin-code-input)
///
/// **Reference design version : 1.3.0**
///
/// A fixed-length PIN code input composed of individual digit cells, typically
/// used for authentication or confirmation flows.
///
/// ## Architecture
///
/// A single invisible [TextField] captures all keyboard input and holds the
/// full PIN string, keeping the soft keyboard open and stable across all cell
/// transitions. The visual cells ([OudsDigitInput]) are purely decorative.
///
/// ## Accessibility
///
/// When any platform accessibility feature is active (screen reader, bold text,
/// high contrast, reduced motion, …) the component switches to an
/// accessibility-friendly mode:
/// - **No automatic focus advance** — the user moves to the next cell manually.
/// - **Cell-by-cell deletion** — backspace clears only the selected cell.
/// - **Live regions disabled** — prevents the screen reader from jumping to
///   cells whose content changed after a keystroke.
///
/// ## Example
///
/// ```dart
/// OudsPinCodeInput(
///   length: OudsPinCodeInputLength.six,
///   helperText: 'Enter your 6-digit code',
///   digitInputDecoration: OudsDigitInputDecoration(
///     hintText: '-',
///     hiddenPassword: true,
///   ),
///   onChanged: (value) => print('Current PIN: $value'),
///   onEditingComplete: (value) => print('PIN complete: $value'),
/// )
/// ```
///
/// Parameters:
/// - [length]: Number of digit cells. Defaults to [OudsPinCodeInputLength.six].
/// - [helperText]: Supporting text shown below the input.
/// - [errorText]: Error message shown below the input; also sets the error state.
/// - [controllers]: Optional per-cell controllers for reading individual values.
/// - [onEditingComplete]: Called with the full PIN when all cells are filled.
/// - [onChanged]: Called with the current PIN on every keystroke.
/// - [digitInputDecoration]: Visual and keyboard configuration for the cells.
///
class OudsPinCodeInput extends StatefulWidget {
  final OudsPinCodeInputLength length;
  final String? helperText;
  final String? errorText;
  final List<TextEditingController>? controllers;
  final void Function(String)? onEditingComplete;
  final void Function(String)? onChanged;
  final OudsDigitInputDecoration digitInputDecoration;

  const OudsPinCodeInput({
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

class _OudsPinCodeInputState extends State<OudsPinCodeInput>
    with WidgetsBindingObserver {
  /// Holds the full PIN string typed by the user.
  /// A single controller is shared across all cells so the soft keyboard
  /// never resets between cell transitions.
  late final TextEditingController _hiddenController;

  /// Focus node attached to the hidden [TextField].
  late final FocusNode _hiddenFocusNode;

  /// Whether the hidden [TextField] currently has keyboard focus.
  bool _hasFocus = false;

  /// `true` once the user has typed at least one character.
  bool _hasEdited = false;

  // Flag to prevent re-entrant updates when syncing from external controllers.
  bool _updatingFromExternal = false;

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Pre-fill the hidden controller if individual controllers were provided.
    final initial = widget.controllers?.map((c) => c.text).join() ?? '';
    _hiddenController = TextEditingController(text: initial);
    _hiddenFocusNode = FocusNode();
    _hiddenFocusNode.addListener(_onFocusChange);
    _hiddenController.addListener(_onHiddenControllerChanged);
    // Listen to external controllers so this instance stays in sync when
    // another instance (e.g. the dark-mode box in LightDarkBox) updates them.
    _addExternalControllerListeners(widget.controllers);
  }

  @override
  void didUpdateWidget(OudsPinCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trim stored text if the number of cells decreases at runtime.
    if (oldWidget.length != widget.length) {
      final text = _hiddenController.text.characters
          .take(widget.length.digits)
          .toString();
      _hiddenController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    // Update external controller listeners when the list reference changes.
    if (oldWidget.controllers != widget.controllers) {
      _removeExternalControllerListeners(oldWidget.controllers);
      _addExternalControllerListeners(widget.controllers);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _hiddenFocusNode.removeListener(_onFocusChange);
    _hiddenController.removeListener(_onHiddenControllerChanged);
    _removeExternalControllerListeners(widget.controllers);
    _hiddenController.dispose();
    _hiddenFocusNode.dispose();
    super.dispose();
  }

  // ─── Focus ───────────────────────────────────────────────────────────────

  void _onFocusChange() {
    if (!mounted) return;
    setState(() => _hasFocus = _hiddenFocusNode.hasFocus);
  }

  // ─── External controller sync ─────────────────────────────────────────────

  void _addExternalControllerListeners(List<TextEditingController>? list) {
    list?.forEach((c) => c.addListener(_onExternalControllerChanged));
  }

  void _removeExternalControllerListeners(List<TextEditingController>? list) {
    list?.forEach((c) => c.removeListener(_onExternalControllerChanged));
  }

  /// Called when an external per-cell controller changes from outside
  /// (e.g. a sibling instance updating shared controllers in LightDarkBox).
  /// Rebuilds the internal hidden controller to stay in sync.
  void _onExternalControllerChanged() {
    if (!mounted || _updatingFromExternal) return;
    final newText = widget.controllers?.map((c) => c.text).join() ?? '';
    if (newText != _hiddenController.text) {
      _updatingFromExternal = true;
      _hiddenController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
      _updatingFromExternal = false;
    }
  }

  // ─── Input handling ──────────────────────────────────────────────────────

  /// Central listener called on every change to [_hiddenController].
  ///
  /// 1. **Sanitise** — strip non-digits (numeric mode) and truncate to max length.
  /// 2. **Accessibility deletion** — redirect native backspace to remove only
  ///    the character at [_voiceOverActiveIndex] instead of the last char.
  /// 3. **Accessibility overflow guard** — cap input to the active cell so a
  ///    typed character cannot silently fill the next cell.
  /// 4. **Sync individual controllers** — keep per-cell controllers up to date.
  /// 5. **Completion** — unfocus and fire [widget.onEditingComplete] when all
  ///    cells are filled (skipped in accessibility mode).
  void _onHiddenControllerChanged() {
    if (!mounted) return;

    final raw = _hiddenController.text;
    final totalDigits = widget.length.digits;

    // Step 1 — Sanitise input.
    final sanitized =
        widget.digitInputDecoration.keyboardType ==
            OudsPinCodeInputKeyboardType.numeric
        ? raw.replaceAll(RegExp(r'\D'), '')
        : raw;
    final trimmed = sanitized.characters.take(totalDigits).toString();

    // If sanitisation changed the text, rewrite the controller and let the
    // listener fire again with the clean value.
    if (raw != trimmed) {
      _hiddenController.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
      return;
    }

    // Step 4 — Sync per-cell controllers.
    final controllers = widget.controllers;
    if (controllers != null) {
      for (int i = 0; i < totalDigits; i++) {
        final char = i < trimmed.length ? trimmed[i] : '';
        if (controllers[i].text != char) {
          controllers[i].value = TextEditingValue(
            text: char,
            selection: TextSelection.collapsed(offset: char.length),
          );
        }
      }
    }

    if (!_hasEdited && trimmed.isNotEmpty) _hasEdited = true;

    setState(() {});
    widget.onChanged?.call(trimmed);

    //when focus moves to the next field, the new focused input shall be vocalized to inform the user
    if (_hiddenFocusNode.hasFocus && trimmed.length < totalDigits) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;

        final nextIndex = _activeIndex + 1;

        SemanticsService.announce(
          OudsLocalizations.of(
                context,
              )?.core_pinCodeInput_digitPosition_a11y(nextIndex, totalDigits) ??
              '',
          Directionality.of(context),
        );
      });
    }
    // Step 5 — Completion.
    // In normal mode, unfocus when the last cell is filled so the keyboard
    // dismisses automatically. In accessibility mode we intentionally keep
    // focus so the assistive technology can continue reading the filled cells.
    if (trimmed.length == totalDigits) {
      _hiddenFocusNode.unfocus();
      widget.onEditingComplete?.call(trimmed);
    }
  }

  // ─── Paste ───────────────────────────────────────────────────────────────

  /// Reads text from the clipboard and populates all cells at once.
  /// Triggered by a long-press on the cell row.
  Future<void> _pasteFromClipboard() async {
    try {
      final data = await Clipboard.getData(
        Clipboard.kTextPlain,
      ).timeout(const Duration(seconds: 2), onTimeout: () => null);
      if (!mounted) return;
      final text = data?.text;
      if (text == null || text.isEmpty) return;

      final totalDigits = widget.length.digits;
      final sanitized =
          widget.digitInputDecoration.keyboardType ==
              OudsPinCodeInputKeyboardType.numeric
          ? text.replaceAll(RegExp(r'\D'), '')
          : text;
      final trimmed = sanitized.characters.take(totalDigits).toString();

      _hiddenController.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
      _hiddenFocusNode.requestFocus();
    } catch (_) {}
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  /// Index of the cell that shows the focused border and blinking cursor.
  ///
  int get _activeIndex {
    final len = _hiddenController.text.length;
    return len.clamp(0, widget.length.digits - 1);
  }

  /// Returns the hint placeholder for [index], or `null` if the cell is
  /// filled or currently active.
  String? _hintText(int index) {
    final hint = widget.digitInputDecoration.hintText;
    if (hint == null) return null;
    final char = index < _hiddenController.text.length
        ? _hiddenController.text[index]
        : '';
    if (char.isNotEmpty) return null;
    if (_hasFocus && index == _activeIndex) return null;
    return hint;
  }

  /// Returns a localized accessibility label for a PIN input position.
  ///
  /// Converts the zero-based [index] into a human-readable ordinal position
  /// (for example: "1st", "2nd", "3rd" in English or "1er", "2ème" in French)
  /// according to the current locale.
  ///
  /// This label is used by screen readers to announce each PIN cell position
  /// more clearly and avoid confusion between the field position and its value.
  String getDigitPositionLabel(BuildContext context, int index) {
    final l10n = OudsLocalizations.of(context)!;
    final position = index + 1;

    String ordinal;

    switch (Localizations.localeOf(context).languageCode) {
      case 'fr':
        ordinal = position == 1 ? '${position}er' : '${position}ème';
        break;

      case 'en':
        if (position % 10 == 1 && position != 11) {
          ordinal = '${position}st';
        } else if (position % 10 == 2 && position != 12) {
          ordinal = '${position}nd';
        } else if (position % 10 == 3 && position != 13) {
          ordinal = '${position}rd';
        } else {
          ordinal = '${position}th';
        }
        break;

      default:
        ordinal = '$position';
    }

    return l10n.core_pinCodeInput_digitCode_label_a11y(ordinal);
  }

  // ─── Build ───────────────────────────────────────────────────────────────

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
    final hintSemanticText = widget.errorText != null && isError
        ? widget.errorText!
        : widget.helperText != null
        ? widget.helperText!
        : '';
    final currentText = _hiddenController.text;

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
          // ── Hidden TextField ─────────────────────────────────────────────
          // A single invisible input widget (opacity 0, height 1) that holds
          // the entire PIN string. Keeping a single focused TextField alive
          // for the whole input session prevents the soft keyboard from
          // closing and reopening between cells.
          ExcludeSemantics(
            child: Opacity(
              opacity: 0.0,
              child: SizedBox(
                height: 1,
                child: TextField(
                  controller: _hiddenController,
                  focusNode: _hiddenFocusNode,
                  showCursor: false,
                  enableInteractiveSelection: false,
                  keyboardType:
                      widget.digitInputDecoration.keyboardType ==
                          OudsPinCodeInputKeyboardType.numeric
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.length.digits),
                    if (widget.digitInputDecoration.keyboardType ==
                        OudsPinCodeInputKeyboardType.numeric)
                      FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration.collapsed(hintText: null),
                ),
              ),
            ),
          ),

          // ── Visual cell row ──────────────────────────────────────────────
          // A GestureDetector wraps the entire row so a tap anywhere opens the
          // keyboard. Long-press triggers clipboard paste.
          GestureDetector(
            onTap: () => _hiddenFocusNode.requestFocus(),
            onLongPress: _pasteFromClipboard,
            child: Semantics(
              hint: hintSemanticText,
              label: isError
                  ? l10n?.core_common_error_a11y
                  : l10n?.core_pinCodeInput_pinCode_label_a11y(digitsCount),
              child: Row(
                mainAxisAlignment:
                    widget.digitInputDecoration.constrainedMaxWidth
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                spacing: widget.length == OudsPinCodeInputLength.eight
                    ? 6
                    : pinCodeToken.spaceColumnGapDigitInput,
                children: List.generate(digitsCount, (index) {
                  final char = index < currentText.length
                      ? currentText[index]
                      : '';
                  // True when this cell should show the active border/cursor.
                  final isActive = _hasFocus && index == _activeIndex;
                  return Flexible(
                    fit: FlexFit.loose,
                    child: Semantics(
                      // Disable live regions in accessibility mode to prevent
                      // the screen reader from jumping to cells whose content
                      // changed after a keystroke.
                      liveRegion: true,
                      hint: l10n?.core_common_hint_a11y,
                      label:
                          "${getDigitPositionLabel(context, index)}, "
                          "${!widget.digitInputDecoration.hiddenPassword && widget.controllers != null ? widget.controllers![index].text : ''}, "
                          "${l10n?.core_pinCodeInput_trait_a11y}",
                      child: OudsDigitInput(
                        index: index,
                        isError: isError,
                        isFocused: isActive,
                        displayValue: char,
                        digitInputDecoration: OudsDigitInputDecoration(
                          hintText: _hintText(index),
                          hiddenPassword:
                              widget.digitInputDecoration.hiddenPassword,
                          isOutlined: widget.digitInputDecoration.isOutlined,
                          keyboardType:
                              widget.digitInputDecoration.keyboardType,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // ── Helper / error text ──────────────────────────────────────────
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
}
