//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/button_loading_modifier.dart';
import 'package:ouds_core/components/button/internal/button_style_modifier.dart';

/// Enum pour la hiérarchie du bouton
enum ButtonHierarchy {
  Default,
  Strong,
  Minimal,
  Negative,
}

/// Enum pour la hiérarchie du bouton
enum ButtonLayout {
  TextOnly,
  IconAndText,
  IconOnly;
}

/// Enum pour les styles du bouton
enum OudsButtonStyle2 {
  defaultStyle,
  loading,
}

/// [OUDS Button design guidelines](https://unified-design-system.orange.com/472794e18/p/48a788-button)
///
/// An OUDS button which displays text only.
///
/// In the case it is used in an [OudsColoredBox], its monochrome variant is automatically displayed.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// **Parameters**:
/// - `text`: Text displayed in the button.
/// - `onClick`: Callback invoked when the button is clicked.
/// - `enabled`: Controls the enabled state of the button when [style] is equal to [OudsButton.Style.Default].
///   When `false`, this button will not be clickable. Has no effect when [style] is equal to [OudsButton.Style.Loading].
/// - `style`: The button style.
/// - `hierarchy`: The button hierarchy.
///   A button with [OudsButton.Hierarchy.Negative] hierarchy is not allowed as a direct or indirect child of an [OudsColoredBox] and will throw an [IllegalStateException].
///
/// **Samples**:
/// - [OudsButtonWithTextSample](com.orange.ouds.core.component.samples.OudsButtonWithTextSample)
/// - [OudsButtonWithTextOnColoredBackgroundSample](com.orange.ouds.core.component.samples.OudsButtonWithTextOnColoredBackgroundSample)
class OudsButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final ButtonHierarchy hierarchy;
  final OudsButtonStyle2 style;
  final ButtonLayout layout;
  final VoidCallback? onClick;

  const OudsButton({
    super.key,
    this.label,
    this.icon,
    required this.hierarchy,
    required this.style,
    required this.layout,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    switch (layout) {
      case ButtonLayout.IconOnly:
        return _buildButton(context, icon: icon);

      case ButtonLayout.IconAndText:
        if (label == null) {
          return _buildButton(context, icon: icon);
        }
        return _buildButton(context, icon: icon, label: label);

      case ButtonLayout.TextOnly:
        return _buildButton(context, label: label);
    }
  }

  Widget _buildButton(BuildContext context, {Widget? icon, String? label}) {
    switch (style) {
      case OudsButtonStyle2.defaultStyle:
        return OutlinedButton(
          style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: hierarchy, layout: layout),
          onPressed: onClick,
          child: _getButtonChild(icon, label),
        );
      case OudsButtonStyle2.loading:
        return ButtonLoadingModifier(label: label, layout: layout, hierarchy: hierarchy, style: style);
    }
  }

  Widget _getButtonChild(Widget? icon, String? label) {
    if (icon != null && label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: 8),
          Text(label),
        ],
      );
    }

    return icon ?? Text(label ?? '');
  }
}
