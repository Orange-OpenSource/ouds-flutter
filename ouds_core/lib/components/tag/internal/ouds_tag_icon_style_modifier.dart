import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagInputControlIconColorModifier {
  final BuildContext context;

  OudsTagInputControlIconColorModifier(this.context);

  /// Returns the icon color based on tag input state
  Color? getIconColor(OudsTagControlState state) {
    //todo to change when updating the tokenator
    final tagToken = OudsTheme.of(context).componentsTokens(context).chip;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsTagControlState.enabled:
        return tagToken.colorContentUnselectedEnabled;
      case OudsTagControlState.disabled:
        return tagToken.colorContentUnselectedDisabled;
      case OudsTagControlState.hovered:
        return tagToken.colorContentUnselectedHover;
      case OudsTagControlState.pressed:
        return tagToken.colorContentUnselectedPressed;
      case OudsTagControlState.focused:
        return tagToken.colorContentUnselectedFocus;
    }
  }
}
