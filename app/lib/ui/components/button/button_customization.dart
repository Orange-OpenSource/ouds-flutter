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
  ButtonsEnumHierarchy get selectedHierarchy => hierarchyState.selected;
  set selectedHierarchy(ButtonsEnumHierarchy value) => hierarchyState.selected = value;

  ButtonsEnumStyle get selectedStyle => styleState.selected;
  set selectedStyle(ButtonsEnumStyle value) => styleState.selected = value;

  ButtonsEnumLayout get selectedLayout => layoutState.selected;
  set selectedLayout(ButtonsEnumLayout value) => layoutState.selected = value;

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

  List<ButtonsEnumHierarchy> _hierarchy = [
    ButtonsEnumHierarchy.Default,
    ButtonsEnumHierarchy.Strong,
    ButtonsEnumHierarchy.Minimal,
    ButtonsEnumHierarchy.Negative,
  ];
  ButtonsEnumHierarchy _selectedHierarchy = ButtonsEnumHierarchy.Default;

  List<ButtonsEnumHierarchy> get list => _hierarchy;
  set list(List<ButtonsEnumHierarchy> newList) {
    _setState(() {
      _hierarchy = newList;
    });
  }

  ButtonsEnumHierarchy get selected => _selectedHierarchy;
  set selected(ButtonsEnumHierarchy newValue) {
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

  List<ButtonsEnumStyle> _style = [
    ButtonsEnumStyle.Default,
    ButtonsEnumStyle.Loading,
  ];
  ButtonsEnumStyle _selectedStyle = ButtonsEnumStyle.Default;

  List<ButtonsEnumStyle> get list => _style;
  set list(List<ButtonsEnumStyle> newList) {
    _setState(() {
      _style = newList;
    });
  }

  ButtonsEnumStyle get selected => _selectedStyle;
  set selected(ButtonsEnumStyle newValue) {
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

  final List<ButtonsEnumLayout> _layout = [
    ButtonsEnumLayout.TextOnly,
    ButtonsEnumLayout.IconOnly,
    ButtonsEnumLayout.IconAndText,
  ];

  List<ButtonsEnumLayout> get list => _layout;

  ButtonsEnumLayout _selected = ButtonsEnumLayout.TextOnly;
  ButtonsEnumLayout get selected => _selected;
  set selected(ButtonsEnumLayout newValue) {
    _setState(() {
      _selected = newValue;
    });
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
