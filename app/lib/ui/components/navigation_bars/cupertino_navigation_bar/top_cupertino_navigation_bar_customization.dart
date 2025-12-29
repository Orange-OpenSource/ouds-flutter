/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/components/utilities/ouds_devices_utils.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/cupertino_navigation_bar/top_cupertino_navigation_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/components/navigation_bars/top_appbar/top_appbar_customization.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _CupertinoNavigationBarCustomization extends InheritedWidget {
  const _CupertinoNavigationBarCustomization({
    required super.child,
    required this.data,
  });

  final TopCupertinoNavigationBarCustomizationState data;

  @override
  bool updateShouldNotify(_CupertinoNavigationBarCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class TopCupertinoNavigationBarCustomization extends StatefulWidget {
  const TopCupertinoNavigationBarCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TopCupertinoNavigationBarCustomizationState createState() => TopCupertinoNavigationBarCustomizationState();

  static TopCupertinoNavigationBarCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_CupertinoNavigationBarCustomization>())?.data;
  }

}

class TopCupertinoNavigationBarCustomizationState extends CustomizationWidgetState<TopCupertinoNavigationBarCustomization> {
  late final TypeState typeState;
  late final NavigationBarActionTypeState leadingActionTypeState;
  late final TrailingActionTypeState trailingActionTypeState;
  late final TitleTextState titleTextState;
  late final LeadingLabelState leadingLabelState;
  late final TrailingLabelState trailingLabelState;
  late final LeadingActionCountState leadingActionState;
  late final TrailingActionCountState trailingActionState;

  @override
  void initState() {
    super.initState();
    typeState = TypeState(setState);
    leadingActionTypeState = NavigationBarActionTypeState(setState);
    trailingActionTypeState = TrailingActionTypeState(setState);
    titleTextState = TitleTextState(setState);
    leadingLabelState = LeadingLabelState(setState);
    trailingLabelState = TrailingLabelState(setState);
    leadingActionState = LeadingActionCountState(setState);
    trailingActionState = TrailingActionCountState(setState);
  }

  // size State Management
  TopCupertinoNavigationBarStyleEnum get selectedType => typeState.selected;

  set selectedType(TopCupertinoNavigationBarStyleEnum value) {
    typeState.selected = value;
  }

  // leading action type State Management
  TopCupertinoNavigationBarActionTypeEnum get selectedActionType => leadingActionTypeState.selected;

  set selectedActionType(TopCupertinoNavigationBarActionTypeEnum value) {
    leadingActionTypeState.selected = value;
   /* if(selectedLeadingActionCount != ActionCountEnum.one){
      leadingActionTypeState.selected = TopCupertinoNavigationBarActionTypeEnum.icon;
    }

    */
  }

  // trailing action type State Management
  TopCupertinoTrailingBarActionTypeEnum get selectedTrailingActionType => trailingActionTypeState.selected;

  set selectedTrailingActionType(TopCupertinoTrailingBarActionTypeEnum value) {
    trailingActionTypeState.selected = value;
  }

  String get titleText => titleTextState.value;
  set titleText(String value) => titleTextState.value = value;

  String get leadingLabel => leadingLabelState.value;
  set leadingLabel(String value) => leadingLabelState.value = value;

  String get trailingLabel => trailingLabelState.value;
  set trailingLabel(String value) => trailingLabelState.value = value;

  // leading action State Management
  ActionCountEnum get selectedLeadingActionCount => leadingActionState.selected;

  set selectedLeadingActionCount(ActionCountEnum value) {
    leadingActionState.selected = value;
   /* if(leadingActionState.selected != ActionCountEnum.one){
      selectedActionType = TopCupertinoNavigationBarActionTypeEnum.icon;
    }

    */
  }

  // trailing action State Management
  ActionCountEnum get selectedTrailingActionCount => trailingActionState.selected;

  set selectedTrailingActionCount(ActionCountEnum value) {
    trailingActionState.selected = value;
  }

  @override
  Widget build(BuildContext context) {
    return _CupertinoNavigationBarCustomization(
      data: this,
      child: widget.child,
    );
  }
}


///  Size State Management
class TypeState {
  TypeState(this._setState);

  final void Function(void Function()) _setState;

  List<TopCupertinoNavigationBarStyleEnum> _style = [
    TopCupertinoNavigationBarStyleEnum.defaultStyle,
    TopCupertinoNavigationBarStyleEnum.large,
  ];
  TopCupertinoNavigationBarStyleEnum _selectedStyle = TopCupertinoNavigationBarStyleEnum.defaultStyle;

  List<TopCupertinoNavigationBarStyleEnum> get list => _style;
  set list(List<TopCupertinoNavigationBarStyleEnum> newList) {
    _setState(() {
      _style = newList;
    });
  }

  TopCupertinoNavigationBarStyleEnum get selected => _selectedStyle;
  set selected(TopCupertinoNavigationBarStyleEnum newValue) {
    _setState(() {
      _selectedStyle = newValue;
    });
  }
}

