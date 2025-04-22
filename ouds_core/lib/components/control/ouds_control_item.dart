import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/control/internal/controller/interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_text_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// A reusable control item that can represent a checkbox, radio button, or switch item.
class OudsControlItem extends StatefulWidget {
  final String text;
  final String? helperText;
  final Widget? icon;
  final bool divider;
  final bool inverted;
  final bool readOnly;
  final bool error;
  final String errorComponentName;
  final Widget Function() indicator;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? additionalText;

  const OudsControlItem({
    super.key,
    required this.text,
    this.helperText,
    this.icon,
    this.divider = false,
    this.inverted = false,
    this.readOnly = false,
    this.error = false,
    required this.errorComponentName,
    required this.indicator,
    required this.value,
    this.onChanged,
    this.additionalText,
  });

  @override
  OudsControlItemState createState() => OudsControlItemState();
}

class OudsControlItemState extends State<OudsControlItem> {
  bool get _isEnabled => widget.onChanged != null;
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final controlItemStateDeterminer = OudsControlStateDeterminer(
      enabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    // Initiate GetX
    final interactionController = Get.isRegistered<InteractionStateController>() ? Get.find<InteractionStateController>() : Get.put(InteractionStateController());

    final controlItemState = controlItemStateDeterminer.determineControlState();
    final controlItemBackgroundModifier = OudsControlBackgroundModifier(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap,
      ),
      child: Container(
        color: controlItemBackgroundModifier.getBackgroundColor(controlItemState),
        constraints: BoxConstraints(
          minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMinHeight,
          minWidth: OudsTheme.of(context).componentsTokens.controlItem.sizeMinWidth,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: _isEnabled
                  ? () {
                      if (widget.onChanged != null) {
                        widget.onChanged!(!widget.value);
                      }
                    }
                  : null,
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
                padding: EdgeInsets.all(OudsTheme.of(context).componentsTokens.controlItem.spaceInset),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.inverted
                      ? [
                          /// Icon
                          if (widget.icon != null)
                            Container(
                              height: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                              width: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                              constraints: BoxConstraints(
                                maxHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMaxHeightAssetsContainer,
                              ),
                              child: widget.icon!,
                            ),
                          SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),

                          /// Text, additional text, and helper text
                          _buildTextWithAdditionalAndHelper(controlItemState),

                          SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),

                          /// Checkbox
                          AbsorbPointer(
                            child: Container(
                              height: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
                              width: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
                              constraints: BoxConstraints(
                                minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                                maxHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMaxHeightAssetsContainer,
                              ),
                              child: widget.indicator(),
                            ),
                          ),
                        ]
                      : [
                          /// Checkbox
                          AbsorbPointer(
                            child: Container(
                              height: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
                              width: OudsTheme.of(context).componentsTokens.controlItem.sizeLoader,
                              constraints: BoxConstraints(
                                minHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                                maxHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMaxHeightAssetsContainer,
                              ),
                              child: widget.indicator(),
                            ),
                          ),
                          SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),

                          /// Text, additional text, and helper text
                          _buildTextWithAdditionalAndHelper(controlItemState),

                          SizedBox(width: OudsTheme.of(context).componentsTokens.controlItem.spaceColumnGap),

                          /// Icon
                          if (widget.icon != null)
                            Container(
                              height: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                              width: OudsTheme.of(context).componentsTokens.controlItem.sizeIcon,
                              constraints: BoxConstraints(
                                maxHeight: OudsTheme.of(context).componentsTokens.controlItem.sizeMaxHeightAssetsContainer,
                              ),
                              child: widget.icon!,
                            ),
                        ],
                ),
              ),
            ),
            if (widget.divider)

              /// Divider
              Divider(
                height: 1,
                thickness: OudsTheme.of(context).borderTokens.widthDefault,
              ),
          ],
        ),
      ),
    );
  }

  /// Builds a widget that displays the main text, additional text, and helper text.
  ///
  /// This widget is wrapped in an [Expanded] widget to allow it to take up
  /// available space within a [Row] or [Column]. It styles the text based on
  /// the current control item state and handles the visibility of additional
  /// and helper texts based on their presence.
  ///
  /// The [controlItemState] parameter is used to determine the styling of
  /// the text based on the current state of the control item.
  ///
  /// Returns an [Expanded] widget containing a [Column] with the text elements.
  ///
  /// [controlItemState] must not be null.
  Widget _buildTextWithAdditionalAndHelper(controlItemState) {
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
              color: controlItemTextModifier.getTextolor(controlItemState, widget.error),
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
