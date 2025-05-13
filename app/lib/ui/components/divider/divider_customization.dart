
import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _DividerCustomization extends InheritedWidget {
  const _DividerCustomization({
    required super.child,
    required this.data,
  });

  final DividerCustomizationState data;

  @override
  bool updateShouldNotify(_DividerCustomization oldWidget) => true;
}

/// Main Widget class for Divider customization
class DividerCustomization extends StatefulWidget {
  const DividerCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  DividerCustomizationState createState() => DividerCustomizationState();

  static DividerCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_DividerCustomization>())?.data;
  }
}

/// Divider customization state management
class DividerCustomizationState extends CustomizationWidgetState<DividerCustomization> {
  late final ColorState colorState;


  @override
  void initState() {
    super.initState();
    colorState = ColorState(setState, onColoredBoxState);
  }

  // Proxy getters and setters to expose state values directly
  DividerEnumColor get selectedColor => colorState.selected;
  set selectedColor(DividerEnumColor value) => colorState.selected = value;

  @override
  Widget build(BuildContext context) {
    return _DividerCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Color State Management
class ColorState {
  ColorState(this._setState, this.onColoredBoxState);

  final void Function(void Function()) _setState;
  final OnColoredBoxState onColoredBoxState;

  List<DividerEnumColor> _color = [
    DividerEnumColor.alwaysOnWhite,
    DividerEnumColor.alwaysWhite,
    DividerEnumColor.alwaysOnBlack,
    DividerEnumColor.alwaysBlack,
    DividerEnumColor.brandPrimary,
    DividerEnumColor.defaultColor,
    DividerEnumColor.emphasized,
    DividerEnumColor.muted,
    DividerEnumColor.onBrandPrimary,
  ];

  DividerEnumColor _selectedColor = DividerEnumColor.defaultColor;

  List<DividerEnumColor> get list => _color;
  set list(List<DividerEnumColor> newList) {
    _setState(() {
      _color = newList;
    });
  }

  DividerEnumColor get selected => _selectedColor;
  set selected(DividerEnumColor newValue) {
    _setState(() {
      _selectedColor = newValue;
    });
  }

}

/// Represents the color of an OUDS divider.
enum DividerEnumColor {
  defaultColor,
  muted,
  emphasized,
  brandPrimary,
  onBrandPrimary,
  alwaysBlack,
  alwaysOnBlack,
  alwaysWhite,
  alwaysOnWhite;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_color_label;
  }
}