///  navigation icon type Management
class NavigationBarActionTypeState {
  NavigationBarActionTypeState(this._setActionType);

  final void Function(void Function()) _setActionType;

  List<TopCupertinoNavigationBarActionTypeEnum> _actionType = [
    TopCupertinoNavigationBarActionTypeEnum.none,
    TopCupertinoNavigationBarActionTypeEnum.icon,
    TopCupertinoNavigationBarActionTypeEnum.text,
    TopCupertinoNavigationBarActionTypeEnum.back,

  ];

  TopCupertinoNavigationBarActionTypeEnum _selectedType =
      TopCupertinoNavigationBarActionTypeEnum.back;

  List<TopCupertinoNavigationBarActionTypeEnum> get list => _actionType;
  set list(List<TopCupertinoNavigationBarActionTypeEnum> newList) {
    _setActionType(() {
      _actionType = newList;
    });
  }

  TopCupertinoNavigationBarActionTypeEnum get selected => _selectedType;
  set selected(TopCupertinoNavigationBarActionTypeEnum newValue) {
    _setActionType(() {
      _selectedType = newValue;
    });
  }
}///  navigation icon type Management
class TrailingActionTypeState {
  TrailingActionTypeState(this._setTrailingActionType);

  final void Function(void Function()) _setTrailingActionType;

  List<TopCupertinoTrailingBarActionTypeEnum> _trailingActionType = [
    TopCupertinoTrailingBarActionTypeEnum.none,
    TopCupertinoTrailingBarActionTypeEnum.icon,
    TopCupertinoTrailingBarActionTypeEnum.text,

  ];
  TopCupertinoTrailingBarActionTypeEnum _selectedTrailingType =
      TopCupertinoTrailingBarActionTypeEnum.icon;

  List<TopCupertinoTrailingBarActionTypeEnum> get list => _trailingActionType;
  set list(List<TopCupertinoTrailingBarActionTypeEnum> newList) {
    _setTrailingActionType(() {
      _trailingActionType = newList;
    });
  }

  TopCupertinoTrailingBarActionTypeEnum get selected => _selectedTrailingType;
  set selected(TopCupertinoTrailingBarActionTypeEnum newValue) {
    _setTrailingActionType(() {
      _selectedTrailingType = newValue;
    });
  }
}

/// TitleText State Management
class TitleTextState {
  TitleTextState(this._setState);

  final void Function(void Function()) _setState;
  String _titleTextValue = "Title";

  String get value => _titleTextValue;
  set value(String newValue) {
    _setState(() {
      _titleTextValue = newValue;
    });
  }
}

/// leading label State Management
class LeadingLabelState {
  LeadingLabelState(this._setState);

  final void Function(void Function()) _setState;
  String _leadingLabelValue = "Label";

  String get value => _leadingLabelValue;

  set value(String newValue) {
    _setState(() {
      _leadingLabelValue = newValue;
    });
  }
}

  /// trailing label State Management
class TrailingLabelState {
  TrailingLabelState(this._setState);

  final void Function(void Function()) _setState;
  String _trailingLabelValue = "Label";

  String get value => _trailingLabelValue;
  set value(String newValue) {
    _setState(() {
      _trailingLabelValue = newValue;
    });
  }
}

///  leading action count type Management
class LeadingActionCountState {
  LeadingActionCountState(this._setActionCountState);

  late final void Function(void Function()) _setActionCountState;

  List<ActionCountEnum> _actionCountList = [
    ActionCountEnum.zero,
    ActionCountEnum.one,
    ActionCountEnum.two,
    ActionCountEnum.three,
    ActionCountEnum.four,
    ActionCountEnum.five,
    ActionCountEnum.sex,
  ];

  ActionCountEnum _selectedCount = ActionCountEnum.one;

  List<ActionCountEnum> get list => _actionCountList;
  set list(List<ActionCountEnum> newList) {
    _setActionCountState(() {
      _actionCountList = newList;
    });
  }

  ActionCountEnum get selected => _selectedCount;
  set selected(ActionCountEnum newValue) {
    _setActionCountState(() {
      _selectedCount = newValue;
    });
  }
}

///  trailing action count type Management
class TrailingActionCountState {
  TrailingActionCountState(this._setActionCountState);

  late final void Function(void Function()) _setActionCountState;


  List<ActionCountEnum> _actionCountList = [
    ActionCountEnum.zero,
    ActionCountEnum.one,
    ActionCountEnum.two,
    ActionCountEnum.three,
    ActionCountEnum.four,
    ActionCountEnum.five,
    ActionCountEnum.sex,
  ];

  ActionCountEnum _selectedCount = ActionCountEnum.one;

  List<ActionCountEnum> get list => _actionCountList;
  set list(List<ActionCountEnum> newList) {
    _setActionCountState(() {
      _actionCountList = newList;
    });
  }

  ActionCountEnum get selected => _selectedCount;
  set selected(ActionCountEnum newValue) {
    _setActionCountState(() {
      _selectedCount = newValue;
    });
  }
}