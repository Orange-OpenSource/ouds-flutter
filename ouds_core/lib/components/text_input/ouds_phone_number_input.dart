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

import 'package:dlibphonenumber/enums/phone_number_format.dart';
import 'package:dlibphonenumber/phone_number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/country_selector/ouds_country_selector.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_foreground_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
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

/// A custom widget for phone number input with country management, formatting, and icons.
///
/// This widget allows users to enter a phone number with support for country selection,
/// automatic formatting, and display of icons or visual states.
///
/// Parameters :
///
/// - [controller] : Text editing controller to access or modify the input value.
/// - [focusNode] : FocusNode to manage the input focus.
/// - [enabled] : Indicates whether the input is enabled (default: true).
/// - [readOnly] : If true, the input is read-only (default: false).
/// - [keyboardType] : The type of keyboard to display during input.
/// - [countrySelector] : If true, displays a country selector for choosing the phone's country.
/// - [countryFilter] : Filter to limit country selection (default: [CountryFilter.all]).
/// - [countriesCode] : Optional list of allowed country codes.
/// - [decoration] : Decoration configuration for the input, including labels, icons, helper texts, etc.
///
/// Example usage :
/// ```dart
/// OudsPhoneNumberInput(
///   decoration: OudsInputDecoration(
///     labelText: "Phone Number",
///     hintText: "Enter your number",
///   ),
///   countrySelector: true,
///   controller: myController,
/// )
/// ```
class OudsPhoneNumberInput extends StatefulWidget {
  TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final bool? countrySelector;
  final CountryFilter countryFilter;
  final List<String>? countriesCode;
  OudsInputDecoration decoration;

  OudsPhoneNumberInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.countrySelector,
    this.countryFilter = CountryFilter.all,
    this.countriesCode,
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
  //late String _prefix;
  /// init countryselector
  Country countrySelected = Country.empty();

  /// init phone number dlib
  final phoneUtil = PhoneNumberUtil.instance;
  int? maxLength;

