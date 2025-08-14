import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

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
class ButtonCustomizationState extends CustomizationWidgetState<ButtonCustomization> {
  late final HierarchyState hierarchyState;
  late final LayoutState layoutState;
  late final RoundedCornerState roundedCornerState;
  late final LoaderState loaderState;

  @override
  void initState() {
    super.initState();
    hierarchyState = HierarchyState(setState, onColoredBoxState);
    loaderState = LoaderState(setState, enabledState);
    layoutState = LayoutState(setState);
    roundedCornerState = RoundedCornerState(setState);
  }

  // Getter to determine if the 'OnColoredBox' should be disabled
  bool get isOnColoredBoxDisabled {
    return ButtonErrorCases.isOnColoredBoxDisabled(hierarchyState.selected);
  }

  // Getter to determine if the 'Enabled' should be disabled
  bool get isEnabledWhenLoading {
    return ButtonErrorCases.isEnabledWhenLoading(hasLoader);
  }

  // Proxy getters and setters to expose state values directly
  ButtonEnumHierarchy get selectedHierarchy => hierarchyState.selected;
  set selectedHierarchy(ButtonEnumHierarchy value) => hierarchyState.selected = value;

  ButtonEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(ButtonEnumLayout value) => layoutState.selected = value;

  bool get hasRoundedCorner => roundedCornerState.value;
  set hasRoundedCorner(bool value) => roundedCornerState.value = value;

  bool get hasLoader => loaderState.value;
  set hasLoader(bool value) => loaderState.value = value;

  @override
  Widget build(BuildContext context) {
    return _ButtonCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Hierarchy State Management
class HierarchyState {
  HierarchyState(this._setState, this.onColoredBoxState);

  final void Function(void Function()) _setState;
  final OnColoredBoxState onColoredBoxState;

  List<ButtonEnumHierarchy> _hierarchy = [
    ButtonEnumHierarchy.defaultHierarchy,
    ButtonEnumHierarchy.strong,
    ButtonEnumHierarchy.brand,
    ButtonEnumHierarchy.minimal,
    ButtonEnumHierarchy.negative,
  ];
  ButtonEnumHierarchy _selectedHierarchy = ButtonEnumHierarchy.defaultHierarchy;

  List<ButtonEnumHierarchy> get list => _hierarchy;
  set list(List<ButtonEnumHierarchy> newList) {
    _setState(() {
      _hierarchy = newList;
    });
  }

  ButtonEnumHierarchy get selected => _selectedHierarchy;
  set selected(ButtonEnumHierarchy newValue) {
    _setState(() {
      _selectedHierarchy = newValue;

      if (ButtonErrorCases.shouldDisableOnColoredBox(newValue)) {
        onColoredBoxState.value = false;
      }
    });
  }
}

/// Layout State Management
class LayoutState {
  LayoutState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<ButtonEnumLayout> _layout = [
    ButtonEnumLayout.textOnly,
    ButtonEnumLayout.iconAndText,
    ButtonEnumLayout.iconOnly,
  ];

  List<ButtonEnumLayout> get list => _layout;

  ButtonEnumLayout _selected = ButtonEnumLayout.textOnly;
  ButtonEnumLayout get selected => _selected;
  set selected(ButtonEnumLayout newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// Loader State Management
class LoaderState {
  LoaderState(this._setState, this.enabledState);

  final void Function(void Function()) _setState;
  final EnabledState enabledState;
  bool _hasLoaderState = false;

  bool get value => _hasLoaderState;
  set value(bool newValue) {
    _setState(() {
      _hasLoaderState = newValue;
    });
  }
}

/// RoundedCorner State Management
class RoundedCornerState {
  RoundedCornerState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasRoundedCorner = false;

  bool get value => _hasRoundedCorner;
  set value(bool newValue) {
    _setState(() {
      _hasRoundedCorner = newValue;
    });
  }
}

/// Error handling for specific button behavior
class ButtonErrorCases {
  // OnColoredBox behavior: Disable if hierarchy is 'Negative'
  static bool isOnColoredBoxDisabled(ButtonEnumHierarchy hierarchy) {
    return hierarchy == ButtonEnumHierarchy.negative || hierarchy == ButtonEnumHierarchy.brand;
  }

  // OnColoredBox management: Disable when "Negative" hierarchy is selected
  static bool shouldDisableOnColoredBox(ButtonEnumHierarchy selectedHierarchy) {
    return selectedHierarchy == ButtonEnumHierarchy.negative || selectedHierarchy == ButtonEnumHierarchy.brand;
  }

  // Enabled behavior: Disable if Loader is not null
  static bool isEnabledWhenLoading(bool hasEnabled) {
    return hasEnabled;
  }
}
