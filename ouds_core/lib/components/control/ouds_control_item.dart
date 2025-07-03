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

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/controller/ouds_interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_text_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

enum OudsControlItemType {
  switchButton,
  checkbox,
  radio,
}

/// Refactor of controls for [Checkbox], [Switch], and [RadioButton].
/// This implementation provides a customizable control item with properties such as text, icon, and interaction states.
/// It manages its own interaction state and can respond to tap events if not in read-only mode.
class OudsControlItem extends StatefulWidget {
  final String text;
  final String? helperText;
  final String? icon;
  final bool divider;
  final bool outlined;
  final bool selected;
  final bool reversed;
  final bool readOnly;
  final bool error;
  final String errorComponentName;
  final OudsControlItemType componentType;
  final Widget Function() indicator;
  final String? additionalText;

  final VoidCallback? onTap;

  const OudsControlItem({
    super.key,
    required this.text,
    required this.errorComponentName,
    required this.componentType,
    required this.indicator,
    this.helperText,
    this.icon,
    this.divider = false,
    this.outlined = false,
    this.selected = false,
    this.reversed = true,
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
    final controlBorderModifier = OudsControlBorderModifier(context);

    return OudsInheritedInteractionModel(
      state: interactionState,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: OudsTheme.of(context).componentsTokens(context).controlItem.spaceInset,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: controlItemBackgroundModifier.getBackgroundColor(controlItemState),
                    borderRadius: BorderRadius.circular(
                      OudsTheme.of(context).borderTokens.radiusNone,
                    ),
                  ),
                  constraints: BoxConstraints(
                    minHeight: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMinHeight,
                    minWidth: OudsTheme.of(context).componentsTokens(context).controlItem.sizeMinWidth,
                  ),
                  child: InkWell(
                    onTap: !widget.readOnly
                        ? () {
                            interactionState.setPressed(true);
                            // Added to improve visual rendering fluidity by allowing Flutter
                            // to complete the current frame before executing the state change logic.
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              widget.onTap?.call();
                              interactionState.setPressed(false);
                            });
                          }
                        : null,
                    onHighlightChanged: widget.onTap != null ? interactionState.setPressed : null,
                    onHover: interactionState.setHovered,
                    highlightColor: Colors.transparent,
                    hoverColor: OudsTheme.of(context).componentsTokens(context).controlItem.colorBgHover,
                    splashColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(
                        OudsTheme.of(context).componentsTokens(context).controlItem.spaceInset,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: _isLongText() ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                          children: widget.reversed ? _buildStandardLayout(controlItemState) : _buildInvertedLayout(controlItemState),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.divider,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: OudsDivider.horizontal(
                    color: OudsDividerColor.defaultColor,
                  ),
                ),
              ],
            ),
            if (widget.outlined || (widget.selected && interactionState.isPressed))
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controlBorderModifier.getBorderColor(
                          controlItemState,
                          widget.error,
                          widget.selected,
                        ),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        OudsTheme.of(context).borderTokens.radiusNone,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _isLongText() {
    return (widget.text.length > 150) || ((widget.additionalText?.length ?? 0) > 0) || ((widget.helperText?.length ?? 0) > 0);
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
              height: widget.componentType != OudsControlItemType.switchButton ? OudsTheme.of(context).componentsTokens(context).controlItem.sizeLoader : OudsTheme.of(context).componentsTokens(context).switchButton.sizeHeightTrack,
              width: widget.componentType != OudsControlItemType.switchButton ? OudsTheme.of(context).componentsTokens(context).controlItem.sizeLoader : null,
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
              height: widget.componentType != OudsControlItemType.switchButton ? OudsTheme.of(context).componentsTokens(context).controlItem.sizeLoader : OudsTheme.of(context).componentsTokens(context).switchButton.sizeHeightTrack,
              width: widget.componentType != OudsControlItemType.switchButton ? OudsTheme.of(context).componentsTokens(context).controlItem.sizeLoader : null,
              child: widget.indicator(),
            ),
          ),
        ),
      ];

  Widget _buildTextWithAdditionalAndHelper(OudsControlState controlItemState) {
    final controlItemTextModifier = OudsControlTextModifier(context);
    final hasAdditionalText = widget.additionalText?.trim().isNotEmpty ?? false;
    final hasHelperText = widget.helperText?.trim().isNotEmpty ?? false;

    final List<Widget> columnChildren = [
      Text(
        widget.text,
        style: OudsTheme.of(context).typographyTokens.typeLabelDefaultLarge(context).copyWith(
              color: controlItemTextModifier.getTextColor(controlItemState, widget.error),
            ),
      ),
    ];
    if (hasAdditionalText) {
      columnChildren.add(SizedBox(height: OudsTheme.of(context).componentsTokens(context).controlItem.spaceRowGap));
      columnChildren.add(
        Text(
          widget.additionalText!,
          style: OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                color: controlItemTextModifier.getAdditionalTextColor(controlItemState),
              ),
        ),
      );
    }

    if (hasHelperText) {
      columnChildren.add(SizedBox(height: OudsTheme.of(context).componentsTokens(context).controlItem.spaceRowGap));
      columnChildren.add(
        Text(
          widget.helperText!,
          style: OudsTheme.of(context).typographyTokens.typeLabelDefaultMedium(context).copyWith(
                color: controlItemTextModifier.getHelperTextColor(controlItemState),
              ),
        ),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // prevents taking full height
        children: columnChildren,
      ),
    );
  }
}
