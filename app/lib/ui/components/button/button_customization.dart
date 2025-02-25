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
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';

class _ButtonCustomization extends InheritedWidget {
  const _ButtonCustomization({
    required super.child,
    required this.data,
  });

  final ButtonCustomizationState data;

  @override
  bool updateShouldNotify(_ButtonCustomization oldWidget) => true;
}

class ButtonCustomization extends StatefulWidget {
  const ButtonCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ButtonCustomizationState createState() => ButtonCustomizationState();

  static ButtonCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ButtonCustomization>())
        ?.data;
  }
}

class ButtonCustomizationState extends State<ButtonCustomization> {
  bool _hasEnabled = true;
  bool _hasOnColoredBox = false;

  /// Mark - Enabled
  bool get hasEnabled => _hasEnabled;
  set hasEnabled(bool value) {
    setState(() {
      _hasEnabled = value;
    });
  }

  /// Mark - OnColoredBox
  bool get hasOnColoredBox => _hasOnColoredBox;
  set hasOnColoredBox(bool value) {
    setState(() {
      _hasOnColoredBox = value;
    });
  }

  /// Mark - Hiercharchy
  List<ButtonsEnumHierarchy> _hierarchy = [
    ButtonsEnumHierarchy.Default,
    ButtonsEnumHierarchy.Minimal,
    ButtonsEnumHierarchy.Negative,
    ButtonsEnumHierarchy.Strong,
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
    });
  }

  /// Mark - Style
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
    });
  }

  /// Mark - Layout
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

  /// _ButtonCustomization
  @override
  Widget build(BuildContext context) {
    return _ButtonCustomization(
      data: this,
      child: widget.child,
    );
  }
}
