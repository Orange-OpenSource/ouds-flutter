import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsChipControlIconColorModifier {
  final BuildContext context;

  OudsChipControlIconColorModifier(this.context);

  /// Returns the icon color based on chip state and selection
  Color getIconColor(OudsChipControlState state, [bool isSelected = false]) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsChipControlState.enabled:
        return isSelected ? chipToken.colorContentSelectedEnabled : chipToken.colorContentUnselectedEnabled;
      case OudsChipControlState.disabled:
        return isSelected ? chipToken.colorContentSelectedDisabled : chipToken.colorContentUnselectedDisabled;
      case OudsChipControlState.hovered:
        return isSelected ? chipToken.colorContentSelectedHover : chipToken.colorContentUnselectedHover;
      case OudsChipControlState.pressed:
        return isSelected ? chipToken.colorContentSelectedPressed : chipToken.colorContentUnselectedPressed;
      case OudsChipControlState.focused:
        return isSelected ? chipToken.colorContentSelectedFocus : chipToken.colorContentUnselectedFocus;
    }
  }

  /// Returns the tick color (always used when selected)
  Color getTickColor(OudsChipControlState state) {
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
    }
  }
}
