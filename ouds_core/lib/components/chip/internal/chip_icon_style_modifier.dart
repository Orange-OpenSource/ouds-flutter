import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  Color getIconColor(OudsChipControlState state){
    switch (state) {
      case OudsChipControlState.enabled:
        return _getEnabledIconColor(context);
      case OudsChipControlState.disabled:
        return _getDisabledIconColor(context);
      case OudsChipControlState.hovered:
        return _getHoverIconColor(context);
      case OudsChipControlState.pressed:
        return _getPressedIconColor(context);
      case OudsChipControlState.focused:
        return _getFocusIconColor(context);
    }
  }

  static Color _getEnabledIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentEnabled;
  }

  static Color _getDisabledIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentDisabled;
  }
  static Color _getHoverIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentHover;
  }

  static Color _getPressedIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentPressed;
  }

  static Color _getFocusIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentFocus;
  }

}