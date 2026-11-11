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
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/tinted_enum.dart';

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
  late final TextState labelTextState;
  late final TextState overlineTextState;
  late final TextState extraLabelTextState;
  late final TextState descriptionTextState;
  late final TextState helperTextState;
  late final BoolState belowTextContentEnabledState;
  late final BoolState bottomContentEnabledState;
  late final BoolState labelContentEnabledState;
  late final ContentAlignmentState contentAlignmentState;
  late final LeadingState leadingState;
  late final TrailingState trailingState;
  late final IconStatusState leadingIconStatusState;
  late final IconStatusState trailingIconStatusState;
  late final BoolState dividerState;
  late final BoolState backgroundState;
  late final BoolState boldLabelState;
  late final IndicatorState indicatorState;
  late final ImageSizeState leadingImageSizeState;
  late final ImageSizeState trailingImageSizeState;
  late final ImageFormatState leadingImageFormatState;
  late final ImageFormatState trailingImageFormatState;
  late final BoolState leadingImageRoundedState;
  late final BoolState trailingImageRoundedState;
  late final IconSizeState leadingIconSizeState;
  late final IconSizeState trailingIconSizeState;
  late final TextState trailingTextLabelState;
  late final TextState trailingTextExtraLabelState;
  late final TrailingTextStyleState trailingTextStyleState;
  late final CardDecorationState cardDecorationState;
  late final BoolState clickableState;
  late final GenericEnumState<BadgeEnumType> trailingBadgeTypeState;
  late final GenericEnumState<BadgeEnumSize> trailingBadgeSizeState;
  late final IconStatusState trailingBadgeStatusState;
  late final TextState trailingBadgeCountTextState;
  late final BoolState trailingBadgeEnabledState;
  late final GenericEnumState<TagEnumAppearance> trailingTagAppearanceState;
  late final GenericEnumState<TagEnumSize> trailingTagSizeState;
  late final GenericEnumState<TagEnumLayout> trailingTagLayoutState;
  late final IconStatusState trailingTagStatusState;
  late final TextState trailingTagLabelTextState;
  late final BoolState trailingTagLoaderState;
  late final BoolState trailingTagRoundedCornersState;
  late final BoolState trailingTagEnabledState;
  late final TintedState leadingIconTintedState;
  late final TintedState trailingIconTintedState;

  @override
  void initState() {
    super.initState();
    labelTextState = TextState(setState, initial: 'Label');
    overlineTextState = TextState(setState);
    extraLabelTextState = TextState(setState);
    descriptionTextState = TextState(setState);
    helperTextState = TextState(setState);
    belowTextContentEnabledState = BoolState(setState);
    bottomContentEnabledState = BoolState(setState);
    labelContentEnabledState = BoolState(setState);
    contentAlignmentState = ContentAlignmentState(setState);
    leadingState = LeadingState(setState);
    trailingState = TrailingState(setState);
    leadingIconStatusState = IconStatusState(setState, excludeAccent: true);
    trailingIconStatusState = IconStatusState(setState, excludeAccent: true);
    dividerState = BoolState(setState, initial: true);
    backgroundState = BoolState(setState);
    boldLabelState = BoolState(setState);
    indicatorState = IndicatorState(setState);
    leadingImageSizeState = ImageSizeState(setState);
    trailingImageSizeState = ImageSizeState(setState);
    leadingImageFormatState = ImageFormatState(setState);
    trailingImageFormatState = ImageFormatState(setState);
    leadingImageRoundedState = BoolState(setState);
    trailingImageRoundedState = BoolState(setState);
    leadingIconSizeState = IconSizeState(setState);
    trailingIconSizeState = IconSizeState(setState);
    trailingTextLabelState = TextState(setState, initial: 'Label');
    trailingTextExtraLabelState = TextState(setState, initial: 'Extra label');
    trailingTextStyleState = TrailingTextStyleState(setState);
    cardDecorationState = CardDecorationState(setState);
    clickableState = BoolState(setState);
    trailingBadgeTypeState = GenericEnumState<BadgeEnumType>(
      setState,
      list: BadgeEnumType.values,
      initial: BadgeEnumType.count,
    );
    trailingBadgeSizeState = GenericEnumState<BadgeEnumSize>(
      setState,
      list: BadgeEnumSize.values,
      initial: BadgeEnumSize.large,
    );
    trailingBadgeStatusState = IconStatusState(
      setState,
      initial: StatusEnum.negative,
    );
    trailingBadgeCountTextState = TextState(setState, initial: '1');
    trailingBadgeEnabledState = BoolState(setState, initial: true);
    trailingTagAppearanceState = GenericEnumState<TagEnumAppearance>(
      setState,
      list: TagEnumAppearance.values,
      initial: TagEnumAppearance.emphasized,
    );
    trailingTagSizeState = GenericEnumState<TagEnumSize>(
      setState,
      list: TagEnumSize.values,
      initial: TagEnumSize.small,
    );
    trailingTagLayoutState = GenericEnumState<TagEnumLayout>(
      setState,
      list: TagEnumLayout.values,
      initial: TagEnumLayout.textOnly,
    );
    trailingTagStatusState = IconStatusState(setState);
    trailingTagLabelTextState = TextState(setState, initial: 'Label');
    trailingTagLoaderState = BoolState(setState);
    trailingTagRoundedCornersState = BoolState(setState, initial: true);
    trailingTagEnabledState = BoolState(setState, initial: true);
    leadingIconTintedState = TintedState(setState);
    trailingIconTintedState = TintedState(setState);
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

  bool get belowTextContentEnabled => belowTextContentEnabledState.value;
  set belowTextContentEnabled(bool value) =>
      belowTextContentEnabledState.value = value;

  bool get bottomContentEnabled => bottomContentEnabledState.value;
  set bottomContentEnabled(bool value) =>
      bottomContentEnabledState.value = value;

  bool get labelContentEnabled => labelContentEnabledState.value;
  set labelContentEnabled(bool value) => labelContentEnabledState.value = value;

  ListItemContentAlignmentEnum get contentAlignment =>
      contentAlignmentState.selected;
  set contentAlignment(ListItemContentAlignmentEnum value) =>
      contentAlignmentState.selected = value;

  ListItemLeadingEnum get leading => leadingState.selected;
  set leading(ListItemLeadingEnum value) => leadingState.selected = value;

  ListItemTrailingEnum get trailing => trailingState.selected;
  set trailing(ListItemTrailingEnum value) => trailingState.selected = value;

  StatusEnum get leadingIconStatus => leadingIconStatusState.selected;
  set leadingIconStatus(StatusEnum value) {
    leadingIconStatusState.selected = value;
  }

  StatusEnum get trailingIconStatus => trailingIconStatusState.selected;
  set trailingIconStatus(StatusEnum value) {
    trailingIconStatusState.selected = value;
  }

  bool get divider => dividerState.value;
  set divider(bool value) => dividerState.value = value;

  bool get background => backgroundState.value;
  set background(bool value) => backgroundState.value = value;

  bool get boldLabel => boldLabelState.value;
  set boldLabel(bool value) => boldLabelState.value = value;

  ListItemIndicatorEnum get indicator => indicatorState.selected;
  set indicator(ListItemIndicatorEnum value) => indicatorState.selected = value;

  ListItemImageSizeEnum get leadingImageSize => leadingImageSizeState.selected;
  set leadingImageSize(ListItemImageSizeEnum value) {
    leadingImageSizeState.selected = value;
  }

  ListItemImageSizeEnum get trailingImageSize =>
      trailingImageSizeState.selected;
  set trailingImageSize(ListItemImageSizeEnum value) {
    trailingImageSizeState.selected = value;
  }

  ListItemImageFormatEnum get leadingImageFormat =>
      leadingImageFormatState.selected;
  set leadingImageFormat(ListItemImageFormatEnum value) {
    leadingImageFormatState.selected = value;
  }

  ListItemImageFormatEnum get trailingImageFormat =>
      trailingImageFormatState.selected;
  set trailingImageFormat(ListItemImageFormatEnum value) {
    trailingImageFormatState.selected = value;
  }

  bool get leadingImageRounded => leadingImageRoundedState.value;
  set leadingImageRounded(bool value) {
    leadingImageRoundedState.value = value;
  }

  bool get trailingImageRounded => trailingImageRoundedState.value;
  set trailingImageRounded(bool value) {
    trailingImageRoundedState.value = value;
  }

  ListItemIconSizeEnum get leadingIconSize => leadingIconSizeState.selected;
  set leadingIconSize(ListItemIconSizeEnum value) {
    leadingIconSizeState.selected = value;
  }

  ListItemIconSizeEnum get trailingIconSize => trailingIconSizeState.selected;
  set trailingIconSize(ListItemIconSizeEnum value) {
    trailingIconSizeState.selected = value;
  }

  String get trailingTextLabel => trailingTextLabelState.value;
  set trailingTextLabel(String value) => trailingTextLabelState.value = value;

  String get trailingTextExtraLabel => trailingTextExtraLabelState.value;
  set trailingTextExtraLabel(String value) =>
      trailingTextExtraLabelState.value = value;

  ListItemTrailingTextStyleEnum get trailingTextStyle =>
      trailingTextStyleState.selected;
  set trailingTextStyle(ListItemTrailingTextStyleEnum value) =>
      trailingTextStyleState.selected = value;

  bool get clickable => clickableState.value;
  set clickable(bool value) => clickableState.value = value;

  ListItemCardDecorationEnum get cardDecoration => cardDecorationState.selected;
  set cardDecoration(ListItemCardDecorationEnum value) =>
      cardDecorationState.selected = value;

  BadgeEnumType get trailingBadgeType => trailingBadgeTypeState.selected;
  set trailingBadgeType(BadgeEnumType value) =>
      trailingBadgeTypeState.selected = value;

  BadgeEnumSize get trailingBadgeSize => trailingBadgeSizeState.selected;
  set trailingBadgeSize(BadgeEnumSize value) =>
      trailingBadgeSizeState.selected = value;

  StatusEnum get trailingBadgeStatus => trailingBadgeStatusState.selected;
  set trailingBadgeStatus(StatusEnum value) =>
      trailingBadgeStatusState.selected = value;

  String get trailingBadgeCount => trailingBadgeCountTextState.value;
  set trailingBadgeCount(String value) =>
      trailingBadgeCountTextState.value = value;

  bool get trailingBadgeEnabled => trailingBadgeEnabledState.value;
  set trailingBadgeEnabled(bool value) =>
      trailingBadgeEnabledState.value = value;

  TagEnumAppearance get trailingTagAppearance =>
      trailingTagAppearanceState.selected;
  set trailingTagAppearance(TagEnumAppearance value) =>
      trailingTagAppearanceState.selected = value;

  TagEnumSize get trailingTagSize => trailingTagSizeState.selected;
  set trailingTagSize(TagEnumSize value) =>
      trailingTagSizeState.selected = value;

  TagEnumLayout get trailingTagLayout => trailingTagLayoutState.selected;
  set trailingTagLayout(TagEnumLayout value) =>
      trailingTagLayoutState.selected = value;

  StatusEnum get trailingTagStatus => trailingTagStatusState.selected;
  set trailingTagStatus(StatusEnum value) =>
      trailingTagStatusState.selected = value;

  String get trailingTagLabel => trailingTagLabelTextState.value;
  set trailingTagLabel(String value) => trailingTagLabelTextState.value = value;

  bool get trailingTagLoader => trailingTagLoaderState.value;
  set trailingTagLoader(bool value) => trailingTagLoaderState.value = value;

  bool get trailingTagRoundedCorners => trailingTagRoundedCornersState.value;
  set trailingTagRoundedCorners(bool value) =>
      trailingTagRoundedCornersState.value = value;

  bool get trailingTagEnabled => trailingTagEnabledState.value;
  set trailingTagEnabled(bool value) => trailingTagEnabledState.value = value;

  bool get enable => hasEnabled;
  set enable(bool value) => hasEnabled = value;

  bool get leadingIconTinted =>
      leadingIconTintedState.selected == TintedEnum.tinted;

  TintedEnum get selectedLeadingTinted => leadingIconTintedState.selected;
  set selectedLeadingTinted(TintedEnum value) =>
      leadingIconTintedState.selected = value;

  bool get trailingIconTinted =>
      trailingIconTintedState.selected == TintedEnum.tinted;

  TintedEnum get selectedTrailingTinted => trailingIconTintedState.selected;
  set selectedTrailingTinted(TintedEnum value) =>
      trailingIconTintedState.selected = value;

  @override
  Widget build(BuildContext context) {
    return _ListItemCustomization(data: this, child: widget.child);
  }
}

