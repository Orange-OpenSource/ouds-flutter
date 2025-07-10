import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  Color getTextColor(OudsChipControlState state){

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
        return chipToken.colorContentSelectedEnabled;
    }
  }
}