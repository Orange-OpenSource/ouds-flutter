import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/controller/ouds_interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_text_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// Refactor of controls for [Checkbox], [Switch], and [RadioButton].
/// This implementation provides a customizable control item with properties such as text, icon, and interaction states.
/// It manages its own interaction state and can respond to tap events if not in read-only mode.
class OudsControlItem extends StatefulWidget {
  final String text;
  final String? helperText;
  final String? icon;
  final bool divider;
  final bool reversed;
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
    this.reversed = false,
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
  // Create an instance of the state controller to manage interaction changes
  final OudsInteractionStateController interactionState = OudsInteractionStateController();

  @override
  void initState() {
    super.initState();
    // Add a listener to rebuild the widget on every state change
    interactionState.addListener(_onInteractionChanged);
  }

  // Callback function that will be called on each state change
  void _onInteractionChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    interactionState.removeListener(_onInteractionChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controlItemStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onTap != null,
      isPressed: interactionState.isPressed,
      isHovered: interactionState.isHovered,
      isReadOnly: widget.readOnly,
    );

    final controlItemState = controlItemStateDeterminer.determineControlState();
    final controlItemBackgroundModifier = OudsControlBackgroundModifier(context);

    return OudsInheritedInteractionModel(
      state: interactionState,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: OudsTheme.of(context).componentsTokens(context).controlItem.spaceInset,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // Set the background color based on the control's state
                color: controlItemBackgroundModifier.getBackgroundColor(controlItemState),
                border: Border.all(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(OudsTheme.of(context).borderTokens.radiusNone),
              ),
              // Ensure minimum height for the item container
              constraints: BoxConstraints(
                minHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMinHeight,
                minWidth: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMinWidth,
              ),
              child: InkWell(
                // Handle tap events if not in read-only mode
                onTap: !widget.readOnly ? widget.onTap : null,
                onHighlightChanged: (isPressed) {
                  interactionState.setPressed(isPressed);
                },
                onHover: (hovering) {
                  interactionState.setHovered(hovering);
                },
                highlightColor: Colors.transparent,
                hoverColor: OudsTheme.of(context).componentsTokens(context).controlItem.colorBgHover,
                splashColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsetsDirectional.all(
                    OudsTheme.of(context).componentsTokens(context).controlItem.spaceInset,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: !widget.reversed ? _buildStandardLayout(controlItemState) : _buildInvertedLayout(controlItemState),
                    ),
                  ),
                ),
              ),
            ),
            // If specified, display a separator line under the control item
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
          child: Container(
            constraints: BoxConstraints(
              maxHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMaxHeightAssetsContainer,
              minHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              height: OudsTheme.of(context).componentsTokens(context).checkbox.sizeIndicator,
              width: OudsTheme.of(context).componentsTokens(context).checkbox.sizeIndicator,
              child: widget.indicator(),
            ),
          ),
        ),
        Container(
          width: OudsTheme.of(context).componentsTokens(context).controlItem.spaceColumnGap,
        ),
        _buildTextWithAdditionalAndHelper(controlItemState),
        if (widget.icon != null)
          Container(
            width: OudsTheme.of(context).componentsTokens(context).controlItem.spaceColumnGap,
          ),
        if (widget.icon != null)
          Container(
            constraints: BoxConstraints(
              maxHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMaxHeightAssetsContainer,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              height: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
              width: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
              child: OudsControlItem.buildIcon(
                context,
                widget.icon!,
                controlItemState,
                false,
              ),
            ),
          ),
      ];

  List<Widget> _buildInvertedLayout(OudsControlState controlItemState) => [
        if (widget.icon != null)
          Container(
            constraints: BoxConstraints(
              maxHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMaxHeightAssetsContainer,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              height: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
              width: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
              child: OudsControlItem.buildIcon(
                context,
                widget.icon!,
                controlItemState,
                false,
              ),
            ),
          ),
        if (widget.icon != null) SizedBox(width: OudsTheme.of(context).componentsTokens(context).controlItem.spaceColumnGap),
        _buildTextWithAdditionalAndHelper(controlItemState),
        SizedBox(width: OudsTheme.of(context).componentsTokens(context).controlItem.spaceColumnGap),
        AbsorbPointer(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMaxHeightAssetsContainer,
              minHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeIcon,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              height: OudsTheme.of(context).componentsTokens(context).checkbox.sizeIndicator,
              width: OudsTheme.of(context).componentsTokens(context).checkbox.sizeIndicator,
              child: widget.indicator(),
            ),
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
            SizedBox(height: OudsTheme.of(context).componentsTokens(context).controlItem.spaceRowGap),
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
            SizedBox(height: OudsTheme.of(context).componentsTokens(context).controlItem.spaceRowGap),
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
