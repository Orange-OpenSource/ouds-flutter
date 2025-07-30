import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlTextColorModifier {
  final BuildContext context;

  OudsChipControlTextColorModifier(this.context);

  /// Returns the text color based on chip state and selection
  Color? getTextColor(OudsChipTagControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    if (isSelected) {
      switch (state) {
        case OudsChipTagControlState.enabled:
          return chipToken.colorContentSelectedEnabled;
        case OudsChipTagControlState.disabled:
          return chipToken.colorContentSelectedDisabled;
        case OudsChipTagControlState.hovered:
          return chipToken.colorContentSelectedHover;
        case OudsChipTagControlState.pressed:
          return chipToken.colorContentSelectedPressed;
        case OudsChipTagControlState.focused:
          return chipToken.colorContentSelectedFocus;
      }
    } else {
      switch (state) {
        case OudsChipTagControlState.enabled:
          return chipToken.colorContentUnselectedEnabled;
        case OudsChipTagControlState.disabled:
          return chipToken.colorContentUnselectedDisabled;
        case OudsChipTagControlState.hovered:
          return chipToken.colorContentUnselectedHover;
        case OudsChipTagControlState.pressed:
          return chipToken.colorContentUnselectedPressed;
        case OudsChipTagControlState.focused:
          return chipToken.colorContentUnselectedFocus;
      }
    }
  }
}
