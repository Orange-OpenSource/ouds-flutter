import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_background_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_foreground_modifier.dart';
import 'package:ouds_core/components/text_input/internal/modifier/ouds_text_input_text_modifier.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTextInput extends StatefulWidget {
  final String labelText;
  final String? helperText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final String? prefix;
  final String? suffix;
  final bool? isError;

  const OudsTextInput({
    super.key,
    required this.labelText,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.isError = false,
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

    final inputTextState = inputTextStateDeterminer.determineControlState();
    final inputTextBackgroundModifier = OudsTextInputBackgroundColorModifier(context);
    final inputTextTextModifier = OudsTextInputTextColorModifier(context);
    final inputTextForegroundModifier = OudsTextInputForegroundColorModifier(context);
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    final TextEditingController controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTapUp: (_) {
            _focusNode.requestFocus();
          },
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: inputTextBackgroundModifier.getBackgroundColor(inputTextState, widget.isError!),
              //color: Colors.yellow,
              border: Border(
                bottom: BorderSide(
                  color: _focusNode.hasFocus ? textInput.colorBorderFocus : textInput.colorBorderEnabled,
                  width: _focusNode.hasFocus ? textInput.borderWidthFocus : textInput.borderWidthDefault,
                ),
              ),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 60),
              child: Padding(
                padding: EdgeInsets.only(
                  left: textInput.spacePaddingInlineDefault,
                  top: textInput.spacePaddingBlockDefault,
                  bottom: textInput.spacePaddingBlockDefault,
                  right: widget.isError == true || widget.suffixIcon == true ? textInput.spacePaddingInlineTrailingAction : textInput.spacePaddingInlineDefault,
                ),
                child: Container(
                  //color: Colors.blue,
                  child: TextField(
                    cursorColor: theme.colorScheme(context).contentDefault,
                    focusNode: _focusNode,
                    controller: controller,
                    style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                          color: inputTextTextModifier.getTextColor(inputTextState, widget.isError!),
                        ),
                    decoration: InputDecoration(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          widget.labelText,
                          style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                color: inputTextTextModifier.getTextColor(inputTextState, widget.isError!),
                              ),
                        ),
                      ),

                      //labelText: widget.labelText,
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
                                        color: inputTextTextModifier.getSuffixPrefixTextColor(inputTextState),
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
                                        color: inputTextTextModifier.getSuffixPrefixTextColor(inputTextState),
                                      ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            )
                          : null,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Cas 1 : suffixIcon présent, pas d'erreur
                          if (widget.suffixIcon != null && widget.isError == false)
                            OudsButton(
                              style: OudsButtonStyle.defaultStyle,
                              hierarchy: OudsButtonHierarchy.minimal,
                              icon: widget.suffixIcon,
                              onPressed: () {},
                            ),

                          /// Cas 2 : pas de suffixIcon, mais erreur présente
                          if (widget.suffixIcon == null && widget.isError == true)
                            OudsButton(
                              style: OudsButtonStyle.defaultStyle,
                              hierarchy: OudsButtonHierarchy.minimal,
                              icon: SvgPicture.asset(
                                AppAssets.icons.importantAlert,
                                package: theme.packageName,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  inputTextForegroundModifier.getForegroundColor(inputTextState),
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {},
                            ),

                          /// Cas 3 : suffixIcon présent + erreur
                          if (widget.suffixIcon != null && widget.isError == true) ...[
                            SvgPicture.asset(
                              AppAssets.icons.importantAlert,
                              package: theme.packageName,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                inputTextForegroundModifier.getForegroundColor(inputTextState),
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: textInput.spaceColumnGapTrailingErrorAction),
                            OudsButton(
                              style: OudsButtonStyle.defaultStyle,
                              hierarchy: OudsButtonHierarchy.minimal,
                              icon: widget.suffixIcon,
                              onPressed: () {},
                            ),
                          ],
                        ],
                      ),
                      filled: false,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.helperText != null) ...[
          Padding(
            padding: EdgeInsets.only(
              top: textInput.spacePaddingBlockTopHelperText,
              left: textInput.spacePaddingInlineDefault,
              right: textInput.spacePaddingInlineDefault,
            ),
            child: Text(
              widget.helperText!,
              style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(
                    color: inputTextTextModifier.getHelperTextColor(inputTextState, widget.isError!),
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
