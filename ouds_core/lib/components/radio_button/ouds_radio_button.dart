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

/// {@category Radio button}
library;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_accessibility_plugin/ouds_accessibility_plugin.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///
/// [OUDS Radio Button Design Guidelines](https://r.orange.fr/r/S-ouds-doc-radio-button)
///
/// **Reference design version : 1.4.0**
///
/// Radio button is a UI element that allows to select a single option from a set of mutually exclusive choices. Radio button that does not show icon or text,
/// provides greater flexibility when creating other components that require a Radio button to be displayed.
///
/// This widget displays a radio button that is part of a group. It determines its selected state
/// by comparing its own [value] with the current [groupValue]. It also supports an error state
/// and notifies changes through [onChanged].
///
///  Parameters:
///  [value] The value represented by this radio button. Used to determine selection.
///  [groupValue] The currently selected value in the radio button group.
/// This radio button is considered selected if [value] == [groupValue].
///  [onChanged] Callback triggered when the user selects this radio button.
/// If `null`, the radio button is disabled and non-interactive.
///  [isError] Indicates whether the radio button is in an error state.
///
/// ### You can use [OudsRadioButton] component in your project, customizing parameters as needed :
///
/// **Selection status :**
///
/// Typically, a radio button has two main states: Selected and Unselected.
///
///  'selected' : The radio button is actively chosen by the user, indicating the associated option is selected.
///  'unselected' : The radio button is not chosen, showing the user that the associated option is available but not selected.
///
///
///
/// ```dart
///  OudsRadioButton<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///        // Handle radio button change state.
///    }
///    isError: false,
///    readOnly: false,
/// );
/// ```
///

class OudsRadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final bool isError;
  final bool readOnly;

  const OudsRadioButton({super.key, required this.value, required this.groupValue, required this.onChanged, this.isError = false, this.readOnly = false});

  @override
  OudsRadioButtonState<T> createState() => OudsRadioButtonState<T>();
}

class OudsRadioButtonState<T> extends State<OudsRadioButton<T>> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool get _selected => widget.value == widget.groupValue;
  bool _isHighContrast = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    OudsAccessibilityPlugin.isHighContrastEnabled(context).then((value) {
      setState(() {
        _isHighContrast = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHoveredInherited = interactionModelHover?.state.isHovered ?? false;
    final isPressedInherited = interactionModelPressed?.state.isPressed ?? false;
    final isEnabled = widget.onChanged != null;
    final bool isReadOnly = widget.readOnly;

    final radioButtonStateDeterminer = OudsControlStateDeterminer(
      enabled: isEnabled || isReadOnly,
      isPressed: (!isReadOnly) && (isPressedInherited || _isPressed),
      isHovered: (!isReadOnly) && (isHoveredInherited || _isHovered),
      isReadOnly: isReadOnly,
    );

    final radioButtonState = radioButtonStateDeterminer.determineControlState();
    final radioButtonBorderModifier = OudsControlBorderModifier(context);
    final radioButtonBackgroundModifier = OudsControlBackgroundModifier(context);
    final radioButtonTickModifier = OudsControlTickModifier(context);
    final radioButton = OudsTheme.of(context).componentsTokens(context).radioButton;
    final controlItem = OudsTheme.of(context).componentsTokens(context).controlItem;
    final l10n = OudsLocalizations.of(context);

    return Semantics(
      enabled: widget.onChanged != null && !(widget.readOnly),
      label:
          "${_selected ? l10n?.core_common_selected_a11y : l10n?.core_common_unselected_a11y} "
          "${l10n?.core_radioButton_radioButton_a11y}",
      value: widget.isError ? l10n?.core_common_error_a11y : null,
      child: SizedBox(
        width: radioButton.sizeMinWidth,
        child: InkWell(
          onTap: (!isReadOnly && widget.onChanged != null)
              ? () {
                  _isPressed = true;
                  // Added to improve visual rendering fluidity by allowing Flutter
                  // to complete the current frame before executing the onChanged callback.
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    widget.onChanged!(widget.value);
                    _isPressed = false;
                  });
                }
              : null,
          splashColor: Colors.transparent,
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
            constraints: BoxConstraints(maxHeight: radioButton.sizeMaxHeight, minHeight: radioButton.sizeMinHeight, minWidth: radioButton.sizeMinWidth),
            decoration: BoxDecoration(
              color: _isPressed ? radioButtonBackgroundModifier.getBackgroundColor(radioButtonState) : Colors.transparent,
              borderRadius: BorderRadius.circular(radioButtonBorderModifier.getBorderRadius(controlItem.borderRadiusDefault)),
            ),
            child: Center(
              child: SizedBox(
                width: controlItem.sizeControlIndicator,
                height: controlItem.sizeControlIndicator,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // --- Decorated back-end : border, radius, etc.
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: OudsBorder().borderAll(
                          color: radioButtonBorderModifier.getBorderColor(radioButtonState, widget.isError, _selected, _isHighContrast),
                          width: radioButtonBorderModifier.getBorderWidth(radioButtonState, _selected, radioButton),
                        ),
                        borderRadius: BorderRadius.circular(radioButtonBorderModifier.getBorderRadius(radioButton.borderRadius)),
                      ),
                    ),

                    // --- Tick selected
                    if (_selected)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radioButton.borderRadius),
                          child: SvgPicture.asset(
                            AppAssets.icons.componentRadioButtonSelected,
                            excludeFromSemantics: true,
                            package: OudsTheme.of(context).packageName,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(radioButtonTickModifier.getTickColor(radioButtonState, widget.isError, _isHighContrast), BlendMode.srcIn),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateValue(T value) {
    widget.onChanged!(value);
  }
}
