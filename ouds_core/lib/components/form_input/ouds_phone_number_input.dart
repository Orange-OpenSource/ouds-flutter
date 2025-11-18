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

/// OudsPhoneNumberInput
library;

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_background_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_border_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_foreground_modifier.dart';
import 'package:ouds_core/components/form_input/internal/modifier/ouds_form_input_text_modifier.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/utilities/input_utils.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_textInput_tokens.dart';

// TODO: Add documentation URL once it is available
///
/// This widget allows users to enter a phone number with support for country selection,
/// automatic formatting, and visual icons or status indicators.
///
/// Parameters:
/// - [controller]: The text controller to access or modify the input value.
/// - [focusNode]: The focus node to manage focus on the input field.
/// - [enabled]: Indicates if the field is enabled (default: true).
/// - [readOnly]: If true, the field is read-only (default: false).
///   This parameter should be consistent with the [countrySelector], if used, to ensure coherent input management.
/// - [keyboardType]: The type of keyboard to display during input.
/// - [countrySelector]: Optional. If provided, displays a country selector for choosing the country of the number.
/// - [decoration]: Decoration configuration for the input field, including labels, icons, helper texts, etc.
/// - [onEditingComplete]: Callback invoked when editing is complete.
///
/// Usage example:
/// ```dart
/// Example 1: With a country selector
/// OudsPhoneNumberInput(
///   decoration: OudsInputDecoration(
///     labelText: "Phone Number",
///     hintText: "Enter your number",
///   ),
///   controller: myController,
///   countrySelector: CountrySelector(
///     readOnly: false,
///     countryFilter: CountryFilter.all,
///     codes: ["FR", "US"],
///     onCountryChanged: (country) {
///       // Handle country change if needed
///     },
///   ),
///   readOnly: false, // should be consistent with the countrySelector if it enforces read-only
/// )
/// ```
///
/// ```dart
/// Example 2: Without a country selector (direct input only)
/// OudsPhoneNumberInput(
///   decoration: OudsInputDecoration(
///     labelText: "Phone Number",
///     hintText: "Enter your number",
///   ),
///   controller: myController,
///   // No countrySelector provided
///   readOnly: false,
/// )
/// ```
//

class OudsPhoneNumberInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  CountrySelector? countrySelector;
  final OudsInputDecoration decoration;
  final void Function(String)? onEditingComplete;

  OudsPhoneNumberInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.countrySelector,
    required this.decoration,
    this.onEditingComplete,
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
  State<OudsPhoneNumberInput> createState() => _OudsPhoneNumberInputState();
}

class _OudsPhoneNumberInputState extends State<OudsPhoneNumberInput> {
  final bool _isHovered = false;
  bool _isFocused = false;
  FocusNode? _internalFocusNode;
  bool _isTyping = false;

  /// init countryselector
  Country countrySelected = Country.empty();

  /// init phone number dlib
  final phoneUtil = PhoneNumberUtil.instance;
  int? maxLength;

