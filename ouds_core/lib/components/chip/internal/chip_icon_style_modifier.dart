import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  Color getIconColor(OudsChipControlState state){

    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsChipControlState.enabled:
        return chipToken.colorContentUnselectedEnabled;
      case OudsChipControlState.disabled:
        return chipToken.colorContentUnselectedDisabled;
      case OudsChipControlState.hovered:
        return chipToken.colorContentUnselectedHover;
      case OudsChipControlState.pressed:
        return chipToken.colorContentUnselectedPressed;
      case OudsChipControlState.focused:
        return chipToken.colorContentUnselectedFocus;
      case OudsChipControlState.selected:
        return chipToken.colorContentUnselectedEnabled;
    }
  }

  Color getTickColor(OudsChipControlState state){

    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsChipControlState.enabled:
        return chipToken.colorContentSelectedTickEnabled;
      case OudsChipControlState.disabled:
        return chipToken.colorContentSelectedDisabled;
      case OudsChipControlState.hovered:
        return chipToken.colorContentSelectedHover;
      case OudsChipControlState.pressed:
        return chipToken.colorContentSelectedPressed;
      case OudsChipControlState.focused:
        return chipToken.colorContentSelectedFocus;
      case OudsChipControlState.selected:
        return chipToken.colorContentSelectedTickEnabled;
    }
  }

}