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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_background_modifier.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_border_modifier.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_state.dart';
import 'package:ouds_core/components/checkbox/internal/checkbox_tick_modifier.dart';
import 'package:ouds_core/ouds_theme.dart';

/// <a href="https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox" class="external" target="_blank">OUDS Checkbox design guidelines</a>
///
/// An OUDS checkbox.
///
/// @param [value] Controls checked state of the checkbox.
/// @param [onChanged] Callback invoked on checkbox click. If `null`, then this is passive and relies entirely on a higher-level component to control
/// the checked state.
/// @param [enabled] Controls the enabled state of the checkbox. When `false`, this checkbox will not be clickable.
/// @param [error] Controls the error state of the checkbox.
///
/// @sample com.orange.ouds.core.component.samples.OudsCheckboxSample
///

class OudsCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final bool error;

  const OudsCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.error = false,
  });

  @override
  OudsCheckboxState createState() => OudsCheckboxState();
}

class OudsCheckboxState extends State<OudsCheckbox> {
  String svgChecked = '''<svg width="12" height="10" viewBox="0 0 12 10" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M11.2621 2.04661L5.22765 9.04663C5.05487 9.24679 4.78924 9.375 4.49138 9.375C4.1935 9.375 3.92806 9.24668 3.75525 9.04653L0.737872 5.54661C0.6086 5.39683 0.53125 5.20683 0.53125 5C0.53125 4.75837 0.636777 4.53964 0.807402 4.38129L1.18458 4.03129C1.3552 3.87293 1.59092 3.775 1.85129 3.775C2.08562 3.775 2.29985 3.85452 2.46476 3.98583L4.30279 5.87502L9.88099 0.861666C10.0496 0.714884 10.2764 0.625 10.5258 0.625C11.0466 0.625 11.4688 1.01676 11.4688 1.50002C11.4688 1.70681 11.3914 1.89683 11.2621 2.04661Z" fill="#F15E00"/>
</svg>''';

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Create an instance of CheckboxStateDeterminer
    final checkboxStateDeterminer = CheckboxStateDeterminer(
      enabled: widget.enabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    final checkboxState = checkboxStateDeterminer.determineCheckboxState();

    // Create an instance of CheckboxBorderModifier
    final checkboxBorderModifier = CheckboxBorderModifier(context);

    // Create an instance of CheckboxBackgroundModifier
    final checkboxBackgroundModifier = CheckboxBackgroundModifier(context);

    // Create an instance of CheckboxTickModifier
    final checkboxTickModifier = CheckboxTickModifier(context);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: OudsTheme.of(context).componentsTokens.checkbox.sizeMaxHeight,
        child: InkWell(
          onTap: widget.enabled
              ? () {
                  if (widget.onChanged != null) {
                    widget.onChanged!(!widget.value);
                  }
                }
              : null,
          splashColor: Colors.transparent, // No splash effect
          highlightColor: Colors.transparent, // No highlight effect when pressed
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
              maxHeight: OudsTheme.of(context).componentsTokens.checkbox.sizeMaxHeight,
              minHeight: OudsTheme.of(context).componentsTokens.checkbox.sizeMinHeight,
              minWidth: OudsTheme.of(context).componentsTokens.checkbox.sizeMinWidth,
            ),
            color: checkboxBackgroundModifier.getBackgroundColor(checkboxState),
            child: Center(
              child: Container(
                width: OudsTheme.of(context).componentsTokens.checkbox.sizeIndicator,
                height: OudsTheme.of(context).componentsTokens.checkbox.sizeIndicator,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: checkboxBorderModifier.getBorderColor(checkboxState, widget.error, widget.value),
                    width: checkboxBorderModifier.getBorderWidth(checkboxState, widget.value),
                  ),
                ),
                child: widget.value
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: SvgPicture.string(
                            svgChecked,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              checkboxTickModifier.getTickColor(checkboxState, widget.error),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
