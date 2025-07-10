import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_enum.dart';
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
    colorState = ColorState(setState);
  }

  // Proxy getters and setters to expose state values directly
  DividerEnumColor get selectedColor => colorState.selectedColor;
  set selectedColor(DividerEnumColor value) => colorState.selectedColor = value;

  int get selectedIndex => colorState.index;
  set selectedIndex(int value) => colorState.index = value;

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
  ColorState(this._setState);

  final void Function(void Function()) _setState;

  List<DividerEnumColor> _color = [
    DividerEnumColor.defaultColor,
    DividerEnumColor.muted,
    DividerEnumColor.emphasized,
    DividerEnumColor.brandPrimary,
    DividerEnumColor.onBrandPrimary,
    DividerEnumColor.alwaysBlack,
    DividerEnumColor.alwaysWhite,
    DividerEnumColor.alwaysOnBlack,
    DividerEnumColor.alwaysOnWhite,
  ];

  DividerEnumColor _selectedColor = DividerEnumColor.defaultColor;
  int _selectedIndex = 0;

  List<DividerEnumColor> get list => _color;
  set list(List<DividerEnumColor> newList) {
    _setState(() {
      _color = newList;
    });
  }

  DividerEnumColor get selectedColor => _selectedColor;
  set selectedColor(DividerEnumColor newValue) {
    _setState(() {
      _selectedColor = newValue;
    });
  }

  int get index => _selectedIndex;
  set index(int newValue) {
    _setState(() {
      _selectedIndex = newValue;
    });
  }
}
