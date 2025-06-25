import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

import 'chip_enum.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _ChipCustomization extends InheritedWidget {
  const _ChipCustomization({
    required super.child,
    required this.data,
  });

  final ChipCustomizationState data;

  @override
  bool updateShouldNotify(_ChipCustomization oldWidget) => true;
}

/// Main Widget class for chip customization
class ChipCustomization extends StatefulWidget {
  const ChipCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ChipCustomizationState createState() => ChipCustomizationState();

  static ChipCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ChipCustomization>())?.data;
  }
}

/// Chip customization state management
class ChipCustomizationState extends CustomizationWidgetState<ChipCustomization> {
  late final LayoutState layoutState;
  late final LabelTextState labelTextState;

  @override
  void initState() {
    super.initState();
    layoutState = LayoutState(setState);
    labelTextState = LabelTextState(setState);
  }

  ChipEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(ChipEnumLayout value) => layoutState.selected = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  @override
  Widget build(BuildContext context) {
    return _ChipCustomization(
      data: this,
      child: widget.child,
    );
  }
}


/// Layout State Management
class LayoutState {
  LayoutState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<ChipEnumLayout> _layout = [
    ChipEnumLayout.textOnly,
    ChipEnumLayout.iconAndText,
    ChipEnumLayout.iconOnly,
  ];

  List<ChipEnumLayout> get list => _layout;

  ChipEnumLayout _selected = ChipEnumLayout.textOnly;
  ChipEnumLayout get selected => _selected;
  set selected(ChipEnumLayout newValue) {
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
