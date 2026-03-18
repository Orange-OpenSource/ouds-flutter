
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
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _TopBarCustomization extends InheritedWidget {
  const _TopBarCustomization({
    required super.child,
    required this.data,
  });

  final TopBarCustomizationState data;

  @override
  bool updateShouldNotify(_TopBarCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class TopBarCustomization extends StatefulWidget {
  const TopBarCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TopBarCustomizationState createState() => TopBarCustomizationState();

  static TopBarCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_TopBarCustomization>())?.data;
  }
}

/// TopAppBar customization state management
class TopBarCustomizationState extends CustomizationWidgetState<TopBarCustomization> {

  //Material
  late final NavigationIconTypeState iconTypeState;
  late final ActionIconBadgeState actionIconBadgeState;
  late final ActionAvatarState actionAvatarState;
  late final ActionAvatarMonogramTextState actionAvatarMonogramTextState;
  late final ExpandedHeightState expandedHeightTextState;
  late final TitleMaxLinesState titleMaxLinesTextState;
  late final ActionSelectedState actionSelectedState;
  late final ShowAvatarState showAvatarState;

  // Common
  late final SizeState sizeState;
  late final TitleTextState titleTextState;
  late final NavigationBarActionTypeState leadingActionTypeState;
  late final TrailingActionTypeState trailingActionTypeState;
  late final LeadingActionSelectedState leadingActionState;
  late final TrailingActionSelectedState trailingActionState;

  // Cupertino
  late final PreviousTitleTextState previousTitleTextState;

  @override
  void initState() {
    super.initState();
    //Material
    iconTypeState = NavigationIconTypeState(setState);
    actionIconBadgeState = ActionIconBadgeState(setState);
    actionAvatarState = ActionAvatarState(setState);
    actionAvatarMonogramTextState = ActionAvatarMonogramTextState(setState);
    expandedHeightTextState = ExpandedHeightState(setState);
    titleMaxLinesTextState = TitleMaxLinesState(setState);
    actionSelectedState = ActionSelectedState(setState);
    showAvatarState = ShowAvatarState(setState);

    //Common
    sizeState = SizeState(setState);
    titleTextState = TitleTextState(setState);
    leadingActionTypeState = NavigationBarActionTypeState(setState);
    trailingActionTypeState = TrailingActionTypeState(setState);
    leadingActionState = LeadingActionSelectedState(setState);
    trailingActionState = TrailingActionSelectedState(setState);

    //Cupertino
    previousTitleTextState = PreviousTitleTextState(setState);
  }

  //Proxy getters and setters for size type state management
  TopBarSizeEnum get selectedSize => sizeState.selected;
  set selectedSize(TopBarSizeEnum value) {
    sizeState.selected = value;
  }

  // Getter and setter for icon type state management
  NavigationIconTypeEnum get selectedIconType => iconTypeState.selected;
  set selectedIconType(NavigationIconTypeEnum value) {
    iconTypeState.selected = value;
  }

  // Getter and setter for action icon badge state management
  ActionIconBadgeEnum get selectedIconBadge => actionIconBadgeState.selected;
  set selectedIconBadge(ActionIconBadgeEnum value) {
    actionIconBadgeState.selected = value;
  }

  // Getter and setter for title text state management
  String get titleText => titleTextState.value;
  set titleText(String value) => titleTextState.value = value;

  // Getter and setter for expanded height state management
  String get expandedHeightText => expandedHeightTextState.value;
  set expandedHeightText(String value) => expandedHeightTextState.value = value;

  // Getter and setter for title line count text
  int get maxLinesSelected => titleMaxLinesTextState.value;
  set maxLinesSelected(int value) => titleMaxLinesTextState.value = value;

  // Getter and setter for action avatar state management
  ActionAvatarEnum get selectedActionAvatar => actionAvatarState.selected;
  set selectedActionAvatar(ActionAvatarEnum value) {
    actionAvatarState.selected = value;
  }

  // Getter and setter for action avatar monogram text state management
  String? get actionAvatarMonogramText => actionAvatarMonogramTextState.value;
  set actionAvatarMonogramText(String? value) => actionAvatarMonogramTextState.value = value;

  // Proxy getters and setters to expose the 'actionCountTextState' value directly.
  int get actionSelected => actionSelectedState.value;
  set actionSelected(int value) => actionSelectedState.value = value;

  bool get showAvatar => showAvatarState.value;
  set showAvatar(bool value) => showAvatarState.value = value;

