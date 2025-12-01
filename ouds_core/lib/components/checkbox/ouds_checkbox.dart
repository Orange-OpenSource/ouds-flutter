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

/// {@category Checkbox}
library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
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

enum ToggleableState { off, indeterminate, on }

///
/// [OUDS Checkbox design guidelines](https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox)
///
/// **Reference design version : 2.4.0**
///
/// Checkboxes are input controls that allow users to select one or more options from a number of choices.
///
/// This checkbox supports the indeterminate state: Checkboxes can have a parent-child relationship with other checkboxes. When the parent checkbox is checked,
/// all child checkboxes are checked. If a parent checkbox is unchecked, all child checkboxes are unchecked. If some, but not all, child checkboxes are checked,
/// the parent checkbox becomes an indeterminate checkbox.
///
/// The following parameters are available:
///
/// - [value]: Controls checked state of the checkbox.
/// - [onChanged]: Callback invoked on checkbox click. If `null`, then this is passive and relies entirely on a higher-level component to control
///   the checked state.
/// - [tristate]: If true, the checkboxes value can be true, false, or null. If false, only true and false states are managed.
/// - [isError]: Controls the error state of the checkbox.
///
/// ### You can use [OudsCheckbox] component in your project, customizing parameters as needed :
///
/// **Enabled checkbox sample :**
///
/// The status of the checkbox before a user has interacted with it, or other content affects it.
///
///
/// ```dart
/// OudsCheckbox(
///   value: isChecked,
///   onChanged: (bool? newValue) {
///      setState(() {
///         isCheckedFirst = newValue;
///       });
///     },
///   isError: false,
/// );
/// ```
///
class OudsCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool isError;
  final bool tristate;

  const OudsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isError = false,
    this.tristate = false,
  });

  @override
  State<OudsCheckbox> createState() => _OudsCheckboxState();
}

class _OudsCheckboxState extends State<OudsCheckbox> {
  bool _isHovered = false;
  bool _isPressed = false;
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
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final checkboxStateDeterminer = OudsControlStateDeterminer(
      enabled: widget.onChanged != null,
      isPressed: isPressed || _isPressed,
      isHovered: isHovered || _isHovered,
    );

    final checkboxState = checkboxStateDeterminer.determineControlState();
    final checkboxBorderModifier = OudsControlBorderModifier(context);
    final checkboxBackgroundModifier = OudsControlBackgroundModifier(context);
    final checkboxTickModifier = OudsControlTickModifier(context);
    final checkbox = OudsTheme.of(context).componentsTokens(context).checkbox;
    final l10n = OudsLocalizations.of(context);

    String? semanticsLabel = widget.value == true
        ? l10n?.core_checkbox_checked_a11y
        : widget.value == null
            ? l10n?.core_checkbox_indeterminate_a11y
            : l10n?.core_checkbox_not_checked_a11y;

    // add “double tap to toggle” only for iOS
    if (Platform.isIOS && semanticsLabel != null) {
      semanticsLabel = '$semanticsLabel${widget.value == false && widget.onChanged != null ? ', ${l10n?.core_checkbox_action_a11y}' : ''}';
    }

    return Semantics(
      enabled: widget.onChanged != null,
      value: semanticsLabel,
      label: widget.tristate == true ? l10n?.core_checkbox_indeterminateCheckbox_a11y : l10n?.core_checkbox_checkbox_a11y,
      hint: widget.isError ? l10n?.core_common_onError_a11y : null,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: checkbox.sizeMaxHeight,
          child: InkWell(
            onTap: widget.onChanged != null
                ? () {
                    _isPressed = true;
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      bool? newValue;
                      if (widget.tristate) {
                        if (widget.value == true) {
                          newValue = null;
                        } else if (widget.value == null) {
                          newValue = false;
                        } else {
                          newValue = true;
                        }
                      } else {
                        newValue = !widget.value!;
                      }

                      widget.onChanged!(newValue);
                      _isPressed = false;
                    });
                  }
                : null,
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
              constraints: BoxConstraints(
                maxHeight: checkbox.sizeMaxHeight,
                minHeight: checkbox.sizeMinHeight,
                minWidth: checkbox.sizeMinWidth,
              ),
              decoration: BoxDecoration(
                color: _isPressed ? checkboxBackgroundModifier.getBackgroundColor(checkboxState) : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  checkboxBorderModifier.getBorderRadius(checkbox),
                ),
              ),
              child: Center(
                child: ExcludeSemantics(
                  child: SizedBox(
                    width: checkbox.sizeIndicator,
                    height: checkbox.sizeIndicator,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        checkboxBorderModifier.getBorderRadius(checkbox),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: OudsBorder().borderAll(
                                color: checkboxBorderModifier.getBorderColor(
                                  checkboxState,
                                  widget.isError,
                                  isCheckedOrIndeterminate(widget.value),
                                  _isHighContrast
                                ),
                                width: checkboxBorderModifier.getBorderWidth(
                                  checkboxState,
                                  isCheckedOrIndeterminate(widget.value),
                                  checkbox,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                checkboxBorderModifier.getBorderRadius(checkbox),
                              ),
                            ),
                          ),
                          if (widget.value == true)
                            Center(
                              child: SvgPicture.asset(
                                excludeFromSemantics: true,
                                AppAssets.icons.componentCheckboxSelected,
                                package: OudsTheme.of(context).packageName,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  checkboxTickModifier.getTickColor(checkboxState, widget.isError, _isHighContrast),
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          else if (widget.value == null)
                            Center(
                              child: SvgPicture.asset(
                                excludeFromSemantics: true,
                                AppAssets.icons.componentCheckboxUndetermined,
                                package: OudsTheme.of(context).packageName,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  checkboxTickModifier.getTickColor(checkboxState, widget.isError, _isHighContrast),
                                  BlendMode.srcIn,
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
          ),
        ),
      ),
    );
  }

  bool isCheckedOrIndeterminate(bool? value) {
    return value == true || value == null; // Only check for true state
  }
}
