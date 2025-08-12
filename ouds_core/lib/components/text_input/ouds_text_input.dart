import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_foreground_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The [OudsTextInputStyle] defines the style visual behavior and feedback.
enum OudsTextInputStyle {
  defaultStyle,
  alternative,
}

class OudsInputDecoration {
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final String? prefix;
  final String? suffix;
  final String? errorText;
  final bool? loader;
  final OudsTextInputStyle? style;

  const OudsInputDecoration({
    this.labelText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.errorText,
    this.loader,
    this.style = OudsTextInputStyle.defaultStyle,
  });
}

class OudsTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final OudsInputDecoration decoration;

  const OudsTextInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    required this.decoration,
  });

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
  State<OudsTextInput> createState() => _OudsTextInputState();
}

class _OudsTextInputState extends State<OudsTextInput> {
  final bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = widget.focusNode!.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputTextStateDeterminer = OudsTextInputControlStateDeterminer(enabled: widget.enabled!, isFocused: _isFocused, isHovered: _isHovered, isLoading: widget.decoration.loader ?? false);

    final state = inputTextStateDeterminer.determineControlState();
    final inputTextBackgroundModifier = OudsTextInputBackgroundColorModifier(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);
    final inputTextBorderModifier = OudsTextInputBorderModifier(context);
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    final isError = widget.decoration.errorText != null;
    final isBorderRadius = OudsThemeConfigModel.of(context)?.textInput?.rounded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: inputTextBackgroundModifier.getBackgroundColor(state, isError, widget.decoration.style),
            //color: Colors.yellow,

            /// Border bottom
            border: widget.decoration.style == OudsTextInputStyle.defaultStyle
                ? Border(bottom: inputTextBorderModifier.getBorder(state, isError))
                : Border(
                    bottom: inputTextBorderModifier.getBorder(state, isError), top: inputTextBorderModifier.getBorder(state, isError), left: inputTextBorderModifier.getBorder(state, isError), right: inputTextBorderModifier.getBorder(state, isError)),
            borderRadius: inputTextBorderModifier.getBorderRadius(context, isBorderRadius),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: textInput.sizeMinHeight),

            /// Padding inside Text Input container
            child: Padding(
              padding: EdgeInsetsGeometry.directional(
                start: textInput.spacePaddingInlineDefault,
                end: (widget.decoration.suffixIcon != null || widget.decoration.errorText != null) ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
                top: textInput.spacePaddingBlockDefault,
                bottom: textInput.spacePaddingBlockDefault,
              ),
              child: Row(
                children: [
                  /// Bloc left : prefixIcon
                  Container(
                    alignment: Alignment.center,
                    child: _buildPrefixIcon(context, state),
                  ),

                  /// Bloc center : texte
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      //color: Colors.blue, // pour visualiser
                      child: TextField(
                        cursorColor: inputTextTextModifier.getCursorTextColor(state, isError),
                        focusNode: widget.focusNode,
                        controller: widget.controller,
                        keyboardType: widget.keyboardType,
                        style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                              color: inputTextTextModifier.getTextColor(state, isError),
                            ),
                        enabled: widget.enabled,
                        readOnly: widget.readOnly!,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: widget.decoration.labelText != null
                              ? Text(
                                  widget.decoration.labelText ?? "",
                                  style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                        color: inputTextTextModifier.getTextColor(state, isError),
                                      ),
                                )
                              : null,

                          /// Floating only labelText && hintText is true or labelText is true
                          floatingLabelBehavior: (widget.decoration.labelText != null && widget.decoration.hintText != null) ? FloatingLabelBehavior.always : null,
                          hint: widget.decoration.hintText != null
                              ? Text(
                                  widget.decoration.hintText!,
                                  style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                        color: inputTextTextModifier.getHintTextColor(state),
                                      ),
                                )
                              : null,
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
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0), // Override default prefix icon constraints to adapt them for OUDS design:
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

                  /// Bloc right : suffixIcon
                  Container(
                    alignment: Alignment.center,
                    child: _buildSuffixIcon(context, state),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.decoration.helperText != null || widget.decoration.errorText != null) ...[
          _buildHelperOrErrorText(context, state, isError == true),
        ],
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
            style: OudsButtonStyle.loading,
            hierarchy: OudsButtonHierarchy.minimal,
            icon: widget.decoration.suffixIcon ?? const SizedBox(width: 24, height: 24),
            onPressed: widget.enabled! ? () {} : null,
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
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                inputTextForegroundModifier.getForegroundColor(state),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: textInput.spaceColumnGapTrailingErrorAction),
          ],
          OudsButton(
            style: OudsButtonStyle.defaultStyle,
            hierarchy: OudsButtonHierarchy.minimal,
            icon: widget.decoration.suffixIcon,
            onPressed: widget.enabled! ? () {} : null,
          ),
        ],
      );
    }

    // Case 3: only error present
    if (widget.decoration.errorText != null) {
      return OudsButton(
        style: OudsButtonStyle.defaultStyle,
        hierarchy: OudsButtonHierarchy.minimal,
        icon: SvgPicture.asset(
          AppAssets.icons.importantAlert,
          package: theme.packageName,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            inputTextForegroundModifier.getForegroundColor(state),
            BlendMode.srcIn,
          ),
        ),
        onPressed: () {},
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
  /// The color of icons adapts based on the current [OudsTextInputControlState].
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
      ],
    );
  }
}
