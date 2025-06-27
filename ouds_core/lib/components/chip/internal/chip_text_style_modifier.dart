import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  Color getTextColor(OudsChipControlState state){
    switch (state) {
      case OudsChipControlState.enabled:
        return _getEnabledTextColor(context);
      case OudsChipControlState.disabled:
        return _getDisabledTextColor(context);
      case OudsChipControlState.hovered:
        return _getHoverTextColor(context);
      case OudsChipControlState.pressed:
        return _getPressedTextColor(context);
      case OudsChipControlState.focused:
        return _getFocusTextColor(context);
    }
  }

  static Color _getEnabledTextColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedEnabled;
  }

  static Color _getDisabledTextColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedDisabled;
  }
  static Color _getHoverTextColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedHover;
  }

  static Color _getPressedTextColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedPressed;
  }

  static Color _getFocusTextColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedFocus;
  }

}