import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/control/internal/controller/interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_text_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

class OudsControlItem extends StatefulWidget {
  final String text;
  final String? helperText;
  final String? icon;
  final bool divider;
  final bool inverted;
  final bool readOnly;
  final bool error;
  final String errorComponentName;
  final Widget Function() indicator;
  final String? additionalText;

  final VoidCallback? onTap;

  const OudsControlItem({
    super.key,
    required this.text,
    required this.errorComponentName,
    required this.indicator,
    this.helperText,
    this.icon,
    this.divider = false,
    this.inverted = false,
    this.readOnly = false,
    this.error = false,
    this.additionalText,
    this.onTap,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsControlState controlItemState,
    bool isError,
  ) {
    final controlItemTextModifier = OudsControlTextModifier(context);

    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        controlItemTextModifier.getTextColor(controlItemState, isError),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  OudsControlItemState createState() => OudsControlItemState();
}

class OudsControlItemState extends State<OudsControlItem> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final controlItemStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onTap != null,
      isPressed: _isPressed,
      isHovered: _isHovered,
      isReadOnly: widget.readOnly,
    );

    final interactionController = Get.isRegistered<InteractionStateController>() ? Get.find<InteractionStateController>() : Get.put(InteractionStateController());

    final controlItemState = controlItemStateDeterminer.determineControlState();
    final controlItemBackgroundModifier = OudsControlBackgroundModifier(context);

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: OudsTheme.of(context).componentsTokens.controlItem.spaceInset,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: controlItemBackgroundModifier.getBackgroundColor(controlItemState),
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(OudsTheme.of(context).borderTokens.radiusNone),
        ),
        constraints: BoxConstraints(
          minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMinHeight,
          minWidth: OudsTheme.of(context).componentsTokens.controlItem.sizeMinWidth,
        ),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMinHeight,
              ),
              child: InkWell(
                onTap: !widget.readOnly ? widget.onTap : null,
                onHighlightChanged: (isPressed) {
                  setState(() {
                    _isPressed = isPressed;
                    interactionController.setPressed(isPressed);
                  });
                },
                onHover: (hovering) {
                  setState(() {
                    _isHovered = hovering;
                    interactionController.setHovered(hovering);
                  });
                },
                highlightColor: Colors.transparent,
                hoverColor: OudsTheme.of(context).componentsTokens.controlItem.colorBgHover,
                splashColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(
                    OudsTheme.of(context).componentsTokens.controlItem.spaceInset,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: !widget.inverted ? _buildStandardLayout(controlItemState) : _buildInvertedLayout(controlItemState),
                  ),
                ),
              ),
            ),
            if (widget.divider)
              Divider(
                height: 0,
                thickness: OudsTheme.of(context).borderTokens.widthDefault,
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStandardLayout(OudsControlState controlItemState) => [
        AbsorbPointer(
          child: SizedBox(
            height: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
            width: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
            child: widget.indicator(),
          ),
        ),
        Container(
          width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap,
        ),
        _buildTextWithAdditionalAndHelper(controlItemState),
        if (widget.icon != null)
          Container(
            width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap,
          ),
        if (widget.icon != null)
          SizedBox(
            height: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
            width: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
            child: OudsControlItem.buildIcon(
              context,
              widget.icon!,
              controlItemState,
              false,
            ),
          ),
      ];

  List<Widget> _buildInvertedLayout(OudsControlState controlItemState) => [
        if (widget.icon != null)
          SizedBox(
            height: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
            width: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
            child: OudsControlItem.buildIcon(
              context,
              widget.icon!,
              controlItemState,
              false,
            ),
          ),
        if (widget.icon != null) SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),
        _buildTextWithAdditionalAndHelper(controlItemState),
        SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),
        AbsorbPointer(
          child: SizedBox(
            height: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
            width: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
            child: widget.indicator(),
          ),
        ),
      ];

  Widget _buildTextWithAdditionalAndHelper(OudsControlState controlItemState) {
    final controlItemTextModifier = OudsControlTextModifier(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              fontSize: OudsTheme.of(context).fontTokens.sizeLabelLarge,
              letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelLarge,
              fontWeight: OudsTheme.of(context).fontTokens.weightLabelDefault,
              color: controlItemTextModifier.getTextColor(controlItemState, widget.error),
            ),
          ),
          if (widget.additionalText != null) ...[
            SizedBox(height: OudsTheme.of(context).componentsTokens.controlItem.spaceRowGap),
            Text(
              widget.additionalText!,
              style: TextStyle(
                fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                fontWeight: OudsTheme.of(context).fontTokens.weightStrong,
                color: controlItemTextModifier.getAdditionalTextColor(controlItemState),
              ),
            ),
          ],
          if (widget.helperText != null) ...[
            SizedBox(height: OudsTheme.of(context).componentsTokens.controlItem.spaceRowGap),
            Text(
              widget.helperText!,
              style: TextStyle(
                fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                fontWeight: OudsTheme.of(context).fontTokens.weightBodyDefault,
                color: controlItemTextModifier.getHelperTextColor(controlItemState),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
