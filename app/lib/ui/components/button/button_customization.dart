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
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _ButtonCustomization extends InheritedWidget {
  const _ButtonCustomization({
    required super.child,
    required this.data,
  });

  final ButtonCustomizationState data;

  @override
  bool updateShouldNotify(_ButtonCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class ButtonCustomization extends StatefulWidget {
  const ButtonCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ButtonCustomizationState createState() => ButtonCustomizationState();

  static ButtonCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ButtonCustomization>())?.data;
  }
}

/// Button customization state management
class ButtonCustomizationState extends State<ButtonCustomization> {
  bool _hasEnabled = true;
  bool _hasOnColoredBox = false;
  String _textValue = "Button";

  // Getters for error handling
  bool get isOnColoredBoxDisabled => ButtonErrorCases.isOnColoredBoxDisabled(_selectedHierarchy);
  bool get isEnabledWhenLoading => ButtonErrorCases.isEnabledWhenLoading(_selectedStyle);

  /// Enabled
  bool get hasEnabled => _hasEnabled;
  set hasEnabled(bool value) {
    setState(() {
      _hasEnabled = value;
    });
  }

  /// OnColoredBox
  bool get hasOnColoredBox => _hasOnColoredBox;
  set hasOnColoredBox(bool value) {
    if (!isOnColoredBoxDisabled) {
      setState(() {
        _hasOnColoredBox = value;
      });
    }
  }

  /// Hierarchy
  List<ButtonsEnumHierarchy> _hierarchy = [
    ButtonsEnumHierarchy.Default,
    ButtonsEnumHierarchy.Strong,
    ButtonsEnumHierarchy.Minimal,
    ButtonsEnumHierarchy.Negative,
  ];
  ButtonsEnumHierarchy _selectedHierarchy = ButtonsEnumHierarchy.Default;

  List<ButtonsEnumHierarchy> get hierarchy => _hierarchy;
  set hierarchy(List<ButtonsEnumHierarchy> value) {
    setState(() {
      _hierarchy = value;
    });
  }

  ButtonsEnumHierarchy get selectedHierarchy => _selectedHierarchy;

  set selectedHierarchy(ButtonsEnumHierarchy value) {
    setState(() {
      _selectedHierarchy = value;

      // Disable _hasOnColoredBox if "Negative" hierarchy is selected
      if (ButtonErrorCases.shouldDisableOnColoredBox(_selectedHierarchy)) {
        _hasOnColoredBox = false;
      }
    });
  }

  /// Style
  List<ButtonsEnumStyle> _style = [
    ButtonsEnumStyle.Default,
    ButtonsEnumStyle.Loading,
  ];
  ButtonsEnumStyle _selectedStyle = ButtonsEnumStyle.Default;

  List<ButtonsEnumStyle> get style => _style;
  set style(List<ButtonsEnumStyle> value) {
    setState(() {
      _style = value;
    });
  }

  ButtonsEnumStyle get selectedStyle => _selectedStyle;

  set selectedStyle(ButtonsEnumStyle value) {
    setState(() {
      _selectedStyle = value;

      // Disable _hasEnabled if "Loading" style is selected
      if (ButtonErrorCases.shouldDisableEnable(_selectedStyle)) {
        _hasEnabled = false;
      } else {
        _hasEnabled = true;
      }
    });
  }

  /// Layout
  List<ButtonsEnumLayout> _layout = [
    ButtonsEnumLayout.TextOnly,
    ButtonsEnumLayout.IconOnly,
    ButtonsEnumLayout.IconAndText,
  ];
  ButtonsEnumLayout _selectedLayout = ButtonsEnumLayout.TextOnly;

  List<ButtonsEnumLayout> get layout => _layout;
  set layout(List<ButtonsEnumLayout> value) {
    setState(() {
      _layout = value;
    });
  }

  ButtonsEnumLayout get selectedLayout => _selectedLayout;

  set selectedLayout(ButtonsEnumLayout value) {
    setState(() {
      _selectedLayout = value;
    });
  }

  /// Text
  String get textValue => _textValue;
  set textValue(String value) {
    setState(() {
      _textValue = value;
    });
  }

  // Return the InheritedWidget with the current state
  @override
  Widget build(BuildContext context) {
    return _ButtonCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Error handling for specific button behavior
class ButtonErrorCases {
  // OnColoredBox behavior: Disable if hierarchy is 'Negative'
  static bool isOnColoredBoxDisabled(ButtonsEnumHierarchy hierarchy) {
    return hierarchy == ButtonsEnumHierarchy.Negative;
  }

  // OnColoredBox management: Disable when "Negative" hierarchy is selected
  static bool shouldDisableOnColoredBox(ButtonsEnumHierarchy selectedHierarchy) {
    return selectedHierarchy == ButtonsEnumHierarchy.Negative;
  }

  // Enabled behavior: Disable if style is "Loading"
  static bool isEnabledWhenLoading(ButtonsEnumStyle selectedStyle) {
    return selectedStyle == ButtonsEnumStyle.Loading;
  }

  // Enabled management: Disable when "Loading" style is selected
  static bool shouldDisableEnable(ButtonsEnumStyle selectedStyle) {
    return selectedStyle == ButtonsEnumStyle.Loading;
  }
}
