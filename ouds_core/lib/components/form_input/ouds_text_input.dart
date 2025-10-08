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

/// OudsTextField
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_background_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_border_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_foreground_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_text_modifier.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/utilities/input_utils.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Alias class for [OudsTextInput].
///
/// This class provides a shorter and more convenient name, [OudsTextField],
/// which internally extends [OudsTextInput]. It inherits all properties and behaviors,
/// allowing you to use [OudsTextField] as a drop-in replacement for [OudsTextInput].
class OudsTextField extends OudsTextInput {
  /// Creates an instance of [OudsTextField], which is an alias for [OudsTextInput].
  ///
  /// All parameters are forwarded to the superclass [OudsTextInput].
  ///
  /// [enabled] and [readOnly] default to null, allowing the superclass to handle defaults.
  OudsTextField({
    super.key,
    super.controller,
    super.focusNode,
    super.enabled = null,
    super.readOnly = null,
    super.keyboardType,
    required super.decoration,
  });
}

// TODO: Add documentation URL once it is available
///
/// `OudsTextInput` is a customizable text input field that allows users
/// to enter, edit, or read text.
///
/// This version supports fully configurable styling, including prefix
/// and suffix icons, error states, loading states, and helper or error messages.
///
/// Accessibility is supported: you can provide a **hint** for screen readers
/// to inform the user of possible actions, for example:
/// _"Placeholder"_.
///
/// Parameters:
/// - [controller]: The text controller linked to this input.
/// - [focusNode]: The focus node to manage focus state.
/// - [enabled]: Whether the input is enabled.
/// - [readOnly]: Whether the input is read-only.
/// - [keyboardType]: The type of keyboard to display.
/// - [onEditingComplete]: Callback invoked when editing is complete.
/// - [decoration]: An `OudsInputDecoration` object to configure label,
///
/// ## Simple example:
///
/// ```dart
/// OudsTextField(
///   controller: myController,
///   decoration: OudsInputDecoration(
///     labelText: 'label',
///     hintText: 'Placeholder', // Accessibility hint
///     prefixIcon: 'assets/ic_heart.svg',
///   ),
/// );
/// ```
class OudsTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onEditingComplete;
  final OudsInputDecoration decoration;

  OudsTextInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.onEditingComplete,
    required this.decoration,
  }) : assert(
          !(decoration.loader == true && decoration.errorText != null),
          "Error status for Loading state is not relevant",
        );

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsFormFieldsControlState controlTextInputState,
    bool isError,
  ) {
    final inputTextForegroundModifier = OudsFormFieldsForegroundColorModifier(context);
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
  State<OudsTextInput> createState() => _OudsTextInputState();
}

class _OudsTextInputState extends State<OudsTextInput> {
  final bool _isHovered = false;
  bool _isFocused = false;
  FocusNode? _internalFocusNode;

