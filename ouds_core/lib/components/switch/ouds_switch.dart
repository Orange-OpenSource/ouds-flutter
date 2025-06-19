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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_switch_tokens.dart';

///
/// [OUDS Switch Design Guidelines](https://unified-design-system.orange.com/472794e18/p/18acc0-switch)
///
/// Switches allow the user to toggle between two states, typically "on" and "off". It is represented as a slider that changes its position or color to indicate
/// the current state. Switches are used to enable or disable features, options, or settings in an intuitive and visual manner.
///
/// The **standalone switch variant** can be used when the switch selector control is nested within another component and an alternative label is provided.
///
/// This widget displays a switch that is part of a group. It determines its selected state
/// by comparing its own [value] with the current [groupValue]. It also supports an error state
/// and notifies changes through [onChanged].
///
///  Parameters:
///  [value] The value represented by this switch . Used to determine selection.
///  [onChanged] Callback triggered when the user selects this switch.
/// If `null`, switch is disabled and non-interactive.
///
/// ## You can use [OudsSwitch] like this :
///
/// ```dart
///  OudsSwitch(
///     value: true,
///     onChanged: (newValue) {
///           // Handle switch change state.
///       }
///   );
/// ```
///

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

class _OudsSwitchState extends State<OudsSwitch> {
  String packageName = 'ouds_core';
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final interactionModelFocused = OudsInheritedInteractionModel.of(context, InteractionAspect.focused);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final isFocused = interactionModelFocused?.state.isFocused ?? false;

    final switchStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onChanged != null,
      isPressed: isPressed || _isPressed,
      isHovered: isHovered || _isHovered,
      isFocused: isFocused || _isFocused,
    );
    final switchState = switchStateDeterminer.determineControlState();
    final switchBackgroundModifier = OudsControlBackgroundModifier(context);
    final switchTickModifier = OudsControlTickModifier(context);
    final switchButton = OudsTheme.of(context).componentsTokens(context).switchButton;

    return Semantics(
      enabled: widget.onChanged != null,
      toggled: widget.value,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: switchButton.sizeMinWidth,
          height: switchButton.sizeMinHeight,
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
              width: switchButton.sizeWidthTrack,
              height: switchButton.sizeHeightTrack,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(switchButton.borderRadius),
                color: widget.value ? switchTickModifier.getTickSwitchColor(switchState) : switchButton.colorTrackUnselected,
              ),
              child: _buildCursorIndicator(context, switchState, isPressed, isHovered),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCursorIndicator(BuildContext context, OudsControlState switchState, bool isPressed, bool isHovered) {
    final switchButton = OudsTheme.of(context).componentsTokens(context).switchButton;
    const animationDuration = Duration(milliseconds: 220);

    return GestureDetector(
      /// 1 - Organiser un point pour s'assurer l'usage de ces Gesture (ligne 138 à 144)
      onTapDown: widget.onChanged != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onChanged != null ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.onChanged != null ? () => setState(() => _isPressed = false) : null,
      onHorizontalDragStart: widget.onChanged != null ? (_) => setState(() => _isHovered = true) : null,
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
        duration: animationDuration,
        width: switchButton.sizeWidthTrack,
        height: switchButton.sizeHeightTrack,
        padding: widget.value ? EdgeInsets.all(switchButton.spacePaddingInlineSelected) : EdgeInsets.all(switchButton.spacePaddingInlineUnselected),
        child: AnimatedAlign(
          duration: animationDuration,
          curve: Curves.easeInOut,
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeInOut,
            width: _getCursorSize(switchButton, isPressed, isHovered).width,
            height: _getCursorSize(switchButton, isPressed, isHovered).height,
            decoration: BoxDecoration(
              color: switchButton.colorCursor,
              borderRadius: BorderRadius.circular(switchButton.borderRadius),
            ),
            child: widget.value && !isPressed && !_isPressed
                ? Align(
                    child: Opacity(
                      opacity: switchButton.opacityCheck,
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
                : null,
          ),
        ),
      ),
    );
  }

  Size _getCursorSize(OudsSwitchTokens switchButton, bool isPressed, bool isHover) {
    /// 3 - J'ai récupéré l'état "isPressed" et "isHover" qui correspond à l'état du parent (Control Item)
    /// La variable privée "_isPressed" et "_isHover" correspondent à l'enfant (Switch Seul)
    ///
    /// Le parent "Control Item" envoie l'information à son enfant "Switch" pour detecter l'état
    ///
    /// 4 - J'ai aussi ajouté l'état Hover :
    /// Test: sur Chrome Web
    /// A vérifier si avec l'état Hover il faut effectuer une animation : ça me parait étrange
    final isActive = _isPressed || isPressed;

    final double width = widget.value
        ? (isActive ? switchButton.sizeWidthCursorSelectedPressed : switchButton.sizeWidthCursorSelected)
        : (isActive ? switchButton.sizeWidthCursorUnselectedPressed : switchButton.sizeWidthCursorUnselected);

    final double height = widget.value ? switchButton.sizeHeightCursorSelected : switchButton.sizeHeightCursorUnselected;

    return Size(width, height);
  }

  Color _getCheckColor(OudsSwitchTokens switchButton) {
    final colorsScheme = OudsTheme.of(context).colorScheme(context);
    return widget.onChanged != null ? switchButton.colorCheck : colorsScheme.actionDisabled;
  }
}