class TextState {
  TextState(this._setState, {String initial = ''}) : _value = initial;

  final void Function(void Function()) _setState;
  String _value;

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

class LeadingState {
  LeadingState(this._setState);

  final void Function(void Function()) _setState;
  ListItemLeadingEnum _selected = ListItemLeadingEnum.none;
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
  IconStatusState(
    this._setState, {
    StatusEnum initial = StatusEnum.neutral,
    // Accent is not supported by list item icon slots, but is by badge and tag.
    bool excludeAccent = false,
  }) : _selected = initial,
       list = List.unmodifiable(
         excludeAccent
             ? StatusEnum.values.where((status) => status != StatusEnum.accent)
             : StatusEnum.values,
       );

  final void Function(void Function()) _setState;
  StatusEnum _selected;
  final List<StatusEnum> list;

  StatusEnum get selected => _selected;

  set selected(StatusEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class BoolState {
  BoolState(this._setState, {bool initial = false}) : _value = initial;

  final void Function(void Function()) _setState;
  bool _value;

  bool get value => _value;
  set value(bool newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

class IndicatorState {
  IndicatorState(this._setState);

  final void Function(void Function()) _setState;
  ListItemIndicatorEnum _selected = ListItemIndicatorEnum.next;
  final List<ListItemIndicatorEnum> list = ListItemIndicatorEnum.values;

  ListItemIndicatorEnum get selected => _selected;
  set selected(ListItemIndicatorEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class ImageSizeState {
  ImageSizeState(this._setState);

  final void Function(void Function()) _setState;
  ListItemImageSizeEnum _selected = ListItemImageSizeEnum.medium;
  final List<ListItemImageSizeEnum> list = ListItemImageSizeEnum.values;

  ListItemImageSizeEnum get selected => _selected;
  set selected(ListItemImageSizeEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class ImageFormatState {
  ImageFormatState(this._setState);

  final void Function(void Function()) _setState;
  ListItemImageFormatEnum _selected = ListItemImageFormatEnum.square;
  final List<ListItemImageFormatEnum> list = ListItemImageFormatEnum.values;

  ListItemImageFormatEnum get selected => _selected;
  set selected(ListItemImageFormatEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class TrailingTextStyleState {
  TrailingTextStyleState(this._setState);

  final void Function(void Function()) _setState;
  ListItemTrailingTextStyleEnum _selected = ListItemTrailingTextStyleEnum.label;
  final List<ListItemTrailingTextStyleEnum> list =
      ListItemTrailingTextStyleEnum.values;

  ListItemTrailingTextStyleEnum get selected => _selected;
  set selected(ListItemTrailingTextStyleEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class IconSizeState {
  IconSizeState(this._setState);

  final void Function(void Function()) _setState;
  ListItemIconSizeEnum _selected = ListItemIconSizeEnum.medium;
  final List<ListItemIconSizeEnum> list = ListItemIconSizeEnum.values;

  ListItemIconSizeEnum get selected => _selected;
  set selected(ListItemIconSizeEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

class CardDecorationState {
  CardDecorationState(this._setState);

  final void Function(void Function()) _setState;
  ListItemCardDecorationEnum _selected = ListItemCardDecorationEnum.background;
  final List<ListItemCardDecorationEnum> list =
      ListItemCardDecorationEnum.values;

  ListItemCardDecorationEnum get selected => _selected;
  set selected(ListItemCardDecorationEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// Generic selection state for a simple enum, used for list item trailing
/// badge/tag customization (type, size, appearance, layout …).
class GenericEnumState<T> {
  GenericEnumState(this._setState, {required this.list, required T initial})
    : _selected = initial;

  final void Function(void Function()) _setState;
  final List<T> list;
  T _selected;

  T get selected => _selected;
  set selected(T newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}