  /// Digits tapés par l'utilisateur
  @override
  void initState() {
    super.initState();

    // Listen to the external controller if provided
    // This allows us to detect text changes in real time.
    if (widget.controller != null) {
      widget.controller!.addListener(_handleTextChanged);
    }

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
  void didUpdateWidget(covariant OudsPhoneNumberInput oldWidget) {
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

    String? formattedNumber = "";
    String limitedDigits = "";

    //needed for accessibility
    final contentText = widget.controller?.text ?? "";
    final prefixText = contentText.isNotEmpty ? ", ${widget.decoration.prefix ?? ""}" : "";
    final helperText = isError ? widget.decoration.errorText ?? "" : widget.decoration.helperText ?? "";

    // Determine disabled/readOnly label
    final isEnabled = widget.enabled ?? true;
    final isReadOnly = widget.readOnly ?? false;
    final statusLabel = !isEnabled
        ? l10n?.core_common_disable_a11y ?? ""
        : isReadOnly
            ? l10n?.core_common_disable_a11y ?? ""
            : "";

    // Build Semantics value
    final semanticsValue = [
      l10n?.core_phone_number_input_a11y,
      widget.decoration.labelText,
      prefixText,
      contentText,
      helperText,
      statusLabel,
    ].where((s) => s != null && s.isNotEmpty).join(", ");

    return Semantics(
      label: semanticsValue,
      value: isError ? l10n?.core_common_onError_a11y : null,
      hint: widget.decoration.hintText ?? "",
      focused: effectiveFocusNode != null,
      focusable: true,
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

                // Bottom border styling; full border if style is not default
                border: inputTextBorderModifier.getBorder(state, isError, widget.decoration.outlined),
                // Border radius if enabled in theme configuration
                borderRadius: inputTextBorderModifier.getBorderRadius(context, isBorderRadius),
              ),
              child: ConstrainedBox(
                // Minimum height constraint for the input container
                constraints: BoxConstraints(minHeight: textInput.sizeMinHeight),

                // Padding inside the text input container
                child: Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: widget.countrySelector != null ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
                    end: (widget.decoration.errorText != null || widget.decoration.loader != null) ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
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
                        // we have added IgnorePointer to make the textfield not clickable when readOnly is true
                        child: widget.readOnly == true
                            ? IgnorePointer(
                                child: _buildTextField(inputTextTextModifier, state, isError, effectiveFocusNode, theme, context, textInput, effectiveIsFocused, formattedNumber, limitedDigits),
                              )
                            : _buildTextField(inputTextTextModifier, state, isError, effectiveFocusNode, theme, context, textInput, effectiveIsFocused, formattedNumber, limitedDigits),
                      ),

                      /// Right block: suffix icon container
                      Container(
                        alignment: Alignment.center,
                        child: Semantics(
                          label: "",
                          container: true,
                          button: true,
                          child: _buildSuffixIcon(context, state),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Display helper text or error text if available
            if (widget.decoration.helperText != null || widget.decoration.errorText != null) ...[
              ExcludeSemantics(child: _buildHelperOrErrorText(context, state, isError == true)),
            ],
          ],
        ),
      ),
    );
  }

  /// Function `_buildTextField`
  ///
  /// This function constructs and configures a custom `TextField` widget for user input.
  /// It manages the display, styling, and behavior of the text field based on the current state,
  /// theme, and provided parameters. It handles input formatting, dynamic label and hint display,
  /// and user interaction events, ensuring a consistent and styled input experience.
  ///
  /// Parameters:
  /// - `inputTextTextModifier`: Modifier for text and cursor colors based on state and errors.
  /// - `state`: Current control state (e.g., normal, focused, disabled).
  /// - `isError`: Whether the input is in an error state.
  /// - `effectiveFocusNode`: Focus node associated with the text field.
  /// - `theme`: Theme object providing styling tokens.
  /// - `context`: Build context for styling and layout.
  /// - `textInput`: Tokens for text input styling.
  /// - `effectiveIsFocused`: Whether the text field is currently focused.
  /// - `formattedNumber`: The formatted number string to display as hint or prefix.
  /// - `limitedDigits`: The limited digits string for display or validation.
  ///
  /// Behavior:
  /// - Sets the cursor color based on the modifier and state.
  /// - Applies input formatters to restrict input to digits and enforce maximum length.
  /// - Handles tap, outside tap, editing complete, submit, and change events to notify parent.
  /// - Configures the input decoration with optional label, hint, and prefix, styled according to theme.
  /// - Displays label text if provided, with height constraints and style.
  /// - Shows hint text if provided or if formattedNumber is available, styled accordingly.
  /// - Adds a prefix widget if prefix or country selector is present, styled appropriately.
  /// - Ensures the text field is dense for compact layout.
  TextField _buildTextField(OudsFormFieldsTextColorModifier inputTextTextModifier, OudsFormFieldsControlState state, bool isError, FocusNode? effectiveFocusNode, OudsThemeContract theme, BuildContext context, OudsTextInputTokens textInput,
      bool effectiveIsFocused, String formattedNumber, String limitedDigits) {
    return TextField(
      controller: widget.controller,
      cursorColor: inputTextTextModifier.getCursorTextColor(state, isError),
      focusNode: effectiveFocusNode,
      keyboardType: widget.keyboardType,
      style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
            color: inputTextTextModifier.getTextColor(state, isError),
          ),
      enabled: widget.enabled,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        MaxDigitsFormatter(getMaxDigitsFromLib(countrySelected.code)), // block extra digits
      ],
      onTap: () {
        final prefixCountry = (widget.countrySelector != null) ? widget.countrySelector?.selectedCountry?.prefix : widget.decoration.prefix;
        debugPrint("📞 Phone number input tapped. Current prefix: $prefixCountry");
        // send text tapped to parent
        widget.onEditingComplete?.call((prefixCountry ?? '') + (widget.controller?.text ?? ''));
      },
      onTapOutside: (outside) {
        final prefixCountry = (widget.countrySelector != null) ? widget.countrySelector?.selectedCountry?.prefix : widget.decoration.prefix;
        debugPrint("📞 Phone number input tapped. Current prefix: $prefixCountry");
        // send text tapped to parent
        widget.onEditingComplete?.call((prefixCountry ?? '') + (widget.controller?.text ?? ''));
      },
      onEditingComplete: () {
        final prefixCountry = (widget.countrySelector != null) ? widget.countrySelector?.selectedCountry?.prefix : widget.decoration.prefix;
        debugPrint("📞 Phone number input tapped. Current prefix: $prefixCountry");
        // send text tapped to parent
        widget.onEditingComplete?.call((prefixCountry ?? '') + (widget.controller?.text ?? ''));
      },
      onSubmitted: (value) {
        final prefixCountry = (widget.countrySelector != null) ? widget.countrySelector?.selectedCountry?.prefix : widget.decoration.prefix;
        debugPrint("📞 Phone number input tapped. Current prefix: $prefixCountry");
        // send text tapped to parent
        widget.onEditingComplete?.call((prefixCountry ?? '') + value);
      },
      onChanged: (value) {
        _onCountryChanged(value);
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
                        color: inputTextTextModifier.getTextLabelColor(state, isError),
                      ),
                ),
              )
            : null,

        // Floating label behavior: always float if both labelText and hintText are provided
        floatingLabelBehavior: (widget.decoration.labelText != null && widget.decoration.hintText != null) ? FloatingLabelBehavior.always : null,

        // Hint text widget, shown if hintText is provided
        hint: formattedNumber.isNotEmpty || widget.decoration.hintText != null
            ? Text(
                limitedDigits.isNotEmpty ? limitedDigits : widget.decoration.hintText!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                      color: inputTextTextModifier.getHintTextColor(state),
                    ),
              )
            : null,

        // Hint text widget, shown if hintText is provided
        prefix: (widget.decoration.prefix != null || widget.countrySelector?.selectedCountry != null) && widget.decoration.labelText != null && widget.decoration.hasPrefix ? _buildPrefixText(context, state) : null,
        isDense: true,
      ),
    );
  }

  /// Function `_onCountryChanged`
  ///
  /// This function is triggered when the user changes the country selection or updates the phone number input.
  /// It formats the phone number based on the selected country, enforces a maximum digit length,
  /// and updates the text controller with the formatted number while maintaining cursor position.
  ///
  /// Parameters:
  /// - `value`: The current input value of the phone number entered by the user.
  ///
  /// Behavior:
  /// - Checks if the formatter is already processing to prevent re-entrancy.
  /// - Retrieves the selected country or defaults to an empty country.
  /// - Strips all non-digit characters from the input.
  /// - Retrieves the maximum allowed digits for the selected country.
  /// - Limits the number of digits to the maximum allowed.
  /// - Parses and validates the number using a phone utility library.
  /// - Formats the number in national format if valid.
  /// - Updates the text controller with the formatted number, preserving cursor position.
  /// - Handles parsing errors gracefully and retains the raw digit string if formatting fails.
  bool _isFormatting = false;

  void _onCountryChanged(String value) {
    if (_isFormatting) return;
    _isFormatting = true;

    try {
      // If country selector is open, get country from selected country
      // Else get country from prefix
      if (widget.countrySelector != null) {
        countrySelected = widget.countrySelector?.selectedCountry ?? Country.empty();
      } else if (widget.decoration.prefix != null && widget.decoration.hasPrefix == true) {
        countrySelected = CountryService().findCountryByPrefix(widget.decoration.prefix ?? '') ?? Country.empty();
      } else {
        countrySelected = Country.empty();
      }

      // Remove non-digit characters
      String digitsOnly = value.replaceAll(RegExp(r'\D'), '');

      // Get max digits for country
      int? maxLength = getMaxDigitsFromLib(countrySelected.code);
      debugPrint("🌍 Country selected: ${countrySelected.code}");
      debugPrint("🔢 Digits only: $digitsOnly (raw input: $value)");
      debugPrint("📏 Max length from lib: $maxLength");

      // Limit digits if longer than max
      if (digitsOnly.length > maxLength) {
        digitsOnly = digitsOnly.substring(0, maxLength);
        debugPrint("✂️ Cutting digits from ${digitsOnly.length} to $maxLength");
      }

      String formattedNumber = digitsOnly;
      bool isValidNumber = false;

      try {
        final parsed = phoneUtil.parse(digitsOnly, countrySelected.code.toUpperCase());
        isValidNumber = phoneUtil.isValidNumber(parsed);

        if (isValidNumber) {
          final format = (widget.decoration.prefix != null && widget.decoration.hasPrefix == true) || (widget.countrySelector != null) ? PhoneNumberFormat.international : PhoneNumberFormat.national;
          formattedNumber = getFormattedNumber(parsed, countrySelected.code.toUpperCase(), format) ?? '';
          debugPrint("🎯 Formatted national: $formattedNumber");
        }
      } catch (e) {
        debugPrint("🚨 Parsing error: $e");
      }

      debugPrint("✅ Is valid: $isValidNumber");

      // Update controller only if text actually changes
      if (widget.controller?.text != formattedNumber) {
        debugPrint("✏️ Final text update: $formattedNumber");
        widget.controller?.value = TextEditingValue(
          text: formattedNumber,
          selection: TextSelection.collapsed(offset: formattedNumber.length),
        );
      }
    } finally {
      _isFormatting = false;
    }
  }

  /// Builds the prefix text widget for the text input field based on the current state.
  ///
  /// This method determines and displays the textual prefix to be shown
  /// before the main text input, depending on whether the `countrySelector`
  /// is enabled or a static `prefix` is provided in [widget.decoration].
  /// Cases handled:
  /// 1. **Country selector enabled** (`countrySelector == true`):
  ///    - Displays the dynamic `_prefix` value, which is updated when the
  ///      user selects a country in the [CountrySelector] widget.
  ///    - If `_prefix` is empty, no prefix text is rendered.
  ///
  /// 2. **Static prefix provided** (`decoration.prefix != null`):
  ///    - Displays the configured static prefix text from the decoration.
  ///    - If `prefix` is empty, no widget is displayed.
  ///
  /// 3. **No prefix available** (both `_prefix` and `decoration.prefix` are null/empty):
  ///    - Returns [SizedBox.shrink()], leaving no prefix space in the UI.
  ///
  /// The text style adapts dynamically based on the current
  /// [OudsTextInputControlState], ensuring proper theming for
  /// enabled, focused, hovered, and error states.
  ///
  /// Param [context] is used to access [OudsTheme] and typography tokens.
  /// Param [state] determines the text color styling according to the control state.
  Widget _buildPrefixText(BuildContext context, OudsFormFieldsControlState state) {
    final theme = OudsTheme.of(context);
    final inputTextTextModifier = OudsFormFieldsTextColorModifier(context);
    final textInput = theme.componentsTokens(context).textInput;
    final String? prefixToDisplay = widget.countrySelector != null ? widget.countrySelector?.selectedCountry?.prefix : widget.decoration.prefix;

    if (prefixToDisplay == null || prefixToDisplay.isEmpty) {
      return const SizedBox.shrink();
    }
    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            prefixToDisplay,
            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                  color: inputTextTextModifier.getSuffixPrefixTextColor(state),
                ),
          ),
          SizedBox(width: textInput.spaceColumnGapInlineText),
        ],
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

  /// Builds the prefix widget for the text input field based on the current decoration state.
  ///
  /// This method determines what appears in the prefix position of the text input,
  /// depending on the `prefixIcon` property from [widget.decoration] and the `countrySelector` flag.
  ///
  /// Cases handled:
  ///
  /// 1. **Prefix icon provided** (`prefixIcon != null`):
  ///    - Displays the configured prefix icon using [OudsTextInput.buildIcon].
  ///    - Adds horizontal spacing after the icon for proper layout alignment.
  ///
  /// 2. **Country selector enabled** (`countrySelector == true`):
  ///    - Displays a [CountrySelector] widget allowing the user to select a country.
  ///    - When the selected country changes, `_prefix` is updated via `setState`.
  ///    - Adds spacing after the country selector for consistent UI alignment.
  ///
  /// 3. **No prefix** (none of the above conditions match):
  ///    - Returns an empty [Row] (effectively no prefix widget).
  ///
  /// The color of the prefix icon adapts to the current [OudsTextInputControlState],
  /// ensuring consistent styling based on enabled/disabled/focused states.
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
          OudsTextField.buildIcon(
            context,
            widget.decoration.prefixIcon!,
            state,
            false,
          ),
          SizedBox(width: textInput.spaceColumnGapDefault),
        ],
        if (widget.countrySelector != null) ...[
          widget.countrySelector!,
          SizedBox(width: textInput.spaceColumnGapDefault),
        ],
      ],
    );
  }

  /// Builds the suffix widget for the text input field based on the current decoration state.
  ///
  /// This method determines what appears in the suffix position of the text input,
  /// depending on the `loader` and `errorText` properties from [widget.decoration].
  ///
  /// Cases handled:
  ///
  /// 1. **Loader active** (`loader == true`):
  ///    - Displays a minimal hierarchy [OudsButton] in loading style.
  ///    - Adds horizontal spacing before the loader for visual alignment.
  ///
  /// 2. **Only error state** (`errorText != null`):
  ///    - Displays the error alert icon with proper sizing and padding.
  ///    - The icon color is adapted based on the current [OudsTextInputControlState].
  ///
  /// 3. **No suffix** (none of the above conditions match):
  ///    - Returns `null`, meaning no widget will be displayed in the suffix position.
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
          ExcludeSemantics(
            child: OudsButton(
              icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
              appearance: OudsButtonAppearance.minimal,
              loader: Loader(progress: null),
              onPressed: () {},
            ),
          ),
        ],
      );
    }

    // Case 2: only error present
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
          excludeFromSemantics: true,
          AppAssets.icons.componentAlertImportant,
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

  /// Retrieves the maximum number of digits for a phone number in a given country using the phone number library.
  ///
  /// This function attempts to get an example number for the specified country code
  /// and returns the length of its national number, which indicates the maximum number of digits allowed.
  ///
  /// Parameters:
  /// - [countryCode]: The ISO country code (e.g., 'US', 'FR') in any case; it will be converted to uppercase.
  ///
  /// Returns:
  /// - The maximum number of digits as an integer if successful.
  /// - Null if the example number cannot be retrieved or an error occurs.
  int getMaxDigitsFromLib(String countryCode) {
    try {
      final exampleNumber = phoneUtil.getExampleNumber(countryCode.toUpperCase());
      if (exampleNumber != null && exampleNumber.nationalNumber.toString().isNotEmpty) {
        return exampleNumber.nationalNumber.toString().length;
      }
      //}
    } catch (_) {}
    return 0;
  }

  /// Converts an international phone number to its national format by removing the country code.
  ///
  /// This function takes a parsed phone number object and formats it into the specified format,
  /// then removes the country code prefix (e.g., '+33') to return only the local number formatted with spaces.
  ///
  /// Note: Assumes that [parsedNumber] has already been parsed correctly with the appropriate country code.
  ///
  /// - Parameters:
  ///   - [parsedNumber]: The parsed [PhoneNumber] object obtained from parsing the input number.
  ///   - [countryCode]: The ISO country code (e.g., 'FR', 'US') in any case; it will be converted to uppercase.
  ///   - [format]: The desired [PhoneNumberFormat] (e.g., international, national).
  ///
  /// - Returns:
  ///   - The formatted national number as a string with spaces if successful.
  ///   - Null if an error occurs during formatting or processing.
  String? getFormattedNumber(PhoneNumber parsedNumber, String countryCode, PhoneNumberFormat format) {
    try {
      // Format the number in the specified format (international or national)
      final formattedNumber = phoneUtil.format(parsedNumber, format);
      // Remove the country code prefix (e.g., '+33 ') from the formatted string
      String numberWithoutCountryCode = formattedNumber.replaceFirst(RegExp(r'^\+\d+\s'), '');
      return numberWithoutCountryCode;
    } catch (e) {
      debugPrint('Error during conversion: $e');
      return null;
    }
  }
}

/// A custom [TextInputFormatter] that limits the number of digits a user can input.
///
/// This formatter allows only numeric input and enforces a maximum number of digits.
/// It strips out all non-digit characters and prevents further input once the limit is reached.
///
/// Parameters:
/// - [maxDigits]: The maximum number of digits allowed in the input.
///
/// Usage:
/// ```dart
/// TextField(
///   keyboardType: TextInputType.number,
///   inputFormatters: [MaxDigitsFormatter(10)],
/// )
/// ```
/// This example restricts the input to a maximum of 10 digits.
class MaxDigitsFormatter extends TextInputFormatter {
  final int maxDigits;

  /// Creates a [MaxDigitsFormatter] with the specified maximum number of digits.
  MaxDigitsFormatter(this.maxDigits);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > maxDigits) {
      debugPrint("🛑 Blocked at $maxDigits digits");
      return oldValue; // Stop typing
    }
    return newValue;
  }
}
