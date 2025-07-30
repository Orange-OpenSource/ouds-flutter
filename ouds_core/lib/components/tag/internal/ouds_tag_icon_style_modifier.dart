import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/chip/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagInputControlIconColorModifier {
  final BuildContext context;

  OudsTagInputControlIconColorModifier(this.context);

  /// Returns the icon color based on tag input state
  Color? getIconColor(OudsChipTagControlState state) {
    //todo to change when updating the tokenator
    final tagToken = OudsTheme.of(context).componentsTokens(context).chip;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsChipTagControlState.enabled:
        return tagToken.colorContentUnselectedEnabled;
      case OudsChipTagControlState.disabled:
        return tagToken.colorContentUnselectedDisabled;
      case OudsChipTagControlState.hovered:
        return tagToken.colorContentUnselectedHover;
      case OudsChipTagControlState.pressed:
        return tagToken.colorContentUnselectedPressed;
      case OudsChipTagControlState.focused:
        return tagToken.colorContentUnselectedFocus;
    }
  }
}
