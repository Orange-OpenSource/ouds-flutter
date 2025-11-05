import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _LinkCustomization extends InheritedWidget {
  const _LinkCustomization({
    required super.child,
    required this.data,
  });

  final LinkCustomizationState data;

  @override
  bool updateShouldNotify(_LinkCustomization oldWidget) => true;
}

/// Main Widget class for tag customization
class LinkCustomization extends StatefulWidget {
  const LinkCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  LinkCustomizationState createState() => LinkCustomizationState();

  static LinkCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_LinkCustomization>())?.data;
  }
}

/// tag customization state management
class LinkCustomizationState extends CustomizationWidgetState<LinkCustomization> {
  late final LayoutState layoutState;
  late final LabelTextState labelTextState;
  late final SizeState sizeState;

  @override
  void initState() {
    super.initState();
    layoutState = LayoutState(setState);
    labelTextState = LabelTextState(setState);
    sizeState = SizeState(setState);
  }

  LinkEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(LinkEnumLayout value) => layoutState.selected = value;

  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  LinkEnumSize get selectedSize => sizeState.selected;
  set selectedSize(LinkEnumSize value) => sizeState.selected = value;


  @override
  Widget build(BuildContext context) {
    return _LinkCustomization(
      data: this,
      child: widget.child,
    );
  }
}


/// Layout State Management
class LayoutState {
  LayoutState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<LinkEnumLayout> _layout = [
    LinkEnumLayout.textOnly,
    LinkEnumLayout.textAndIcon,
    LinkEnumLayout.back,
    LinkEnumLayout.next,
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

  List<LinkEnumSize> _sizeList = [
    LinkEnumSize.defaultSize,
    LinkEnumSize.small
  ];
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
