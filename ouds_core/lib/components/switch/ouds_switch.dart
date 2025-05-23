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

  const OudsSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  State<OudsSwitch> createState() => _OudsSwitchState();
}

class _OudsSwitchState extends State<OudsSwitch> with SingleTickerProviderStateMixin {
  // The name of the package where the asset is located
  String packageName = 'ouds_core';
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final interactionModelFocused = OudsInheritedInteractionModel.of(context, InteractionAspect.focused);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final isFocused = interactionModelPressed?.state.isFocused ?? false;

    final switchStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onChanged != null,
      isPressed: isPressed || isHovered || isFocused || _isPressed,
      isHovered: isHovered || isPressed || isFocused || _isHovered,
      isFocused: isFocused || isPressed || isHovered || _isFocused,
    );
    final switchState = switchStateDeterminer.determineControlState();
    final switchBackgroundModifier = OudsControlBackgroundModifier(context);
    final switchTickModifier = OudsControlTickModifier(context);
    final switchButton = OudsTheme.of(context).componentsTokens.switchButton;

    return Semantics(
      enabled: widget.onChanged != null,
      toggled: widget.value,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: switchButton.sizeWidthTrack,
          height: switchButton.sizeHeightTrack,
          child: InkWell(
            onTap: widget.onChanged != null
                ? () {
                    bool? newValue;
                    setState(() {
                      newValue = !widget.value;
                    });
                    widget.onChanged!(newValue!);
                  }
                : null,
            splashColor: switchBackgroundModifier.getBackgroundColor(switchState),
            highlightColor: switchBackgroundModifier.getBackgroundColor(switchState),
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
            onFocusChange: (focused) {
              setState(() {
                _isFocused = focused;
              });
            },
            child: Container(
                width: switchButton.sizeMinWidth,
                height: switchButton.sizeMinHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(switchButton.borderRadius),
                  color: widget.value == true ? switchTickModifier.getTickSwitchColor(switchState) : switchButton.colorTrackUnselected,
                ),
                child: _buildCursorIndicator(context, switchState)),
          ),
        ),
      ),
    );
  }

  Widget _buildCursorIndicator(BuildContext context, OudsControlState switchState) {
    final switchButton = OudsTheme.of(context).componentsTokens.switchButton;

    /*void _handleDragUpdate(DragUpdateDetails details) {
      if (details.delta.dx > 5 && !widget.value) {
        setState(() => widget.onChanged!(true));
      } else if (details.delta.dx < -5 && widget.value) {
        setState(() => widget.onChanged!(false));
      }
    }*/

    return GestureDetector(
      onTapDown: widget.onChanged != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onChanged != null ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.onChanged != null ? () => setState(() => _isPressed = false) : null,
      onHorizontalDragStart: widget.onChanged != null ? (_) => setState(() => _isHovered = true) : null,
      //onHorizontalDragUpdate: widget.enabled ? _handleDragUpdate : null,
      onHorizontalDragEnd: widget.onChanged != null ? (_) => setState(() => _isHovered = false) : null,
      onHorizontalDragCancel: widget.onChanged != null ? () => setState(() => _isHovered = false) : null,
      onTap: widget.onChanged != null
          ? () {
              bool? newValue;
              setState(() {
                newValue = !widget.value;
              });
              widget.onChanged!(newValue!);
            }
          : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: switchButton.sizeWidthTrack,
        height: switchButton.sizeHeightTrack,
        padding: widget.value ? EdgeInsets.all(switchButton.spacePaddingInlineSelected) : EdgeInsets.all(switchButton.spacePaddingInlineUnselected),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: _getCursorSize(switchButton).width,
            height: _getCursorSize(switchButton).height,
            decoration: BoxDecoration(
              color: switchButton.colorCursor,
              borderRadius: BorderRadius.circular(switchButton.borderRadius),
            ),
            child: widget.value == true
                ? !_isHovered
                    ? Align(
                        child: SizedBox(
                          child: SvgPicture.asset(
                            AppAssets.symbols.switchChecked,
                            package: packageName,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              _getCheckColor(switchButton),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : null
                : null,
          ),
        ),
      ),
    );
  }

  /// return the size of Cursor when is selected and unselected
  Size _getCursorSize(OudsSwitchTokens switchButton) {
    final isActive = _isPressed || _isHovered;

    final double width = widget.value
        ? (isActive ? switchButton.sizeWidthCursorSelectedPressed : switchButton.sizeWidthCursorSelected)
        : (isActive ? switchButton.sizeWidthCursorUnselectedPressed : switchButton.sizeWidthCursorUnselected);

    final double height = widget.value ? switchButton.sizeHeightCursorSelected : switchButton.sizeHeightCursorUnselected;

    return Size(width, height);
  }

  Color _getCheckColor(OudsSwitchTokens switchButton) {
    final colorsScheme = OudsTheme.of(context).colorsScheme;
    return widget.onChanged != null ? switchButton.colorCheck : colorsScheme.actionDisabled;
  }
}
