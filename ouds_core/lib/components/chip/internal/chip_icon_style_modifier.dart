import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  /// Returns the icon color based on chip state and selection
  Color getIconColor(OudsChipTagControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsChipTagControlState.enabled:
        return isSelected ? chipToken.colorContentSelectedEnabled : chipToken.colorContentUnselectedEnabled;
      case OudsChipTagControlState.disabled:
        return isSelected ? chipToken.colorContentSelectedDisabled : chipToken.colorContentUnselectedDisabled;
      case OudsChipTagControlState.hovered:
        return isSelected ? chipToken.colorContentSelectedHover : chipToken.colorContentUnselectedHover;
      case OudsChipTagControlState.pressed:
        return isSelected ? chipToken.colorContentSelectedPressed : chipToken.colorContentUnselectedPressed;
      case OudsChipTagControlState.focused:
        return isSelected ? chipToken.colorContentSelectedFocus : chipToken.colorContentUnselectedFocus;
    }
  }

  /// Returns the tick color (always used when selected)
  Color getTickColor(OudsChipTagControlState state) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    switch (state) {
      case OudsChipTagControlState.enabled:
        return chipToken.colorContentSelectedTickEnabled;
      case OudsChipTagControlState.disabled:
        return chipToken.colorContentSelectedDisabled;
      case OudsChipTagControlState.hovered:
        return chipToken.colorContentSelectedHover;
      case OudsChipTagControlState.pressed:
        return chipToken.colorContentSelectedPressed;
      case OudsChipTagControlState.focused:
        return chipToken.colorContentSelectedFocus;
    }
  }
}