  @override
  void initState() {
    super.initState();
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
    final inputTextStateDeterminer = OudsFormFieldsControlStateDeterminer(
      enabled: widget.enabled ?? true,
      isFocused: effectiveIsFocused,
      isHovered: _isHovered,
      isLoading: widget.decoration.loader ?? false,
      isReadOnly: widget.readOnly ?? false,
    );

    // Get the computed state (enabled, focused, hovered, error, etc.)
    final state = inputTextStateDeterminer.determineControlState();

    // Modifiers for background color, text color, and border based on state
    final inputTextBackgroundModifier = OudsFormFieldsBackgroundColorModifier(context);
    final inputTextTextModifier = OudsFormFieldsTextColorModifier(context);
    final inputTextBorderModifier = OudsFormFieldsBorderModifier(context);

    // Theme tokens and reusable styles for text input
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    // Check if the input is currently showing an error
    final isError = widget.decoration.errorText != null;

    // Check if rounded borders are enabled in the theme config
    final isBorderRadius = OudsThemeConfigModel.of(context)?.textInput?.rounded;

    final l10n = OudsLocalizations.of(context);

    return MergeSemantics(
      child: Semantics(
        textField: true,
        label: l10n?.core_text_input_input_a11y,
        hint: widget.decoration.hintText,
        focused: effectiveFocusNode != null,
        focusable: true,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
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
                  color: inputTextBackgroundModifier.getBackgroundColor(state, isError, widget.decoration.outlined),

                  /// Bottom border styling; full border if style is not default
                  border: inputTextBorderModifier.getBorder(state, isError, widget.decoration.outlined),

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
                      end: (widget.decoration.suffixIcon != null || widget.decoration.errorText != null || widget.decoration.loader != null) ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
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
                              onTap: () {
                                // send text tapped to parent
                                widget.onEditingComplete?.call(widget.controller?.text ?? '');
                              },
                              onTapOutside: (outside) {
                                // send text tapped to parent
                                widget.onEditingComplete?.call(widget.controller?.text ?? '');
                              },
                              onEditingComplete: () {
                                // send text tapped to parent
                                widget.onEditingComplete?.call(widget.controller?.text ?? '');
                              },
                              onSubmitted: (value) {
                                // send text tapped to parent
                                widget.onEditingComplete?.call(value);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // Label text widget, shown if labelText is provided
                                label: widget.decoration.labelText != null
                                    ? Container(
                                        constraints: BoxConstraints(maxHeight: textInput.sizeLabelMaxHeight),
                                        child: Text(
                                          maxLines: InputUtils.getLabelMaxLines(hintText: widget.decoration.hintText, controller: widget.controller, isFocused: effectiveIsFocused),
                                          overflow: TextOverflow.ellipsis,
                                          widget.decoration.labelText ?? "",
                                          style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                                color: inputTextTextModifier.getTextColor(state, isError),
                                              ),
                                        ),
                                      )
                                    : null,

                                // Floating label behavior: always float if both labelText and hintText are provided
                                floatingLabelBehavior: (widget.decoration.labelText != null && widget.decoration.hintText != null) ? FloatingLabelBehavior.always : null,

                                // Hint text widget, shown if hintText is provided
                                hint: widget.decoration.hintText != null
                                    ? Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        widget.decoration.hintText!,
                                        style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                              color: inputTextTextModifier.getHintTextColor(state),
                                            ),
                                      )
                                    : null,

                                // Prefix widget displayed when prefix and labelText are both set
                                prefix: widget.decoration.prefix != null && widget.decoration.labelText != null
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            widget.decoration.prefix!,
                                            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                                  color: inputTextTextModifier.getSuffixPrefixTextColor(state),
                                                ),
                                          ),
                                          SizedBox(width: textInput.spaceColumnGapInlineText),
                                        ],
                                      )
                                    : null,

                                // Override default constraints to better fit OUDS design
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

                                // Suffix widget displayed when suffix and labelText are both set
                                suffix: widget.decoration.suffix != null && widget.decoration.labelText != null
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: textInput.spaceColumnGapInlineText),
                                          Text(
                                            widget.decoration.suffix!,
                                            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                                  color: inputTextTextModifier.getSuffixPrefixTextColor(state),
                                                ),
                                          ),
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
  Widget _buildHelperOrErrorText(BuildContext context, OudsFormFieldsControlState state, bool isError) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextTextModifier = OudsFormFieldsTextColorModifier(context);

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

  /// Builds the suffix widget for the text input field based on the current decoration state.
  ///
  /// This method determines what appears in the suffix position of the text input,
  /// depending on the combination of `loader`, `suffixIcon`, and `errorText` properties
  /// from [widget.decoration].
  ///
  /// Cases handled:
  ///
  /// 1. **Loader active** (`loader == true`):
  ///    - Displays a minimal hierarchy [OudsButton] in loading style.
  ///    - Uses `suffixIcon` if provided; otherwise, reserves space with an empty 24×24 box.
  ///
  /// 2. **Suffix icon provided** (`suffixIcon != null`):
  ///    - Displays the suffix icon inside a minimal hierarchy [OudsButton].
  ///    - If `errorText` is set, shows the error alert icon before the suffix button.
  ///
  /// 3. **Only error state** (`suffixIcon == null && errorText != null`):
  ///    - Shows the error alert icon inside a minimal hierarchy [OudsButton].
  ///
  /// 4. **No suffix** (none of the above conditions match):
  ///    - Returns `null`, meaning no widget will be displayed in the suffix position.
  ///
  /// The color of icons adapts based on the current [OudsTextInputControlState].
  ///
  /// Param [context] is used to retrieve theme tokens and style modifiers.
  /// Param [state] determines visual styles depending on focus, hover, and enabled states.
  Widget? _buildSuffixIcon(BuildContext context, OudsFormFieldsControlState state) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextForegroundModifier = OudsFormFieldsForegroundColorModifier(context);

    // Case 1: loader active
    if (widget.decoration.loader == true) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: textInput.spaceColumnGapDefault),
          OudsButton(
            icon: 'assets/ic_heart.svg',
            hierarchy: OudsButtonHierarchy.minimal,
            loader: Loader(progress: null),
            onPressed: () {},
          ),
        ],
      );
    }

    // Case 2: display suffixIcon + optional error icon
    if (widget.decoration.suffixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: textInput.spaceColumnGapDefault),
          if (widget.decoration.errorText != null) ...[
            SvgPicture.asset(
              AppAssets.icons.importantAlert,
              package: theme.packageName,
              width: theme.componentsTokens(context).button.sizeIconOnly,
              height: theme.componentsTokens(context).button.sizeIconOnly,
              colorFilter: ColorFilter.mode(
                inputTextForegroundModifier.getForegroundColor(state),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: textInput.spaceColumnGapTrailingErrorAction),
          ],
          OudsButton(
            hierarchy: OudsButtonHierarchy.minimal,
            icon: widget.decoration.suffixIcon,
            onPressed: ((widget.enabled ?? true) && !(widget.readOnly ?? false)) ? widget.decoration.onSuffixPressed : null,
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

  /// Builds the prefix widget for the text input field based on the current decoration state.
  ///
  /// This method determines what appears in the prefix position of the text input,
  /// from [widget.decoration].
  ///
  /// The color of icons adapts based on the current [OudsFormFieldsControlState].
  ///
  /// Param [context] is used to retrieve theme tokens and style modifiers.
  /// Param [state] determines visual styles depending on focus, hover, and enabled states.
  Widget? _buildPrefixIcon(BuildContext context, OudsFormFieldsControlState state) {
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
      ],
    );
  }
}
