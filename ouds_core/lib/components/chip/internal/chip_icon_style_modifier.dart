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
      case OudsChipControlState.selected:
        return _getSelectedIconColor(context);
    }
  }

  static Color _getEnabledIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedEnabled;
  }

  static Color _getDisabledIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedDisabled;
  }
  static Color _getHoverIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedHover;
  }

  static Color _getPressedIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedPressed;
  }

  static Color _getFocusIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedFocus;
  }

  static Color _getSelectedIconColor(BuildContext context) {
    return OudsTheme
        .of(context)
        .componentsTokens(context)
        .chip.colorContentUnselectedEnabled;
  }


  //todo
  Color getTickColor(OudsChipControlState state){
    switch (state) {
      case OudsChipControlState.enabled:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedTickEnabled;
      case OudsChipControlState.disabled:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedDisabled;
      case OudsChipControlState.hovered:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedHover;
      case OudsChipControlState.pressed:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedPressed;
      case OudsChipControlState.focused:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedFocus;
      case OudsChipControlState.selected:
        return OudsTheme.of(context).componentsTokens(context).chip.colorContentSelectedTickEnabled;
    }
  }

}