import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _LinkCustomization extends InheritedWidget {
  const _LinkCustomization({required super.child, required this.data});

  final LinkCustomizationState data;

  @override
  bool updateShouldNotify(_LinkCustomization oldWidget) => true;
}

/// Main Widget class for tag customization
class LinkCustomization extends StatefulWidget {
  const LinkCustomization({super.key, required this.child});

  final Widget child;

  @override
  LinkCustomizationState createState() => LinkCustomizationState();

  static LinkCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_LinkCustomization>())
        ?.data;
  }
}

/// tag customization state management
class LinkCustomizationState
    extends CustomizationWidgetState<LinkCustomization> {
  late final LayoutState layoutState;
  late final LabelTextState labelTextState;
  late final SizeState sizeState;
  late final DensityState densityState;
  late final TintedState tintedState;

  @override
  void initState() {
    super.initState();
    layoutState = LayoutState(setState);
    labelTextState = LabelTextState(setState);
    sizeState = SizeState(setState);
    densityState = DensityState(setState);
    tintedState = TintedState(setState);
  }

  LinkEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(LinkEnumLayout value) => layoutState.selected = value;

  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  LinkEnumSize get selectedSize => sizeState.selected;
  set selectedSize(LinkEnumSize value) => sizeState.selected = value;

  LinkEnumDensity get selectedDensity => densityState.selected;
  set selectedDensity(LinkEnumDensity value) => densityState.selected = value;

  bool get isTinted => tintedState.value;
  set isTinted(bool value) => tintedState.value = value;

  @override
  Widget build(BuildContext context) {
    return _LinkCustomization(data: this, child: widget.child);
  }
}

/// Layout State Management
class LayoutState {
  LayoutState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<LinkEnumLayout> _layout = [
    LinkEnumLayout.textOnly,
    LinkEnumLayout.textAndIcon,
    LinkEnumLayout.previous,
    LinkEnumLayout.next,
    LinkEnumLayout.external,
  ];

  List<LinkEnumLayout> get list => _layout;

  LinkEnumLayout _selected = LinkEnumLayout.textOnly;
  LinkEnumLayout get selected => _selected;
  set selected(LinkEnumLayout newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// LabelText State Management
class LabelTextState {
  LabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _labelTextValue = "Label";

  String get value => _labelTextValue;
  set value(String newValue) {
    _setState(() {
      _labelTextValue = newValue;
    });
  }
}

/// Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<LinkEnumSize> _sizeList = [LinkEnumSize.defaultSize, LinkEnumSize.small];
  LinkEnumSize _selectedSize = LinkEnumSize.defaultSize;

  List<LinkEnumSize> get list => _sizeList;
  set list(List<LinkEnumSize> newList) {
    _setState(() {
      _sizeList = newList;
    });
  }

  LinkEnumSize get selected => _selectedSize;
  set selected(LinkEnumSize newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// Tinted State Management
///
/// Controls whether the icon displayed by [OudsLink.icon] should be tinted
/// with the theme color, or shown with its original colors.
class TintedState {
  TintedState(this._setState);

  final void Function(void Function()) _setState;
  bool _tinted = true;

  bool get value => _tinted;
  set value(bool newValue) {
    _setState(() {
      _tinted = newValue;
    });
  }
}

/// Density State Management
class DensityState {
  DensityState(this._setState);

  final void Function(void Function()) _setState;

  List<LinkEnumDensity> _densityList = [
    LinkEnumDensity.defaultDensity,
    LinkEnumDensity.compact,
  ];
  LinkEnumDensity _selectedDensity = LinkEnumDensity.defaultDensity;

  List<LinkEnumDensity> get list => _densityList;
  set list(List<LinkEnumDensity> newList) {
    _setState(() {
      _densityList = newList;
    });
  }

  LinkEnumDensity get selected => _selectedDensity;
  set selected(LinkEnumDensity newValue) {
    _setState(() {
      _selectedDensity = newValue;
    });
  }
}
