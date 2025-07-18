import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  /// Returns the text color based on chip state and selection
  Color? getTextColor(OudsChipControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    if (isSelected) {
      switch (state) {
        case OudsChipControlState.enabled:
          return chipToken.colorContentSelectedEnabled;
        case OudsChipControlState.disabled:
          return chipToken.colorContentSelectedDisabled;
        case OudsChipControlState.hovered:
          return chipToken.colorContentSelectedHover;
        case OudsChipControlState.pressed:
          return chipToken.colorContentSelectedPressed;
        case OudsChipControlState.focused:
          return chipToken.colorContentSelectedFocus;
      }
    } else {
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
      }
    }
  }
}
