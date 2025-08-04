import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTextInput extends StatefulWidget {
  final String label;
  final String? helperText;
  final Widget? suffixIcon;
  final String? prefixIcon;

  const OudsTextInput({
    super.key,
    required this.label,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsTextInputControlState? controlTextInputState,
    bool isError,
  ) {
    //final controlItemTextModifier = OudsControlTextModifier(context);

    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        //controlItemTextModifier.getTextColor(controlTextInputState, isError),
        Colors.black,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsTextInput> createState() => _OudsTextInputState();
}

class _OudsTextInputState extends State<OudsTextInput> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.label);
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

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
              color: theme.colorScheme(context).actionSupportEnabled,
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
                padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6, right: 6),
                child: Container(
                  //color: Colors.blue,
                  child: TextField(
                    cursorColor: theme.colorScheme(context).contentDefault,
                    focusNode: _focusNode,
                    controller: _controller,
                    style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(color: theme.colorScheme(context).contentDefault),
                    decoration: InputDecoration(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          widget.label,
                          style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(color: theme.colorScheme(context).contentDefault),
                        ),
                      ),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.prefixIcon != null)
                            Container(
                              color: Colors.transparent,
                              child: OudsTextInput.buildIcon(context, widget.prefixIcon!, null, false),
                            ),
                          SizedBox(width: textInput.spaceColumnGapDefault),
                        ],
                      ),
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "£",
                            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(color: theme.colorScheme(context).contentMuted),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(color: Colors.transparent, width: 8, height: 40),
                          Text(
                            "€",
                            style: theme.typographyTokens.typeLabelDefaultLarge(context).copyWith(
                                  color: theme.colorScheme(context).contentMuted,
                                ),
                          ),
                          Container(color: Colors.transparent, width: 8, height: 40),
                          if (widget.suffixIcon != null)
                            Container(
                                //color: Colors.red,
                                child: OudsButton(
                              style: OudsButtonStyle.defaultStyle,
                              hierarchy: OudsButtonHierarchy.minimal,
                              icon: widget.suffixIcon,
                              onPressed: () {},
                            )),
                        ],
                      ),
                      filled: false,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.helperText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.helperText!,
              style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: theme.colorScheme(context).contentMuted),
            ),
          ),
        ],
      ],
    );
  }
}
