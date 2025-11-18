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
  late final AppearanceState appearanceState;
  late final LayoutState layoutState;
  late final RoundedCornerState roundedCornerState;
  late final LoaderState loaderState;

  @override
  void initState() {
    super.initState();
    appearanceState = AppearanceState(setState, onColoredBoxState);
    loaderState = LoaderState(setState, enabledState);
    layoutState = LayoutState(setState);
    roundedCornerState = RoundedCornerState(setState);
  }

  // Getter to determine if the 'OnColoredBox' should be disabled
  bool get isOnColoredBoxDisabled {
    return ButtonErrorCases.isOnColoredBoxDisabled(appearanceState.selected);
  }

  // Getter to determine if the 'Enabled' should be disabled
  bool get isEnabledWhenLoading {
    return ButtonErrorCases.isEnabledWhenLoading(hasLoader);
  }

  // Proxy getters and setters to expose state values directly
  ButtonEnumAppearance get selectedAppearance => appearanceState.selected;
  set selectedAppearance(ButtonEnumAppearance value) => appearanceState.selected = value;

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

/// Appearance State Management
class AppearanceState {
  AppearanceState(this._setState, this.onColoredBoxState);

  final void Function(void Function()) _setState;
  final OnColoredBoxState onColoredBoxState;

  List<ButtonEnumAppearance> _appearance = [
    ButtonEnumAppearance.defaultAppearance,
    ButtonEnumAppearance.strong,
    ButtonEnumAppearance.brand,
    ButtonEnumAppearance.minimal,
    ButtonEnumAppearance.negative,
  ];
  ButtonEnumAppearance _selectedAppearance = ButtonEnumAppearance.defaultAppearance;

  List<ButtonEnumAppearance> get list => _appearance;
  set list(List<ButtonEnumAppearance> newList) {
    _setState(() {
      _appearance = newList;
    });
  }

  ButtonEnumAppearance get selected => _selectedAppearance;
  set selected(ButtonEnumAppearance newValue) {
    _setState(() {
      _selectedAppearance = newValue;

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
  // OnColoredBox behavior: Disable if appearance is 'Negative'
  static bool isOnColoredBoxDisabled(ButtonEnumAppearance appearance) {
    return appearance == ButtonEnumAppearance.negative || appearance == ButtonEnumAppearance.brand;
  }

  // OnColoredBox management: Disable when "Negative" appearance is selected
  static bool shouldDisableOnColoredBox(ButtonEnumAppearance selectedAppearance) {
    return selectedAppearance == ButtonEnumAppearance.negative || selectedAppearance == ButtonEnumAppearance.brand;
  }

  // Enabled behavior: Disable if Loader is not null
  static bool isEnabledWhenLoading(bool hasEnabled) {
    return hasEnabled;
  }
}
