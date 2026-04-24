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

/// {@category Text input}
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
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/utilities/input_utils.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_textInput_tokens.dart';

/// [OUDS Text Input Design Guidelines](https://r.orange.fr/r/S-ouds-doc-text-input)
///
/// **Reference design version : 1.3.0**
///
/// Text input is a UI element that allows to enter, edit, or select single-line textual data. Text input is one of the most fundamental form elements used
/// to capture user input such as names, emails, passwords, or search queries. It provides a visual and interactive affordance for text entry
/// while supporting labels, placeholders, icons, descriptions, and validation feedback.
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
/// - [decoration]: An [OudsInputDecoration] object to configure label,
/// - [helperLink]: An [OudsLink] object to display a helper link.
/// - [trailingIconContentDescription]: A semantic label for accessibility trailing icon.
///
/// ### You can use [OudsTextField] component in your project, customizing parameters as needed :
///
/// ```dart
/// OudsTextField(
///   controller: myController,
///   decoration: OudsInputDecoration(
///     labelText: 'label',
///     hintText: 'Placeholder', // Accessibility hint
///     prefixIcon: 'assets/ic_heart.svg',
///     helperLink: OudsLink(
///                   label: "Helper link",
///                   onPressed: () {},
///               ),
///   ),
/// );
/// ```
class OudsTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onEditingComplete;
  final OudsInputDecoration decoration;
  final OudsLink? helperLink;
  final String? trailingIconContentDescription;

  OudsTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.onEditingComplete,
    required this.decoration,
    this.helperLink,
    this.trailingIconContentDescription,
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
    final inputTextForegroundModifier = OudsFormFieldsForegroundColorModifier(
      context,
    );
    final theme = OudsTheme.of(context);
    return SvgPicture.asset(
      excludeFromSemantics: true,
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
  State<OudsTextField> createState() => _OudsTextInputState();
}

class _OudsTextInputState extends State<OudsTextField> {
  final bool _isHovered = false;
  bool _isFocused = false;
  FocusNode? _internalFocusNode;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    // Listen to the external controller if provided
    // This allows us to detect text changes in real time.
    if (widget.controller != null) {
      widget.controller!.addListener(_handleTextChanged);
    }

