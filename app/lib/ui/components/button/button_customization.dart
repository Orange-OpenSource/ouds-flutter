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
  late final StyleState styleState;
  late final LayoutState layoutState;

  @override
  void initState() {
    super.initState();
    hierarchyState = HierarchyState(setState, onColoredBoxState);
    styleState = StyleState(setState, enabledState);
    layoutState = LayoutState(setState);
  }

  // Getter to determine if the 'OnColoredBox' should be disabled
  bool get isOnColoredBoxDisabled {
    return ButtonErrorCases.isOnColoredBoxDisabled(hierarchyState.selected);
  }

  // Getter to determine if the 'Enabled' should be disabled
  bool get isEnabledWhenLoading {
    return ButtonErrorCases.isEnabledWhenLoading(styleState.selected);
  }

  // Proxy getters and setters to expose state values directly
  ButtonEnumHierarchy get selectedHierarchy => hierarchyState.selected;
  set selectedHierarchy(ButtonEnumHierarchy value) => hierarchyState.selected = value;

  ButtonEnumStyle get selectedStyle => styleState.selected;
  set selectedStyle(ButtonEnumStyle value) => styleState.selected = value;

  ButtonEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(ButtonEnumLayout value) => layoutState.selected = value;

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

/// Style State Management
class StyleState {
  StyleState(this._setState, this.enabledState);

  final void Function(void Function()) _setState;
  final EnabledState enabledState;

  List<ButtonEnumStyle> _style = [
    ButtonEnumStyle.defaultStyle,
    ButtonEnumStyle.loading,
  ];
  ButtonEnumStyle _selectedStyle = ButtonEnumStyle.defaultStyle;

  List<ButtonEnumStyle> get list => _style;
  set list(List<ButtonEnumStyle> newList) {
    _setState(() {
      _style = newList;
    });
  }

  ButtonEnumStyle get selected => _selectedStyle;
  set selected(ButtonEnumStyle newValue) {
    _setState(() {
      _selectedStyle = newValue;

      if (ButtonErrorCases.shouldDisableEnable(newValue)) {
        enabledState.value = false;
      } else {
        enabledState.value = true;
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

/// Error handling for specific button behavior
class ButtonErrorCases {
  // OnColoredBox behavior: Disable if hierarchy is 'Negative'
  static bool isOnColoredBoxDisabled(ButtonEnumHierarchy hierarchy) {
    return hierarchy == ButtonEnumHierarchy.negative;
  }

  // OnColoredBox management: Disable when "Negative" hierarchy is selected
  static bool shouldDisableOnColoredBox(ButtonEnumHierarchy selectedHierarchy) {
    return selectedHierarchy == ButtonEnumHierarchy.negative;
  }

  // Enabled behavior: Disable if style is "Loading"
  static bool isEnabledWhenLoading(ButtonEnumStyle selectedStyle) {
    return selectedStyle == ButtonEnumStyle.loading;
  }

  // Enabled management: Disable when "Loading" style is selected
  static bool shouldDisableEnable(ButtonEnumStyle selectedStyle) {
    return selectedStyle == ButtonEnumStyle.loading;
  }
}
