import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_customization.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _TagCustomization extends InheritedWidget {
  const _TagCustomization({
    required super.child,
    required this.data,
  });

  final TagCustomizationState data;

  @override
  bool updateShouldNotify(_TagCustomization oldWidget) => true;
}

/// Main Widget class for tag customization
class TagCustomization extends StatefulWidget {
  const TagCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TagCustomizationState createState() => TagCustomizationState();

  static TagCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_TagCustomization>())?.data;
  }
}

/// tag customization state management
class TagCustomizationState extends CustomizationWidgetState<TagCustomization> {
  late final LayoutState layoutState;
  late final LabelTextState labelTextState;
  late final AppearanceState appearanceState;
  late final StatusState statusState;
  late final SizeState sizeState;
  late final RoundedCornerState roundedCornerState;
  late final LoaderState loaderState;

  @override
  void initState() {
    super.initState();
    layoutState = LayoutState(setState);
    labelTextState = LabelTextState(setState);
    appearanceState = AppearanceState(setState);
    statusState = StatusState(setState);
    sizeState = SizeState(setState);
    roundedCornerState = RoundedCornerState(setState);
    loaderState = LoaderState(setState);
  }

  TagEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(TagEnumLayout value) => layoutState.selected = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  TagEnumAppearance get selectedAppearance => appearanceState.selected;
  set selectedAppearance(TagEnumAppearance value) => appearanceState.selected = value;

  TagEnumStatus get selectedStatus => statusState.selected;
  set selectedStatus(TagEnumStatus value) => statusState.selected = value;

  TagEnumSize get selectedSize => sizeState.selected;
  set selectedSize(TagEnumSize value) => sizeState.selected = value;

  int get selectedIndex => statusState.index;
  set selectedIndex(int value) => statusState.index = value;

  bool get hasRoundedCorner => roundedCornerState.value;
  set hasRoundedCorner(bool value) => roundedCornerState.value = value;

  bool get hasLoader => loaderState.value;
  set hasLoader(bool value) => loaderState.value = value;

  @override
  Widget build(BuildContext context) {
    return _TagCustomization(
      data: this,
      child: widget.child,
    );
  }
}


/// Layout State Management
class LayoutState {
  LayoutState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<TagEnumLayout> _layout = [
    TagEnumLayout.textOnly,
    TagEnumLayout.bulletAndText,
    TagEnumLayout.iconAndText
  ];

  List<TagEnumLayout> get list => _layout;

  TagEnumLayout _selected = TagEnumLayout.textOnly;
  TagEnumLayout get selected => _selected;
  set selected(TagEnumLayout newValue) {
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

/// Appearance State Management
class AppearanceState {
  AppearanceState(this._setState);

  final void Function(void Function()) _setState;

  List<TagEnumAppearance> _appearance = [
    TagEnumAppearance.emphasized,
    TagEnumAppearance.muted
  ];
  TagEnumAppearance _selectedAppearance = TagEnumAppearance.emphasized;

  List<TagEnumAppearance> get list => _appearance;
  set list(List<TagEnumAppearance> newList) {
    _setState(() {
      _appearance = newList;
    });
  }

  TagEnumAppearance get selected => _selectedAppearance;
  set selected(TagEnumAppearance newValue) {
    _setState(() {
      _selectedAppearance = newValue;
    });
  }
}

/// Status State Management
class StatusState {
  StatusState(this._setState);
  TagEnumStatus _selectedStatus = TagEnumStatus.neutral;
  int _selectedIndex = 0;

  final void Function(void Function()) _setState;

  List<TagEnumStatus> _status = [
    TagEnumStatus.accent,
    TagEnumStatus.info,
    TagEnumStatus.negative,
    TagEnumStatus.neutral,
    TagEnumStatus.positive,
    TagEnumStatus.warning,
  ];

  List<TagEnumStatus> get list => _status;
  set list(List<TagEnumStatus> newList) {
    _setState(() {
      _status = newList;
    });
  }

  TagEnumStatus get selected => _selectedStatus;
  set selected(TagEnumStatus newValue) {
    _setState(() {
      _selectedStatus = newValue;
    });
  }

  int get index => _selectedIndex;
  set index(int newValue) {
    _setState(() {
      _selectedIndex = newValue;
    });
  }
}

/// Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<TagEnumSize> _appearance = [
    TagEnumSize.defaultSize,
    TagEnumSize.small
  ];
  TagEnumSize _selectedSize = TagEnumSize.defaultSize;

  List<TagEnumSize> get list => _appearance;
  set list(List<TagEnumSize> newList) {
    _setState(() {
      _appearance = newList;
    });
  }

  TagEnumSize get selected => _selectedSize;
  set selected(TagEnumSize newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// RoundedCorner State Management
class RoundedCornerState {
  RoundedCornerState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasRoundedCorner = true;

  bool get value => _hasRoundedCorner;
  set value(bool newValue) {
    _setState(() {
      _hasRoundedCorner = newValue;
    });
  }
}

/// Loader State Management
class LoaderCornerState {
  LoaderCornerState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasLoader = false;

  bool get isLoading => _hasLoader;
  set isLoading(bool newValue) {
    _setState(() {
      _hasLoader = newValue;
    });
  }
}