    // Manage focus state: create an internal FocusNode if none is provided
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
      _internalFocusNode!.addListener(_handleFocusChange);
    } else {
      widget.focusNode!.addListener(_handleFocusChange);
    }
  }

  void _handleTextChanged() {
    // Get the current text from the controller
    final text = widget.controller?.text ?? '';

    // Trigger a rebuild only when the "typing" state actually changes
    // (prevents unnecessary rebuilds on every keystroke)
    final typing = text.isNotEmpty;
    if (typing != _isTyping) {
      setState(() {
        _isTyping = typing;
      });
    }
  }

  @override
  void didUpdateWidget(covariant OudsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTextChanged);
      widget.controller?.addListener(_handleTextChanged);
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = (widget.focusNode ?? _internalFocusNode)!.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextChanged);

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
    final bool effectiveIsFocused = widget.readOnly ?? false
        ? false
        : _isFocused;

    // Determine the current control state (enabled, focused, hovered, loading)
    final inputTextStateDeterminer = OudsFormFieldsControlStateDeterminer(
      enabled: widget.enabled ?? true,
      isFocused: effectiveIsFocused,
      isHovered: _isHovered,
      isLoading: (widget.decoration.loader == true && _isTyping) ? true : false,
      isReadOnly: widget.readOnly ?? false,
    );

    // Get the computed state (enabled, focused, hovered, error, etc.)
    final state = inputTextStateDeterminer.determineControlState();

    // Modifiers for background color, text color, and border based on state
    final inputTextBackgroundModifier = OudsFormFieldsBackgroundColorModifier(
      context,
    );
    final inputTextTextModifier = OudsFormFieldsTextColorModifier(context);
    final inputTextBorderModifier = OudsFormFieldsBorderModifier(context);

    // Theme tokens and reusable styles for text input
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    // Check if the input is currently showing an error
    final isError = widget.decoration.errorText != null;

    final l10n = OudsLocalizations.of(context);

    //needed for accessibility
    final contentText = widget.controller?.text ?? "";
    final prefixText = contentText.isNotEmpty
        ? ", ${widget.decoration.prefix ?? ""}"
        : "";
    final suffixText = contentText.isNotEmpty
        ? ", ${widget.decoration.suffix ?? ""}"
        : "";
    final helperText = isError
        ? widget.decoration.errorText ?? ""
        : widget.decoration.helperText ?? "";

    // Determine disabled/readOnly label
    final isEnabled = widget.enabled ?? true;
    final isReadOnly = widget.readOnly ?? false;
    final statusLabel = !isEnabled
        ? l10n?.core_common_disabled_a11y ?? ""
        : isReadOnly
        ? l10n?.core_common_disabled_a11y ?? ""
        : "";
    final hintLabel = contentText.isEmpty
        ? widget.decoration.hintText ?? ""
        : "";

    // Build Semantics value
    final semanticsValue = [
      l10n?.core_textInput_trait_a11y,
      widget.decoration.labelText,
      prefixText,
      contentText,
      suffixText,
      helperText,
      statusLabel,
      hintLabel,
    ].where((s) => s != null && s.isNotEmpty).join(", ");

    return Semantics(
      label: semanticsValue,
      hint: l10n?.core_common_hint_a11y,
      value: isError ? l10n?.core_common_error_a11y : null,
      focused: effectiveFocusNode != null,
      focusable: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: textInput.sizeMinWidth,
          maxWidth: widget.decoration.constrainedMaxWidth
              ? textInput.sizeMaxWidth
              : double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: textInput.sizeMinHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // Background color based on current state and error presence
                  color: inputTextBackgroundModifier.getBackgroundColor(
                    state,
                    isError,
                    widget.decoration.outlined,
                  ),

                  /// Bottom border styling; full border if style is not default
                  border: inputTextBorderModifier.getBorder(
                    state,
                    isError,
                    widget.decoration.outlined,
                  ),

                  // Border radius if enabled in theme configuration
                  borderRadius: inputTextBorderModifier.getBorderRadius(
                    context,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: textInput.spacePaddingInlineDefault,
                    end:
                        (widget.decoration.suffixIcon != null ||
                            widget.decoration.errorText != null ||
                            widget.decoration.loader != null)
                        ? textInput.spacePaddingInlineTrailingAction
                        : textInput.spacePaddingInlineDefault,
                    top: textInput.spacePaddingBlockDefault,
                    bottom: textInput.spacePaddingBlockDefault,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Left block: prefix icon container
                      ExcludeSemantics(child: _buildPrefixIcon(context, state)),

                      /// Center-left: prefix text displayed even without label
                      /// Set a flexible to prevent text overflow
                      if (widget.decoration.prefix != null &&
                          widget.decoration.labelText == null &&
                          (widget.decoration.hintText != null ||
                              _isTyping)) ...[
                        /// Wrap the prefix Text in Flexible to limit its width and prevent overflow errors
                        Flexible(
                          flex: 1, // Allocates 1 part of the available space
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: textInput.spaceColumnGapInlineText,
                            ),
                            child: Text(
                              widget.decoration.prefix!,
                              style: theme.typographyTokens
                                  .typeLabelDefaultLarge(context)
                                  .copyWith(
                                    color: inputTextTextModifier
                                        .getSuffixPrefixTextColor(state),
                                  ),
                            ),
                          ),
                        ),
                      ],

                      /// Center block: main text input
                      /// Wrap the TextField in Flexible to control its width
                      Flexible(
                        fit: FlexFit.loose,
                        child: ExcludeSemantics(
                          child:
                              widget.readOnly == true ||
                                  (widget.decoration.loader == true &&
                                      _isTyping)
                              ? IgnorePointer(
                                  child: _buildTextField(
                                    inputTextTextModifier,
                                    state,
                                    isError,
                                    effectiveFocusNode,
                                    theme,
                                    context,
                                    textInput,
                                    effectiveIsFocused,
                                  ),
                                )
                              : _buildTextField(
                                  inputTextTextModifier,
                                  state,
                                  isError,
                                  effectiveFocusNode,
                                  theme,
                                  context,
                                  textInput,
                                  effectiveIsFocused,
                                ),
                        ),
                      ),

                      /// Center-left: prefix text displayed even without label
                      /// Set a flexible to prevent text overflow
                      if (widget.decoration.suffix != null &&
                          widget.decoration.labelText == null &&
                          (widget.decoration.hintText != null ||
                              _isTyping)) ...[
                        /// Wrap the suffix Text in Flexible to limit its width and prevent overflow errors
                        Flexible(
                          flex: 1, // Allocates 1 part of the available space
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: textInput.spaceColumnGapDefault,
                            ),
                            child: Text(
                              widget.decoration.suffix!,
                              style: theme.typographyTokens
                                  .typeLabelDefaultLarge(context)
                                  .copyWith(
                                    color: inputTextTextModifier
                                        .getSuffixPrefixTextColor(state),
                                  ),
                            ),
                          ),
                        ),
                      ],

                      /// Right block: suffix icon container
                      Semantics(
                        label:
                            widget.decoration.suffixIcon != null &&
                                widget.decoration.loader == false
                            ? widget.trailingIconContentDescription
                            : null,
                        container: true,
                        button: true,
                        child: _buildSuffixIcon(context, state),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Display helper text or error text if available
            if (widget.decoration.helperText != null ||
                widget.decoration.errorText != null) ...[
              ExcludeSemantics(
                child: _buildHelperOrErrorText(context, state, isError == true),
              ),
            ],

            /// Display helper link if available
            if (widget.helperLink != null &&
                widget.helperLink!.label.isNotEmpty) ...[
              _buildHelperLink(context),
            ],
          ],
        ),
      ),
    );
  }

  /// Function `_buildTextField`
  ///
  /// This function creates and configures a customized `TextField` widget for user input.
  /// It manages styling, input behavior, and interaction events based on the current state,
  /// theme, and provided parameters. It also handles optional labels, hints, prefixes, and suffixes,
  /// ensuring a consistent and styled input experience.
  ///
  /// Parameters:
  /// - `inputTextTextModifier`: Modifier for text and cursor colors depending on state and error status.
  /// - `state`: Current control state (e.g., normal, focused, disabled).
  /// - `isError`: Indicates if the input is in an error state.
  /// - `effectiveFocusNode`: Focus node associated with the text field.
  /// - `theme`: Theme object providing styling tokens.
  /// - `context`: Build context for styling and layout.
  /// - `textInput`: Tokens for text input styling and spacing.
  /// - `effectiveIsFocused`: Whether the text field is currently focused.
  ///
  /// Behavior:
  /// - Sets cursor color based on the modifier and current state.
  /// - Applies input formatters and enables/disables editing based on widget properties.
  /// - Handles tap, outside tap, editing complete, and submit events to notify parent.
  /// - Configures input decoration with optional label, hint, prefix, and suffix, styled accordingly.
  /// - Displays label text if provided, with height constraints and style.
  /// - Shows hint text if provided, styled according to theme.
  /// - Adds prefix and suffix widgets when specified, with proper styling and spacing.
  /// - Uses dense layout for compact appearance.
  TextField _buildTextField(
    OudsFormFieldsTextColorModifier inputTextTextModifier,
    OudsFormFieldsControlState state,
    bool isError,
    FocusNode? effectiveFocusNode,
    OudsThemeContract theme,
    BuildContext context,
    OudsTextInputTokens textInput,
    bool effectiveIsFocused,
  ) {
    return TextField(
      cursorColor: inputTextTextModifier.getCursorTextColor(state, isError),
      focusNode: effectiveFocusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: theme.typographyTokens
          .typeLabelDefaultLarge(context)
          .copyWith(color: inputTextTextModifier.getTextColor(state, isError)),
      enabled: widget.enabled,
      readOnly: widget.readOnly ?? false,
      onChanged: (value) {
        if (widget.controller != null) {
          widget.controller!.text = value;
        }
        _handleTextChanged();
        widget.onEditingComplete?.call(value);
      },
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
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: textInput.sizeLabelMaxHeight,
                ),
                child: Text(
                  maxLines: InputUtils.getLabelMaxLines(
                    hintText: widget.decoration.hintText,
                    controller: widget.controller,
                    isFocused: effectiveIsFocused,
                  ),
                  overflow: TextOverflow.ellipsis,
                  widget.decoration.labelText ?? "",
                  style: theme.typographyTokens
                      .typeLabelDefaultLarge(context)
                      .copyWith(
                        color: inputTextTextModifier.getTextColor(
                          state,
                          isError,
                        ),
                      ),
                ),
              )
            : null,

        // Floating label behavior: always float if both labelText and hintText are provided
        floatingLabelBehavior:
            (widget.decoration.labelText != null &&
                widget.decoration.hintText != null)
            ? FloatingLabelBehavior.always
            : null,

        // Hint text widget, shown if hintText is provided
        hint: widget.decoration.hintText != null
            ? Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                widget.decoration.hintText!,
                style: theme.typographyTokens
                    .typeLabelDefaultLarge(context)
                    .copyWith(
                      color: inputTextTextModifier.getHintTextColor(state),
                    ),
              )
            : null,

        // Prefix widget displayed when prefix and labelText are both set
        // Set a maximum width to prevent text overflow
        prefix:
            widget.decoration.prefix != null &&
                widget.decoration.labelText != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.decoration.prefix!,
                      style: theme.typographyTokens
                          .typeLabelDefaultLarge(context)
                          .copyWith(
                            color: inputTextTextModifier
                                .getSuffixPrefixTextColor(state),
                          ),
                    ),
                  ),
                  SizedBox(width: textInput.spaceColumnGapInlineText),
                ],
              )
            : null,

        // Override default constraints to better fit OUDS design
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        // Suffix widget displayed when suffix and labelText are both set
        // Set a maximum width to prevent text overflow
        suffix:
            widget.decoration.suffix != null &&
                widget.decoration.labelText != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: textInput.spaceColumnGapInlineText),
                  Flexible(
                    child: Text(
                      widget.decoration.suffix!,
                      style: theme.typographyTokens
                          .typeLabelDefaultLarge(context)
                          .copyWith(
                            color: inputTextTextModifier
                                .getSuffixPrefixTextColor(state),
                          ),
                    ),
                  ),
                ],
              )
            : null,
        isDense: true,
        contentPadding: EdgeInsets.zero,
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
  Widget _buildHelperOrErrorText(
    BuildContext context,
    OudsFormFieldsControlState state,
    bool isError,
  ) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextTextModifier = OudsFormFieldsTextColorModifier(context);

    // Select the text to display: prioritize error text over helper text
    final String? text = isError
        ? widget.decoration.errorText
        : widget.decoration.helperText;

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
        style: theme.typographyTokens
            .typeLabelDefaultMedium(context)
            .copyWith(
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
  ///    - If `errorText` is set, shows the error alert_message icon before the suffix button.
  ///
  /// 3. **Only error state** (`suffixIcon == null && errorText != null`):
  ///    - Shows the error alert_message icon inside a minimal hierarchy [OudsButton].
  ///
  /// 4. **No suffix** (none of the above conditions match):
  ///    - Returns `null`, meaning no widget will be displayed in the suffix position.
  ///
  /// The color of icons adapts based on the current [OudsTextInputControlState].
  ///
  /// Param [context] is used to retrieve theme tokens and style modifiers.
  /// Param [state] determines visual styles depending on focus, hover, and enabled states.
  Widget? _buildSuffixIcon(
    BuildContext context,
    OudsFormFieldsControlState state,
  ) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextForegroundModifier = OudsFormFieldsForegroundColorModifier(
      context,
    );

    // Case 1: loader active
    if (widget.decoration.loader == true && _isTyping) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: textInput.spaceColumnGapDefault),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: double.infinity,
            ),
            child: OudsButton(
              icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
              package: OudsTheme.of(context).packageName,
              appearance: OudsButtonAppearance.minimal,
              loader: Loader(progress: null),
              onPressed: () {},
            ),
          ),
        ],
      );
    }

    // Case 2: display suffixIcon + optional error icon
    if (widget.decoration.suffixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.decoration.errorText != null) ...[
            SvgPicture.asset(
              excludeFromSemantics: true,
              AppAssets.icons.componentAlertImportantFill,
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
          ExcludeSemantics(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0,
                maxHeight: double.infinity,
              ),
              child: OudsButton(
                appearance: OudsButtonAppearance.minimal,
                icon: widget.decoration.suffixIcon,
                onPressed:
                    ((widget.enabled ?? true) && !(widget.readOnly ?? false))
                    ? widget.decoration.onSuffixPressed
                    : null,
              ),
            ),
          ),
        ],
      );
    }

    // Case 3: only error present
    if (widget.decoration.errorText != null) {
      return Container(
        constraints: BoxConstraints(
          minWidth: theme.componentsTokens(context).button.sizeMinWidth,
          minHeight: 0,
        ),
        padding: EdgeInsets.all(
          theme.componentsTokens(context).button.spaceInsetIconOnly,
        ),
        child: SvgPicture.asset(
          excludeFromSemantics: true,
          AppAssets.icons.componentAlertImportantFill,
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
  Widget? _buildPrefixIcon(
    BuildContext context,
    OudsFormFieldsControlState state,
  ) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.decoration.prefixIcon != null) ...[
          OudsTextField.buildIcon(
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

  /// Returns an [OudsLink] component displaying either the helper link.
  ///
  /// Applies the appropriate style and color based on the input state.
  ///
  /// Param [context]: The BuildContext.
  Widget _buildHelperLink(BuildContext context) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;

    // Return the Text widget with proper color and padding
    return Padding(
      padding: EdgeInsets.only(
        left: textInput.spacePaddingInlineDefault,
        right: textInput.spacePaddingInlineDefault,
      ),
      child: OudsLink(
        label: widget.helperLink!.label,
        onPressed: widget.helperLink?.onPressed,
        size: OudsLinkSize.small,
      ),
    );
  }
}