  // IOS section
  // leading action type State Management
  ToolbarTopActionTypeEnum get selectedLeadingActionType => leadingActionTypeState.selected;

  set selectedLeadingActionType(ToolbarTopActionTypeEnum value) {
    leadingActionTypeState.selected = value;
  }

  // trailing action type State Management
  ToolbarTopActionTypeEnum get selectedTrailingActionType => trailingActionTypeState.selected;

  set selectedTrailingActionType(ToolbarTopActionTypeEnum value) {
    trailingActionTypeState.selected = value;
  }

  // leading action State Management
  int get selectedLeadingActionCount => leadingActionState.value;

  set selectedLeadingActionCount(int value) {
    leadingActionState.value = value;
  }

  // trailing action State Management
  int get selectedTrailingActionCount => trailingActionState.value;

  set selectedTrailingActionCount(int value) {
    trailingActionState.value = value;
  }

  // Getter and setter for previous title text state management
  String get previousTitleText => previousTitleTextState.value;
  set previousTitleText(String value) => previousTitleTextState.value = value;

  @override
  Widget build(BuildContext context) {
    return _TopBarCustomization(
      data: this,
      child: widget.child,
    );
  }
}


///  Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<TopBarSizeEnum> _size = [
    TopBarSizeEnum.small,
    TopBarSizeEnum.medium,
    TopBarSizeEnum.large,
  ];
  TopBarSizeEnum _selectedSize = TopBarSizeEnum.small;

  List<TopBarSizeEnum> get list => _size;
  set list(List<TopBarSizeEnum> newList) {
    _setState(() {
      _size = newList;
    });
  }

  TopBarSizeEnum get selected => _selectedSize;
  set selected(TopBarSizeEnum newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// Status State Management
class ActionIconBadgeState {
  ActionIconBadgeState(this._setActionIconBadgeState);

  late final void Function(void Function()) _setActionIconBadgeState;

  List<ActionIconBadgeEnum> _actionIconBadgeList = [
    ActionIconBadgeEnum.none,
    ActionIconBadgeEnum.dot,
    ActionIconBadgeEnum.count,

  ];

  ActionIconBadgeEnum _selectedStatus = ActionIconBadgeEnum.none;

  List<ActionIconBadgeEnum> get list => _actionIconBadgeList;
  set list(List<ActionIconBadgeEnum> newList) {
    _setActionIconBadgeState(() {
      _actionIconBadgeList = newList;
    });
  }

  ActionIconBadgeEnum get selected => _selectedStatus;
  set selected(ActionIconBadgeEnum newValue) {
    _setActionIconBadgeState(() {
      _selectedStatus = newValue;
    });
  }

}

///  navigation icon type Management
class NavigationIconTypeState {
  NavigationIconTypeState(this._setIconType);

  final void Function(void Function()) _setIconType;

  List<NavigationIconTypeEnum> _iconType = [
    NavigationIconTypeEnum.none,
    NavigationIconTypeEnum.back,
    NavigationIconTypeEnum.close,
    NavigationIconTypeEnum.menu,
    NavigationIconTypeEnum.custom,

  ];
  NavigationIconTypeEnum _selectedType = NavigationIconTypeEnum.none;

  List<NavigationIconTypeEnum> get list => _iconType;
  set list(List<NavigationIconTypeEnum> newList) {
    _setIconType(() {
      _iconType = newList;
    });
  }

  NavigationIconTypeEnum get selected => _selectedType;
  set selected(NavigationIconTypeEnum newValue) {
    _setIconType(() {
      _selectedType = newValue;
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

/// ExpandedHeader State Management
class ExpandedHeightState {
  ExpandedHeightState(this._setState);

  final void Function(void Function()) _setState;
  String _headerValue = "";

  String get value => _headerValue;
  set value(String newValue) {
    _setState(() {
      _headerValue = newValue;
    });
  }
}

/// Title Line Count State Management
class TitleMaxLinesState {
  TitleMaxLinesState(this._setState);

  final void Function(void Function()) _setState;
  int _titleLineCountValue = 1;

  int get value => _titleLineCountValue;
  set value(int newValue) {
    _setState(() {
      _titleLineCountValue = newValue;
    });
  }
}

///  Action avatar type Management
class ActionAvatarState {
  ActionAvatarState(this._setActionAvatarState);

  late final void Function(void Function()) _setActionAvatarState;

  List<ActionAvatarEnum> _actionAvatarList = [
    ActionAvatarEnum.image,
    ActionAvatarEnum.monogram,
  ];

  ActionAvatarEnum _selectedStatus = ActionAvatarEnum.image;

  List<ActionAvatarEnum> get list => _actionAvatarList;
  set list(List<ActionAvatarEnum> newList) {
    _setActionAvatarState(() {
      _actionAvatarList = newList;
    });
  }

  ActionAvatarEnum get selected => _selectedStatus;
  set selected(ActionAvatarEnum newValue) {
    _setActionAvatarState(() {
      _selectedStatus = newValue;
    });
  }
}

/// Action avatar monogram text State Management
class ActionAvatarMonogramTextState {
  ActionAvatarMonogramTextState(this._setState);

  final void Function(void Function()) _setState;
  String? _monogramTextValue = "A";

  String? get value => _monogramTextValue;
  set value(String? newValue) {
    _setState(() {
      _monogramTextValue = newValue;
    });
  }
}

/// Simple state holder for the selected action index.
class ActionSelectedState {
  ActionSelectedState(this._setState);

  final void Function(void Function()) _setState;
  int _actionCountValue = 1;

  int get value => _actionCountValue;

  set value(int newValue) {
    _setState(() {
      _actionCountValue = newValue;
    });
  }
}

class ShowAvatarState {
  ShowAvatarState(this._setState);

  final void Function(void Function()) _setState;
  bool _isAvatarVisible = true;

  bool get value => _isAvatarVisible;

  set value(bool newValue) {
    _setState(() {
      _isAvatarVisible = newValue;
    });
  }
}

// ios section
///  navigation icon type Management
class NavigationBarActionTypeState {
  NavigationBarActionTypeState(this._setLeadingActionType);

  final void Function(void Function()) _setLeadingActionType;

  List<ToolbarTopActionTypeEnum> _leadingActionType = [
    ToolbarTopActionTypeEnum.none,
    ToolbarTopActionTypeEnum.back,
    ToolbarTopActionTypeEnum.icon,
    ToolbarTopActionTypeEnum.text
  ];

  ToolbarTopActionTypeEnum _selectedType =
      ToolbarTopActionTypeEnum.back;

  List<ToolbarTopActionTypeEnum> get list => _leadingActionType;
  set list(List<ToolbarTopActionTypeEnum> newList) {
    _setLeadingActionType(() {
      _leadingActionType = newList;
    });
  }

  ToolbarTopActionTypeEnum get selected => _selectedType;
  set selected(ToolbarTopActionTypeEnum newValue) {
    _setLeadingActionType(() {
      _selectedType = newValue;
    });
  }
}///  navigation icon type Management
class TrailingActionTypeState {
  TrailingActionTypeState(this._setTrailingActionType);

  final void Function(void Function()) _setTrailingActionType;

  List<ToolbarTopActionTypeEnum> _trailingActionType = [
    ToolbarTopActionTypeEnum.none,
    ToolbarTopActionTypeEnum.icon,
    ToolbarTopActionTypeEnum.text,

  ];
  ToolbarTopActionTypeEnum _selectedTrailingType =
      ToolbarTopActionTypeEnum.icon;

  List<ToolbarTopActionTypeEnum> get list => _trailingActionType;
  set list(List<ToolbarTopActionTypeEnum> newList) {
    _setTrailingActionType(() {
      _trailingActionType = newList;
    });
  }

  ToolbarTopActionTypeEnum get selected => _selectedTrailingType;
  set selected(ToolbarTopActionTypeEnum newValue) {
    _setTrailingActionType(() {
      _selectedTrailingType = newValue;
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

/// Simple state holder for the selected action index.
class LeadingActionSelectedState {
  LeadingActionSelectedState(this._setState);

  final void Function(void Function()) _setState;
  int _countTextValue = 1;

  int get value => _countTextValue;

  set value(int newValue) {
    _setState(() {
      _countTextValue = newValue;
    });
  }
}

/// Simple state holder for the selected action index.
class TrailingActionSelectedState {
  TrailingActionSelectedState(this._setState);

  final void Function(void Function()) _setState;
  int _countTextValue = 1;

  int get value => _countTextValue;

  set value(int newValue) {
    _setState(() {
      _countTextValue = newValue;
    });
  }
}
/// PreviousTitle State Management
class PreviousTitleTextState {
  PreviousTitleTextState(this._setState);

  final void Function(void Function()) _setState;
  String _previousTextValue = "Label";

  String get value => _previousTextValue;
  set value(String newValue) {
    _setState(() {
      _previousTextValue = newValue;
    });
  }
}