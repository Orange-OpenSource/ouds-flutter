import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ouds_core/components/control/internal/controller/interaction_state_controller.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_background_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_border_modifier.dart';
import 'package:ouds_core/components/control/internal/modifier/ouds_control_tick_modifier.dart';
import 'package:ouds_core/components/control/internal/ouds_control_state.dart';
import 'package:ouds_core/ouds_theme.dart';

/// <a href="https://unified-design-system.orange.com/472794e18/p/23f1c1-checkbox" class="external" target="_blank">OUDS Checkbox design guidelines</a>
///
/// A public OUDS checkbox widget.
///
/// Use it in your UI by providing a `value`, an `onChanged` callback, and optionally an `error` state.
///
/// @param [value] Controls checked state of the checkbox.
/// @param [onChanged] Callback invoked on checkbox click. If `null`, checkbox is passive.
/// @param [error] Controls the error state.
/// @param [onExternalHighlightChanged] (internal use) Callback to notify parent about press/highlight state.
class OudsCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool error;

  const OudsCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.error = false,
  });

  @override
  State<OudsCheckbox> createState() => _OudsCheckboxState();
}

class _OudsCheckboxState extends State<OudsCheckbox> {
  final String svgChecked = '''<svg width="12" height="10" viewBox="0 0 12 10" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M11.2621 2.04661L5.22765 9.04663C5.05487 9.24679 4.78924 9.375 4.49138 9.375C4.1935 9.375 3.92806 9.24668 3.75525 9.04653L0.737872 5.54661C0.6086 5.39683 0.53125 5.20683 0.53125 5C0.53125 4.75837 0.636777 4.53964 0.807402 4.38129L1.18458 4.03129C1.3552 3.87293 1.59092 3.775 1.85129 3.775C2.08562 3.775 2.29985 3.85452 2.46476 3.98583L4.30279 5.87502L9.88099 0.861666C10.0496 0.714884 10.2764 0.625 10.5258 0.625C11.0466 0.625 11.4688 1.01676 11.4688 1.50002C11.4688 1.70681 11.3914 1.89683 11.2621 2.04661Z" fill="#F15E00"/>
</svg>''';

  bool get _isEnabled => widget.onChanged != null;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Get controller GetX states
    final interactionController = Get.isRegistered<InteractionStateController>() ? Get.find<InteractionStateController>() : Get.put(InteractionStateController());

    final checkboxStateDeterminer = OudsControlStateDeterminer(
      enabled: _isEnabled,
      isPressed: interactionController.isPressed.value || _isPressed,
      isHovered: interactionController.isHovered.value || _isHovered,
    );

    final checkboxState = checkboxStateDeterminer.determineControlState();
    final checkboxBorderModifier = OudsControlBorderModifier(context);
    final checkboxBackgroundModifier = OudsControlBackgroundModifier(context);
    final checkboxTickModifier = OudsControlTickModifier(context);
    final checkbox = OudsTheme.of(context).componentsTokens.checkbox;

    return SizedBox(
      width: checkbox.sizeMaxHeight,
      child: InkWell(
        onTap: _isEnabled ? () => widget.onChanged?.call(!widget.value) : null,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onHover: (hovering) {
          setState(() {
            _isHovered = hovering;
          });
        },
        onHighlightChanged: (isPressed) {
          setState(() {
            _isPressed = isPressed;
          });
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: checkbox.sizeMaxHeight,
            minHeight: checkbox.sizeMinHeight,
            minWidth: checkbox.sizeMinWidth,
          ),

          /// WARNING
          color: !interactionController.isPressed.value ? checkboxBackgroundModifier.getBackgroundColor(checkboxState) : Colors.transparent,
          child: Center(
            child: Container(
              width: checkbox.sizeIndicator,
              height: checkbox.sizeIndicator,
              decoration: BoxDecoration(
                border: Border.all(
                  color: checkboxBorderModifier.getBorderColor(checkboxState, widget.error, widget.value),
                  width: checkboxBorderModifier.getBorderWidth(checkboxState, widget.value, checkbox),
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
    );
  }
}
