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
import 'package:ouds_flutter_demo/ui/components/alert/alert_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _AlertCustomization extends InheritedWidget {
  const _AlertCustomization({required super.child, required this.data});

  final AlertCustomizationState data;

  @override
  bool updateShouldNotify(_AlertCustomization oldWidget) => true;
}

/// Main Widget class for Alert customization
class AlertCustomization extends StatefulWidget {
  const AlertCustomization({super.key, required this.child});

  final Widget child;

  @override
  AlertCustomizationState createState() => AlertCustomizationState();

  /// The state from the closest instance of this class that encloses the given context.
  static AlertCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_AlertCustomization>())
        ?.data;
  }
}

/// State for [AlertCustomization].
class AlertCustomizationState
    extends CustomizationWidgetState<AlertCustomization> {
  late final StatusState statusState;
  late final LabelTextState labelTextState;
  late final DescriptionTextState descriptionTextState;
  late final BulletTextOneState bulletTextOneState;
  late final BulletTextTwoState bulletTextTwoState;
  late final BulletTextThreeState bulletTextThreeState;
  late final ActionLinkTextState actionLinkTextState;
  late final RoundedCornerState roundedCornerState;
  late final CloseButtonState closeButtonState;
  late final IconStatusState iconStatusState;
  late final ActionLinkPositionState actionLinkPositionState;

  @override
  void initState() {
    super.initState();
    statusState = StatusState(setState);
    labelTextState = LabelTextState(setState);
    descriptionTextState = DescriptionTextState(setState);
    bulletTextOneState = BulletTextOneState(setState);
    bulletTextTwoState = BulletTextTwoState(setState);
    bulletTextThreeState = BulletTextThreeState(setState);
    actionLinkTextState = ActionLinkTextState(setState);
    roundedCornerState = RoundedCornerState(setState);
    closeButtonState = CloseButtonState(setState);
    iconStatusState = IconStatusState(setState);
    actionLinkPositionState = ActionLinkPositionState(setState);
  }

  // Proxy getters and setters to expose state values directly
  StatusEnum get selectedStatus => statusState.selectedStatus;
  set selectedStatus(StatusEnum value) => statusState.selectedStatus = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get label => labelTextState.value;
  set label(String value) => labelTextState.value = value;

  String get description => descriptionTextState.value;
  set description(String value) => descriptionTextState.value = value;

  String get bulletTextOne => bulletTextOneState.value;
  set bulletTextOne(String value) => bulletTextOneState.value = value;

  String get bulletTextTwo => bulletTextTwoState.value;
  set bulletTextTwo(String value) => bulletTextTwoState.value = value;

  String get bulletTextThree => bulletTextThreeState.value;
  set bulletTextThree(String value) => bulletTextThreeState.value = value;

  String get actionLink => actionLinkTextState.value;
  set actionLink(String value) => actionLinkTextState.value = value;

  int get selectedIndex => statusState.index;
  set selectedIndex(int value) => statusState.index = value;

  bool get hasRoundedCorner => roundedCornerState.value;
  set hasRoundedCorner(bool value) => roundedCornerState.value = value;

  bool get hasCloseButton => closeButtonState.value;
  set hasCloseButton(bool value) => closeButtonState.value = value;

  bool get hasIconStatus => iconStatusState.value;
  set hasIconStatus(bool value) => iconStatusState.value = value;

  ActionLinkPositionEnum get selectedActionLinkPosition =>
      actionLinkPositionState.selected;
  set selectedActionLinkPosition(ActionLinkPositionEnum value) =>
      actionLinkPositionState.selected = value;

  @override
  Widget build(BuildContext context) {
    return _AlertCustomization(data: this, child: widget.child);
  }
}

/// Status State Management
class StatusState {
  StatusState(this._setState);

  final void Function(void Function()) _setState;

  List<StatusEnum> _status = [
    StatusEnum.accent,
    StatusEnum.info,
    StatusEnum.negative,
    StatusEnum.neutral,
    StatusEnum.positive,
    StatusEnum.warning,
  ];

  StatusEnum _selectedStatus = StatusEnum.positive;
  int _selectedIndex = 4;

  List<StatusEnum> get list => _status;
  set list(List<StatusEnum> newList) {
    _setState(() {
      _status = newList;
    });
  }

  StatusEnum get selectedStatus => _selectedStatus;
  set selectedStatus(StatusEnum newValue) {
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

/// Label Text State Management
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

/// Description Text State Management
class DescriptionTextState {
  DescriptionTextState(this._setState);

  final void Function(void Function()) _setState;
  String _descriptionTextValue = "";

  String get value => _descriptionTextValue;
  set value(String newValue) {
    _setState(() {
      _descriptionTextValue = newValue;
    });
  }
}

/// bullet one Text State Management
class BulletTextOneState {
  BulletTextOneState(this._setState);

  final void Function(void Function()) _setState;
  String _bulletTextValue = "";

  String get value => _bulletTextValue;
  set value(String newValue) {
    _setState(() {
      _bulletTextValue = newValue;
    });
  }
}

/// bullet two Text State Management
class BulletTextTwoState {
  BulletTextTwoState(this._setState);

  final void Function(void Function()) _setState;
  String _bulletTextValue = "";

  String get value => _bulletTextValue;
  set value(String newValue) {
    _setState(() {
      _bulletTextValue = newValue;
    });
  }
}

/// bullet three Text State Management
class BulletTextThreeState {
  BulletTextThreeState(this._setState);

  final void Function(void Function()) _setState;
  String _bulletTextValue = "";

  String get value => _bulletTextValue;
  set value(String newValue) {
    _setState(() {
      _bulletTextValue = newValue;
    });
  }
}

/// Action link Text State Management
class ActionLinkTextState {
  ActionLinkTextState(this._setState);

  final void Function(void Function()) _setState;
  String _actionLinkTextValue = "";

  String get value => _actionLinkTextValue;
  set value(String newValue) {
    _setState(() {
      _actionLinkTextValue = newValue;
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

/// Loader State Management
class CloseButtonState {
  CloseButtonState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasCloseButtonState = false;

  bool get value => _hasCloseButtonState;
  set value(bool newValue) {
    _setState(() {
      _hasCloseButtonState = newValue;
    });
  }
}

/// Loader State Management
class IconStatusState {
  IconStatusState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasIconStatusState = true;

  bool get value => _hasIconStatusState;
  set value(bool newValue) {
    _setState(() {
      _hasIconStatusState = newValue;
    });
  }
}

/// Link action position State Management
class ActionLinkPositionState {
  ActionLinkPositionState(this._setState);

  final void Function(void Function()) _setState;

  List<ActionLinkPositionEnum> _actionLinkPositions = [
    ActionLinkPositionEnum.bottom,
    ActionLinkPositionEnum.topEnd,
  ];
  ActionLinkPositionEnum _selectedActionLinkPosition =
      ActionLinkPositionEnum.bottom;

  List<ActionLinkPositionEnum> get list => _actionLinkPositions;
  set list(List<ActionLinkPositionEnum> newList) {
    _setState(() {
      _actionLinkPositions = newList;
    });
  }

  ActionLinkPositionEnum get selected => _selectedActionLinkPosition;
  set selected(ActionLinkPositionEnum newValue) {
    _setState(() {
      _selectedActionLinkPosition = newValue;
    });
  }
}
