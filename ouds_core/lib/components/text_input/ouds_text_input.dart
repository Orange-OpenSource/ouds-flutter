import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_border_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_foreground_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? helperText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final String? prefix;
  final String? suffix;
  final String? errorText;

  const OudsTextInput({
    super.key,
    this.controller,
    required this.labelText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.errorText,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsTextInputControlState? controlTextInputState,
    bool isError,
  ) {
    //final controlItemTextModifier = OudsControlTextModifier(context);
    final theme = OudsTheme.of(context);
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      width: theme.componentsTokens(context).textInput.sizeLeadingIcon,
      colorFilter: ColorFilter.mode(
        //controlItemTextModifier.getTextColor(controlTextInputState, isError),
        theme.colorScheme(context).contentMuted,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsTextInput> createState() => _OudsTextInputState();
}

class _OudsTextInputState extends State<OudsTextInput> {
  final FocusNode _focusNode = FocusNode();

  final bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputTextStateDeterminer = OudsTextInputControlStateDeterminer(
      enabled: true,
      isFocused: _isFocused,
      isHovered: _isHovered,
    );

    final state = inputTextStateDeterminer.determineControlState();
    final inputTextBackgroundModifier = OudsTextInputBackgroundColorModifier(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);
    final inputTextForegroundModifier = OudsTextInputForegroundColorModifier(context);
    final inputTextBorderModifier = OudsTextInputBorderModifier(context);
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    final isError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: inputTextBackgroundModifier.getBackgroundColor(state, isError),
            //color: Colors.yellow,
            /// Border bottom
            border: Border(bottom: inputTextBorderModifier.getBorder(state, isError)),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 60),
            child: Padding(
              padding: EdgeInsets.only(
                left: textInput.spacePaddingInlineDefault,
                top: textInput.spacePaddingBlockDefault,
                bottom: textInput.spacePaddingBlockDefault,
                right: widget.errorText == true || widget.suffixIcon == true ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
              ),
              child: Container(
                //color: Colors.blue,
                child: TextField(
                  cursorColor: theme.colorScheme(context).contentDefault,
                  focusNode: _focusNode,
                  controller: widget.controller,
                  style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                        color: inputTextTextModifier.getTextColor(state, isError),
                      ),
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        widget.labelText,
                        style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                              color: inputTextTextModifier.getTextColor(state, isError),
                            ),
                      ),
                    ),
                    hint: widget.hintText != null
                        ? Text(
                            widget.hintText!,
                            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                  color: inputTextTextModifier.getTextColor(state, isError),
                                ),
                          )
                        : null,
                    floatingLabelBehavior: widget.hintText != null ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          OudsTextInput.buildIcon(
                            context,
                            widget.prefixIcon!,
                            null,
                            false,
                          ),
                          SizedBox(width: textInput.spaceColumnGapDefault),
                        ],
                      ],
                    ),
                    prefix: widget.prefix != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.prefix!,
                                style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                      color: inputTextTextModifier.getSuffixPrefixTextColor(state),
                                    ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          )
                        : null,
                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    suffix: widget.suffix != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 8),
                              Text(
                                widget.suffix!,
                                style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                      color: inputTextTextModifier.getSuffixPrefixTextColor(state),
                                    ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          )
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.errorText == true) ...[
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
                                icon: widget.suffixIcon,
                                onPressed: () {},
                              ),
                            ],
                          )
                        : widget.errorText == true
                            ? OudsButton(
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
                              )
                            : null,
                    filled: false,
                    border: InputBorder.none,
                    isDense: true,
                    //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
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
  Widget _buildHelperOrErrorText(
    BuildContext context,
    OudsTextInputControlState state,
    bool isError,
  ) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);

    // Select the text to display: prioritize error text over helper text
    final String? text = isError ? widget.errorText : widget.helperText;

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
}
