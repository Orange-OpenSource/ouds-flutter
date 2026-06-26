/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

class _ListItemCustomization extends InheritedWidget {
  const _ListItemCustomization({required super.child, required this.data});

  final ListItemCustomizationState data;

  @override
  bool updateShouldNotify(_ListItemCustomization oldWidget) => true;
}

class ListItemCustomization extends StatefulWidget {
  const ListItemCustomization({super.key, required this.child});

  final Widget child;

  @override
  ListItemCustomizationState createState() => ListItemCustomizationState();

  static ListItemCustomizationState? of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_ListItemCustomization>())
        ?.data;
  }
}

class ListItemCustomizationState
    extends CustomizationWidgetState<ListItemCustomization> {
  late final LabelTextState labelTextState;
  late final OverlineTextState overlineTextState;
  late final ExtraLabelTextState extraLabelTextState;
  late final DescriptionTextState descriptionTextState;
  late final HelperTextState helperTextState;
  late final SizeState sizeState;
  late final ContentAlignmentState contentAlignmentState;
  late final LeadingState leadingState;
  late final TrailingState trailingState;
  late final IconStatusState iconStatusState;
  late final DividerState dividerState;
  late final BackgroundState backgroundState;
  late final BoldLabelState boldLabelState;

  @override
  void initState() {
    super.initState();
    labelTextState = LabelTextState(setState);
    overlineTextState = OverlineTextState(setState);
    extraLabelTextState = ExtraLabelTextState(setState);
    descriptionTextState = DescriptionTextState(setState);
    helperTextState = HelperTextState(setState);
    sizeState = SizeState(setState);
    contentAlignmentState = ContentAlignmentState(setState);
    leadingState = LeadingState(setState);
    trailingState = TrailingState(setState);
    iconStatusState = IconStatusState(setState);
    dividerState = DividerState(setState);
    backgroundState = BackgroundState(setState);
    boldLabelState = BoldLabelState(setState);
  }

  String get label => labelTextState.value;
  set label(String value) => labelTextState.value = value;

  String get overline => overlineTextState.value;
  set overline(String value) => overlineTextState.value = value;

  String get extraLabel => extraLabelTextState.value;
  set extraLabel(String value) => extraLabelTextState.value = value;

  String get description => descriptionTextState.value;
  set description(String value) => descriptionTextState.value = value;

  String get helperText => helperTextState.value;
  set helperText(String value) => helperTextState.value = value;

  ListItemContentAlignmentEnum get contentAlignment =>
      contentAlignmentState.selected;
  set contentAlignment(ListItemContentAlignmentEnum value) =>
      contentAlignmentState.selected = value;

  ListItemSizeEnum get size => sizeState.selected;
  set size(ListItemSizeEnum value) => sizeState.selected = value;

  ListItemLeadingEnum get leading => leadingState.selected;
  set leading(ListItemLeadingEnum value) => leadingState.selected = value;

  ListItemTrailingEnum get trailing => trailingState.selected;
  set trailing(ListItemTrailingEnum value) => trailingState.selected = value;

  StatusEnum get iconStatus => iconStatusState.selected;
  set iconStatus(StatusEnum value) => iconStatusState.selected = value;

  int get iconStatusIndex => iconStatusState.index;

  bool get divider => dividerState.value;
  set divider(bool value) => dividerState.value = value;

  bool get background => backgroundState.value;
  set background(bool value) => backgroundState.value = value;

  bool get boldLabel => boldLabelState.value;
  set boldLabel(bool value) => boldLabelState.value = value;

  bool get enable => hasEnabled;
  set enable(bool value) => hasEnabled = value;

  @override
  Widget build(BuildContext context) {
    return _ListItemCustomization(data: this, child: widget.child);
  }
}

class LabelTextState {
  LabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _value = 'Label';

  String get value => _value;
  set value(String newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class OverlineTextState {
  OverlineTextState(this._setState);

  final void Function(void Function()) _setState;
  String _value = '';

  String get value => _value;
  set value(String newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class ExtraLabelTextState {
  ExtraLabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _value = '';

  String get value => _value;
  set value(String newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class DescriptionTextState {
  DescriptionTextState(this._setState);

  final void Function(void Function()) _setState;
  String _value = '';

  String get value => _value;
  set value(String newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class HelperTextState {
  HelperTextState(this._setState);

  final void Function(void Function()) _setState;
  String _value = '';

  String get value => _value;
  set value(String newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class ContentAlignmentState {
  ContentAlignmentState(this._setState);

  final void Function(void Function()) _setState;
  ListItemContentAlignmentEnum _selected = ListItemContentAlignmentEnum.center;
  final List<ListItemContentAlignmentEnum> list =
      ListItemContentAlignmentEnum.values;

  ListItemContentAlignmentEnum get selected => _selected;
  set selected(ListItemContentAlignmentEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;
  ListItemSizeEnum _selected = ListItemSizeEnum.defaultSize;
  final List<ListItemSizeEnum> list = ListItemSizeEnum.values;

  ListItemSizeEnum get selected => _selected;
  set selected(ListItemSizeEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class LeadingState {
  LeadingState(this._setState);

  final void Function(void Function()) _setState;
  ListItemLeadingEnum _selected = ListItemLeadingEnum.icon;
  final List<ListItemLeadingEnum> list = ListItemLeadingEnum.values;

  ListItemLeadingEnum get selected => _selected;
  set selected(ListItemLeadingEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class TrailingState {
  TrailingState(this._setState);

  final void Function(void Function()) _setState;
  ListItemTrailingEnum _selected = ListItemTrailingEnum.none;
  final List<ListItemTrailingEnum> list = ListItemTrailingEnum.values;

  ListItemTrailingEnum get selected => _selected;
  set selected(ListItemTrailingEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class IconStatusState {
  IconStatusState(this._setState);

  final void Function(void Function()) _setState;
  StatusEnum _selected = StatusEnum.neutral;
  int _index = StatusEnum.values.indexOf(StatusEnum.neutral);
  final List<StatusEnum> list = StatusEnum.values;

  StatusEnum get selected => _selected;
  int get index => _index;

  set selected(StatusEnum newValue) {
    _setState(() {
      _selected = newValue;
      _index = list.indexOf(newValue);
    });
  }
}

class DividerState {
  DividerState(this._setState);

  final void Function(void Function()) _setState;
  bool _value = true;

  bool get value => _value;
  set value(bool newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class BackgroundState {
  BackgroundState(this._setState);

  final void Function(void Function()) _setState;
  bool _value = false;

  bool get value => _value;
  set value(bool newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class BoldLabelState {
  BoldLabelState(this._setState);

  final void Function(void Function()) _setState;
  bool _value = false;

  bool get value => _value;
  set value(bool newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}
