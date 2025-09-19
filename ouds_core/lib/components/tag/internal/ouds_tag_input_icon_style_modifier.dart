
/// @nodoc
library ouds_internal;

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagInputControlIconColorModifier {
  final BuildContext context;

  OudsTagInputControlIconColorModifier(this.context);

  /// Returns the icon color based on tag input state
  Color? getIconColor(OudsTagControlState state) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tagInput;

    // Assuming selected icon color == tick color
    switch (state) {
      case OudsTagControlState.enabled:
        return tagToken.colorContentEnabled;
      case OudsTagControlState.disabled:
        return OudsTheme.of(context).colorScheme(context).actionDisabled;
      case OudsTagControlState.hovered:
        return tagToken.colorContentHover;
      case OudsTagControlState.pressed:
        return tagToken.colorContentPressed;
      case OudsTagControlState.focused:
        return tagToken.colorContentFocus;
    }
  }
}