  @override
  void initState() {
    super.initState();
    // Init prefix en fonction du countrySelector
    /*if (widget.countrySelector == true) {
      _prefix = widget.decoration.prefix ?? "";
    } else {
      _prefix = "";
    }*/

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

    final l10n = OudsLocalizations.of(context);

    String? formattedNumber;
    String limitedDigits = "";

    return MergeSemantics(
      child: Semantics(
        textField: true,
        label: l10n?.core_components_text_input_input_a11y,
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
                          child: Container(
                            alignment: Alignment.center,
                            //width: 50,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
                              ],
                              cursorColor: inputTextTextModifier.getCursorTextColor(state, isError),
                              focusNode: effectiveFocusNode,
                              controller: widget.controller,
                              keyboardType: widget.keyboardType,
                              style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                    color: inputTextTextModifier.getTextColor(state, isError),
                                  ),
                              enabled: widget.enabled,
                              readOnly: widget.readOnly ?? false,
                              onChanged: (value) async {
                                // 1. Clean the input to keep only digits
                                final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

                                // 2. Retrieve the maximum allowed length for the selected country
                                final maxDigits = await getMaxDigitsFromLib(countrySelected.code);
                                print("maxLength: $maxDigits");

                                // 3. Limit the input to the maximum length
                                limitedDigits = digitsOnly;
                                if (maxDigits != null && digitsOnly.length > maxDigits) {
                                  limitedDigits = digitsOnly.substring(0, maxDigits);
                                }

                                // 4. Format the number
                                try {
                                  if (widget.countrySelector == false) {
                                    // Parse and format as national number if country selector is disabled
                                    final parsedNumber = phoneUtil.parse(limitedDigits, countrySelected.code.toUpperCase());
                                    formattedNumber = phoneUtil.format(parsedNumber, PhoneNumberFormat.national);
                                  } else {
                                    // Parse and format as international number if country selector is enabled
                                    final parsedNumber = phoneUtil.parse(limitedDigits, countrySelected.code.toUpperCase());
                                    String phoneNumber = phoneUtil.format(parsedNumber, PhoneNumberFormat.international);
                                    // Convert international number to national format
                                    formattedNumber = await getNationalNumber(phoneNumber, countrySelected.code.toUpperCase());
                                  }

                                  // 5. Update the controller's value with the formatted number
                                  final selectionIndex = widget.controller?.selection.baseOffset ?? 0;

                                  widget.controller?.value = TextEditingValue(
                                    text: formattedNumber!,
                                    // Keep the cursor position after the inserted formatted number
                                    selection: TextSelection.collapsed(offset: selectionIndex + (formattedNumber!.length)),
                                  );

                                  // Store the maximum length for future reference
                                  maxLength = maxDigits;

                                  debugPrint("maxLength: $maxDigits, limitedDigits: $limitedDigits, formattedNumber: $formattedNumber, value: $value, country: ${countrySelected.code.toUpperCase()}");
                                } catch (e) {
                                  // If an error occurs during parsing or formatting, keep the raw digits
                                  widget.controller?.value = TextEditingValue(
                                    text: limitedDigits,
                                    // Place cursor at the end of the input
                                    selection: TextSelection.collapsed(offset: limitedDigits.length),
                                  );
                                }
                              },
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
                                hint: widget.decoration.hintText != null || formattedNumber != null
                                    ? Text(
                                        limitedDigits,
                                        style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                              color: inputTextTextModifier.getHintTextColor(state),
                                            ),
                                      )
                                    : null,

                                // Hint text widget, shown if hintText is provided
                                prefix: (widget.decoration.prefix != null || countrySelected.prefix.isNotEmpty) && widget.decoration.labelText != null ? _buildPrefixText(context, state) : null,

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

  /// Builds the prefix text widget for the text input field based on the current state.
  ///
  /// This method determines and displays the textual prefix to be shown
  /// before the main text input, depending on whether the `countrySelector`
  /// is enabled or a static `prefix` is provided in [widget.decoration].
  ///
  /// Cases handled:
  ///
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
  Widget _buildPrefixText(BuildContext context, OudsTextInputControlState state) {
    final theme = OudsTheme.of(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);
    final textInput = theme.componentsTokens(context).textInput;
    final String? prefixToDisplay = widget.countrySelector == true ? countrySelected.prefix : widget.decoration.prefix;

    if (prefixToDisplay == null || prefixToDisplay.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
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
            countryFilter: widget.countryFilter,
            codes: widget.countriesCode,
            onCountryChanged: (country) {
              setState(() {
                countrySelected = country;
                print("countrySelected.prefix:${countrySelected.code}");
                // widget.decoration = widget.decoration.copyWith(prefix: country.prefix);
              });
            },
          ),
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
            icon: 'assets/ic_heart.svg',
            hierarchy: OudsButtonHierarchy.minimal,
            loader: Loader(progress: null),
            onPressed: () {},
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
  Future<int?> getMaxDigitsFromLib(String countryCode) async {
    try {
      final exampleNumber = phoneUtil.getExampleNumber(countryCode.toUpperCase());
      if (exampleNumber != null && exampleNumber.nationalNumber.toString().isNotEmpty) {
        return exampleNumber.nationalNumber.toString().length;
      }
      //}
    } catch (_) {}
    return null;
  }

  /// Converts an international phone number to its national format for a specific country.
  ///
  /// This function parses the provided international number and formats it into the national
  /// format based on the country code.
  ///
  /// Parameters:
  /// - [internationalNumber]: The phone number in international format (e.g., '+33 6 12 34 56 78').
  /// - [countryCode]: The ISO country code (e.g., 'FR', 'US') in any case; it will be converted to uppercase.
  ///
  /// Returns:
  /// - The formatted national number as a string if successful.
  /// - Null if parsing or formatting fails.
  Future<String?> getNationalNumber(String internationalNumber, String countryCode) async {
    try {
      // Parse le numéro international
      final parsed = await phoneUtil.parse(internationalNumber, countryCode.toUpperCase());
      final formated = phoneUtil.format(parsed, PhoneNumberFormat.national);
      // Retourner le numéro national
      return formated;
    } catch (e) {
      print('Erreur lors de la conversion : $e');
      return null;
    }
  }
}
