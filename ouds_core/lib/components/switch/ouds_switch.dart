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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_switch_tokens.dart';

// <a href="https://unified-design-system.orange.com/" class="external" target="_blank">**OUDS Switch design guidelines**</a>
/**
 * Switches allow the user to toggle between two states, typically "on" and "off". It is represented as a slider that changes its position or color to indicate
 * the current state. Switches are used to enable or disable features, options, or settings in an intuitive and visual manner.
 *
 * The **standalone switch variant** can be used when the switch selector control is nested within another component and an alternative label is provided.
 *
 * @see [OudsSwitchItem] If you want to use a switch with an associated label and other optional elements.
 *
 * @param checked Controls checked state of the switch.
 * @param onCheckedChange Callback invoked on switch click. If `null`, then this is passive and relies entirely on a higher-level component to control
 * the checked state.
 * @param modifier [Modifier] applied to the layout of the switch.
 * @param enabled Controls the enabled state of the switch. When `false`, this switch will not be clickable.
 * @param interactionSource Optional hoisted [MutableInteractionSource] for observing and emitting [Interaction]s for this switch. Note that if `null`
 * is provided, interactions will still happen internally.
 *
 * @sample com.orange.ouds.core.component.samples.OudsSwitchSample
 */

class OudsSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final FocusNode? focusNode;

  const OudsSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<OudsSwitch> createState() => _OudsSwitchState();
}

class _OudsSwitchState extends State<OudsSwitch> with SingleTickerProviderStateMixin {
  // The name of the package where the asset is located
  String packageName = 'ouds_core';

  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final SwitchStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onChanged != null,
      isPressed: isPressed || _isPressed,
      isHovered: isHovered || _isHovered,
    );
    final switchState = SwitchStateDeterminer.determineControlState();
    final switchBorderModifier = OudsControlBorderModifier(context);
    final switchBackgroundModifier = OudsControlBackgroundModifier(context);
    final switchTickModifier = OudsControlTickModifier(context);
    final switchButton = OudsTheme.of(context).componentsTokens.switchButton;

    return Semantics(
      enabled: widget.enabled,
      toggled: widget.value,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: switchButton.sizeWidthTrack,
          height: switchButton.sizeHeightTrack,
          child: InkWell(
            onTap: () {
              bool? newValue;
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              setState(() {
                newValue = !widget.value;
              });
              widget.onChanged!(newValue!);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHover: (hovering) {
              setState(() {
                _isHovered = hovering;
              });
            },
            onHighlightChanged: (highlighted) {
              setState(() {
                _isPressed = highlighted;
              });
            },
            child: Container(
              width: switchButton.sizeWidthTrack,
              height: switchButton.sizeHeightTrack,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: widget.value ? switchButton.colorTrackSelected : switchButton.colorTrackUnselected,
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                    alignment: widget.value
                        ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight)
                        : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft),
                    child: _buildCursor(switchButton, context, switchState)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCursor(OudsSwitchTokens oudsSwitch, context, switchState) {
    final switchTickModifier = OudsControlTickModifier(context);

    return Container(
      width: oudsSwitch.sizeWidthCursorSelected,
      height: oudsSwitch.sizeHeightCursorSelected,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: oudsSwitch.sizeWidthCursorSelected,
              height: oudsSwitch.sizeHeightCursorSelected,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: widget.value ? 0 : 4,
                    child: Container(
                      width: widget.value == false ? oudsSwitch.sizeWidthCursorUnselected : oudsSwitch.sizeWidthCursorSelected,
                      height: widget.value == false ? oudsSwitch.sizeHeightCursorUnselected : oudsSwitch.sizeHeightCursorSelected,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: oudsSwitch.colorCursor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(oudsSwitch.borderRadius),
                        ),
                      ),
                      child: widget.value == true
                          ? Align(
                              alignment: _circleAnimation.value,
                              child: SizedBox(
                                child: SvgPicture.asset(
                                  AppAssets.symbols.switchChecked,
                                  package: packageName,
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    oudsSwitch.colorCheck,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          : widget.value == false
                              ? null
                              : Align(
                                  alignment: _circleAnimation.value,
                                  child: SvgPicture.asset(
                                    "",
                                    package: packageName,
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                      switchTickModifier.getTickColor(switchState, false),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
