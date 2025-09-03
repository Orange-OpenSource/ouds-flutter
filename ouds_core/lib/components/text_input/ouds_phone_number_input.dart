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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_foreground_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

extension OudsInputDecorationCopyWith on OudsInputDecoration {
  OudsInputDecoration copyWith({
    String? prefix,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    String? prefixIcon,
    String? suffixIcon,
    OudsTextInputStyle? style,
    bool? loader,
  }) {
    return OudsInputDecoration(
      prefix: prefix ?? this.prefix,
      labelText: labelText ?? this.labelText,
      hintText: hintText ?? this.hintText,
      helperText: helperText ?? this.helperText,
      errorText: errorText ?? this.errorText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      style: style ?? this.style,
      loader: loader ?? this.loader,
    );
  }
}

class OudsPhoneNumberInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final bool? countrySelector;
  OudsInputDecoration decoration;

  OudsPhoneNumberInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.countrySelector,
    required this.decoration,
  }) : assert(
          !(decoration.loader == true && decoration.errorText != null),
          "Error status for Loading state is not relevant",
        );

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsTextInputControlState controlTextInputState,
    bool isError,
  ) {
    final inputTextForegroundModifier = OudsTextInputForegroundColorModifier(context);
    final theme = OudsTheme.of(context);
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      width: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      colorFilter: ColorFilter.mode(
        inputTextForegroundModifier.getIconColor(controlTextInputState),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsPhoneNumberInput> createState() => _OudsPhoneNumberInputState();
}

class _OudsPhoneNumberInputState extends State<OudsPhoneNumberInput> {
  final bool _isHovered = false;
  bool _isFocused = false;
  FocusNode? _internalFocusNode;
  late String _prefix;

  @override
  void initState() {
    super.initState();
    // Init prefix en fonction du countrySelector
    if (widget.countrySelector == true) {
      _prefix = widget.decoration.prefix ?? "";
    } else {
      _prefix = "";
    }
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
      _internalFocusNode!.addListener(_handleFocusChange);
    } else {
      widget.focusNode!.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = (widget.focusNode ?? _internalFocusNode)!.hasFocus;
    });
  }

  @override
  void dispose() {
    if (_internalFocusNode != null) {
      _internalFocusNode!.removeListener(_handleFocusChange);
      _internalFocusNode!.dispose();
    } else {
      widget.focusNode?.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine which FocusNode to use: the external one provided via widget.focusNode,
    // or the internal one (_internalFocusNode) created internally if no external node is given.
    final effectiveFocusNode = widget.focusNode ?? _internalFocusNode;

    // Update the local _isFocused state by checking if the currently effective FocusNode has focus.
    _isFocused = (widget.focusNode ?? _internalFocusNode)!.hasFocus;

    // If the input is read-only, override focus state to false to prevent showing focused styles.
    // Otherwise, use the actual focus state.
    final bool effectiveIsFocused = widget.readOnly ?? false ? false : _isFocused;

    // Determine the current control state (enabled, focused, hovered, loading)
    final inputTextStateDeterminer = OudsTextInputControlStateDeterminer(
      enabled: widget.enabled ?? true,
      isFocused: effectiveIsFocused,
      isHovered: _isHovered,
      isLoading: widget.decoration.loader ?? false,
      isReadOnly: widget.readOnly ?? false,
    );

    // Get the computed state (enabled, focused, hovered, error, etc.)
    final state = inputTextStateDeterminer.determineControlState();

    // Modifiers for background color, text color, and border based on state
    final inputTextBackgroundModifier = OudsTextInputBackgroundColorModifier(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);
    final inputTextBorderModifier = OudsTextInputBorderModifier(context);

    // Theme tokens and reusable styles for text input
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    // Check if the input is currently showing an error
    final isError = widget.decoration.errorText != null;

    // Check if rounded borders are enabled in the theme config
    final isBorderRadius = OudsThemeConfigModel.of(context)?.textInput?.rounded;

    //final l10n = OudsLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              minWidth: textInput.sizeMinWidth,
              maxWidth: textInput.sizeMaxWidth,
              minHeight: textInput.sizeMinHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    // Background color based on current state and error presence
                    color: inputTextBackgroundModifier.getBackgroundColor(state, isError, widget.decoration.style),

                    /// Bottom border styling; full border if style is not default
                    border: inputTextBorderModifier.getBorder(state, isError, widget.decoration.style),
                    // Border radius if enabled in theme configuration
                    borderRadius: inputTextBorderModifier.getBorderRadius(context, isBorderRadius),
                  ),
                  child: ConstrainedBox(
                    // Minimum height constraint for the input container
                    constraints: BoxConstraints(minHeight: textInput.sizeMinHeight),

                    /// Padding inside the text input container
                    child: Padding(
                      padding: EdgeInsetsGeometry.directional(
                        start: textInput.spacePaddingInlineDefault,
                        end: textInput.spacePaddingInlineTrailingAction,
                        top: textInput.spacePaddingBlockDefault,
                        bottom: textInput.spacePaddingBlockDefault,
                      ),
                      child: Row(
                        children: [
                          /// Left block: prefix icon container
                          Container(
                            alignment: Alignment.center,
                            child: _buildPrefixIcon(context, state),
                          ),

                          /// Center block: main text input
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              child: TextField(
                                cursorColor: inputTextTextModifier.getCursorTextColor(state, isError),
                                focusNode: effectiveFocusNode,
                                controller: widget.controller,
                                keyboardType: widget.keyboardType,
                                style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                      color: inputTextTextModifier.getTextColor(state, isError),
                                    ),
                                enabled: widget.enabled,
                                readOnly: widget.readOnly ?? false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,

                                  // Label text widget, shown if labelText is provided
                                  label: widget.decoration.labelText != null
                                      ? Text(
                                          widget.decoration.labelText ?? "",
                                          style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                                color: inputTextTextModifier.getTextColor(state, isError),
                                              ),
                                        )
                                      : null,

                                  // Floating label behavior: always float if both labelText and hintText are provided
                                  floatingLabelBehavior: (widget.decoration.labelText != null && widget.decoration.hintText != null) ? FloatingLabelBehavior.always : null,

                                  // Hint text widget, shown if hintText is provided
                                  hint: widget.decoration.hintText != null
                                      ? Text(
                                          widget.decoration.hintText!,
                                          style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                                color: inputTextTextModifier.getHintTextColor(state),
                                              ),
                                        )
                                      : null,

                                  // Hint text widget, shown if hintText is provided
                                  prefix: widget.decoration.prefix != null || _prefix.isNotEmpty
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _buildPrefixText(context, state),
                                            SizedBox(width: textInput.spaceColumnGapInlineText),
                                          ],
                                        )
                                      : null,

                                  isDense: true,
                                ),
                              ),
                            ),
                          ),

                          /// Right block: suffix icon container
                          Container(
                            alignment: Alignment.center,
                            child: _buildSuffixIcon(context, state),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Display helper text or error text if available
                if (widget.decoration.helperText != null || widget.decoration.errorText != null) ...[
                  _buildHelperOrErrorText(context, state, isError == true),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrefixText(BuildContext context, OudsTextInputControlState state) {
    final theme = OudsTheme.of(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);

    final String? prefixToDisplay = widget.countrySelector == true ? _prefix : widget.decoration.prefix;

    if (prefixToDisplay == null || prefixToDisplay.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      prefixToDisplay,
      style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
            color: inputTextTextModifier.getSuffixPrefixTextColor(state),
          ),
    );
  }

  /// Returns a Text widget displaying either the error text or the helper text.
  ///
  /// - Shows `widget.errorText` if [isError] is true.
  /// - Otherwise, shows `widget.helperText`.
  /// - Returns an empty widget if neither text is provided.
  ///
  /// Applies the appropriate style and color based on the input state.
  ///
  /// Param [context]: The BuildContext.
  /// Param [state]: The current control state of the text input (focused, hovered, etc.).
  /// Param [isError]: A boolean indicating whether the input is in an error state.
  Widget _buildHelperOrErrorText(BuildContext context, OudsTextInputControlState state, bool isError) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);

    // Select the text to display: prioritize error text over helper text
    final String? text = isError ? widget.decoration.errorText : widget.decoration.helperText;

    // Return an empty widget if no text is provided
    if (text == null) return SizedBox.shrink();

    // Return the Text widget with proper color and padding
    return Padding(
      padding: EdgeInsets.only(
        top: textInput.spacePaddingBlockTopHelperText,
        left: textInput.spacePaddingInlineDefault,
        right: textInput.spacePaddingInlineDefault,
      ),
      child: Text(
        text,
        style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
              color: inputTextTextModifier.getHelperTextColor(state, isError),
            ),
      ),
    );
  }

  /// build leading icon
  Widget? _buildPrefixIcon(BuildContext context, OudsTextInputControlState state) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.decoration.prefixIcon != null) ...[
          OudsTextInput.buildIcon(
            context,
            widget.decoration.prefixIcon!,
            state,
            false,
          ),
          SizedBox(width: textInput.spaceColumnGapDefault),
        ],
        if (widget.countrySelector == true) ...[
          CountrySelector(
            onCountryChanged: (country) {
              print("prefix phone: ${country.prefix}");
              setState(() {
                _prefix = country.prefix;
                // widget.decoration = widget.decoration.copyWith(prefix: country.prefix);
              });
              print("prefix phon after: ${country.prefix}");
            },
          ),
          SizedBox(width: textInput.spaceColumnGapDefault),
        ],
      ],
    );
  }

  Widget? _buildSuffixIcon(BuildContext context, OudsTextInputControlState state) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextForegroundModifier = OudsTextInputForegroundColorModifier(context);

    // Case 1: loader active
    if (widget.decoration.loader == true) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: textInput.spaceColumnGapDefault),
          OudsButton(
            hierarchy: OudsButtonHierarchy.minimal,
            loader: Loader(progress: null),
            onPressed: () {},
          ),
        ],
      );
    }

    // Case 3: only error present
    if (widget.decoration.errorText != null) {
      return Container(
        constraints: BoxConstraints(
          minWidth: theme.componentsTokens(context).button.sizeMinWidth,
          minHeight: theme.componentsTokens(context).button.sizeMinHeight,
        ),
        padding: EdgeInsets.all(
          theme.componentsTokens(context).button.spaceInsetIconOnly,
        ),
        child: SvgPicture.asset(
          AppAssets.icons.importantAlert,
          package: theme.packageName,
          width: theme.componentsTokens(context).button.sizeIconOnly,
          height: theme.componentsTokens(context).button.sizeIconOnly,
          colorFilter: ColorFilter.mode(
            inputTextForegroundModifier.getForegroundColor(state),
            BlendMode.srcIn,
          ),
        ),
      );
    }

    // Default: no suffix
    return null;
  }
}
