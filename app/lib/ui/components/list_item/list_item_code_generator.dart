// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';

/// Generates Flutter code snippets for both the static and navigation variants
/// of [OudsListItem] / [OudsSmallListItem], mirroring the current customization state.
///
/// Usage — static variant:
/// ```dart
/// Code(code: ListItemCodeGenerator.updateCode(context))
/// ```
///
/// Usage — navigation variant:
/// ```dart
/// Code(code: ListItemCodeGenerator.updateCode(context, navigation: true))
/// ```
class ListItemCodeGenerator {
  ListItemCodeGenerator._();

  /// Builds the code string for the current customization state.
  ///
  /// Set [navigation] to `true` for the navigation variant (adds [onTap] and [indicator]).
  static String updateCode(BuildContext context, {bool navigation = false}) {
    final state = ListItemCustomization.of(context)!;
    final isSmall = state.size == ListItemSizeEnum.small;

    return isSmall
        ? _smallCode(state, navigation: navigation)
        : _defaultCode(state, navigation: navigation);
  }

  /// Builds the parameter list for [OudsListItem] (default size).
  /// Optional params are omitted when they match the component's default value,
  /// so the generated snippet stays minimal and copy-paste ready.

  static String _defaultCode(
    ListItemCustomizationState state, {
    required bool navigation,
  }) {
    final params = <String>[
      "  label: '${state.label}',",
      if (state.size != ListItemSizeEnum.defaultSize)
        '  size: ${_sizeCode(state.size)},',
      if (state.contentAlignment != ListItemContentAlignmentEnum.center)
        '  contentAlignment: ${_alignmentCode(state.contentAlignment)},',
      if (state.overline.trim().isNotEmpty)
        "  overline: '${state.overline.trim()}',",
      if (state.extraLabel.trim().isNotEmpty)
        "  extraLabel: '${state.extraLabel.trim()}',",
      if (state.description.trim().isNotEmpty)
        "  description: '${state.description.trim()}',",
      if (state.leading != ListItemLeadingEnum.none)
        '  leading: ${_leadingCode(state.leading)},',
      if (state.trailing != ListItemTrailingEnum.none)
        '  trailing: ${_trailingCode(state.trailing)},',
      if (!state.divider) '  divider: false,',
      if (state.background) '  background: true,',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      // Navigation-specific params
      if (navigation) '  onTap: () { /* navigate */ },',
      if (navigation) '  indicator: ${_indicatorCode(state.indicator)},',
    ];

    return 'OudsListItem(\n${params.join('\n')}\n)';
  }

  /// Builds the parameter list for [OudsSmallListItem].
  /// Only params supported by the small variant are included (no overline / extraLabel).
  /// Leading and trailing are silently ignored if they fall outside [smallOptions].

  static String _smallCode(
    ListItemCustomizationState state, {
    required bool navigation,
  }) {
    final params = <String>[
      "  label: '${state.label}',",
      if (state.contentAlignment != ListItemContentAlignmentEnum.center)
        '  contentAlignment: ${_alignmentCode(state.contentAlignment)},',
      if (state.description.trim().isNotEmpty)
        "  description: '${state.description.trim()}',",
      if (state.leading != ListItemLeadingEnum.none &&
          ListItemLeadingEnum.smallOptions.contains(state.leading))
        '  leading: ${_smallLeadingCode(state.leading)},',
      if (state.trailing != ListItemTrailingEnum.none &&
          ListItemTrailingEnum.smallOptions.contains(state.trailing))
        '  trailing: ${_smallTrailingCode(state.trailing)},',
      if (!state.divider) '  divider: false,',
      '  background: ${state.background},',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      // Navigation-specific params
      if (navigation) '  onTap: () { /* navigate */ },',
      if (navigation) '  indicator: ${_indicatorCode(state.indicator)},',
    ];

    return 'OudsSmallListItem(\n${params.join('\n')}\n)';
  }

  /// Returns the Dart constructor string for each [OudsListItemLeading] type
  /// accepted by the full-size [OudsListItem] (icon, image, avatar, flag, video).

  static String _leadingCode(ListItemLeadingEnum leading) => switch (leading) {
    ListItemLeadingEnum.none => '',
    ListItemLeadingEnum.icon =>
      "OudsListItemLeadingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemLeadingEnum.image =>
      "OudsListItemLeadingImage(asset: AssetImage('assets/photo.png'))",
    ListItemLeadingEnum.avatar =>
      "OudsListItemLeadingAvatar(OudsAvatar(monogram: 'AB'))",
    ListItemLeadingEnum.flag =>
      "OudsListItemLeadingFlag(asset: AssetImage('assets/flag.png'))",
    ListItemLeadingEnum.video =>
      "OudsListItemLeadingVideo(Uri.parse('https://example.com/video.mp4'))",
  };

  static String _smallLeadingCode(
    ListItemLeadingEnum leading,
  ) => switch (leading) {
    ListItemLeadingEnum.icon =>
      "OudsSmallListItemLeadingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemLeadingEnum.image =>
      "OudsSmallListItemLeadingImage(asset: AssetImage('assets/photo.png'))",
    _ => '',
  };

  /// Returns the Dart constructor string for each [OudsListItemTrailing] type.
  /// Badge and tag use a builder lambda so the disabled state propagates correctly.

  static String _trailingCode(
    ListItemTrailingEnum trailing,
  ) => switch (trailing) {
    ListItemTrailingEnum.none => '',
    ListItemTrailingEnum.text =>
      "OudsListItemTrailingText(OudsListItemTrailingLabel('Label'))",
    ListItemTrailingEnum.badge =>
      "OudsListItemTrailingBadge(\n"
          "    (enable) => OudsBadge.standard(\n"
          "      status: Info(),\n"
          "      semanticsLabel: 'Info',\n"
          "      enabled: enable,\n"
          "    ),\n"
          "  )",
    ListItemTrailingEnum.tag =>
      "OudsListItemTrailingTag(\n"
          "    (enable) => OudsTag.text(\n"
          "      label: 'Label',\n"
          "      status: Positive(),\n"
          "      enabled: enable,\n"
          "    ),\n"
          "  )",
    ListItemTrailingEnum.icon =>
      "OudsListItemTrailingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemTrailingEnum.image =>
      "OudsListItemTrailingImage(asset: AssetImage('assets/photo.png'))",
    ListItemTrailingEnum.avatar =>
      "OudsListItemTrailingAvatar(OudsAvatar(monogram: 'AB'))",
    ListItemTrailingEnum.flag =>
      "OudsListItemTrailingFlag(asset: AssetImage('assets/flag.png'))",
    ListItemTrailingEnum.video =>
      "OudsListItemTrailingVideo(Uri.parse('https://example.com/video.mp4'))",
  };

  static String _smallTrailingCode(
    ListItemTrailingEnum trailing,
  ) => switch (trailing) {
    ListItemTrailingEnum.text => "OudsSmallListItemTrailingText('Label')",
    ListItemTrailingEnum.icon =>
      "OudsSmallListItemTrailingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemTrailingEnum.image =>
      "OudsSmallListItemTrailingImage(asset: AssetImage('assets/photo.png'))",
    _ => '',
  };

  /// Converts each customization enum value to its exact Dart token string.
  /// These helpers keep the switch expressions in [_defaultCode] / [_smallCode] readable.

  static String _sizeCode(ListItemSizeEnum size) => switch (size) {
    ListItemSizeEnum.defaultSize => 'OudsListItemSize.defaultSize',
    ListItemSizeEnum.small => 'OudsListItemSize.smallSize',
  };

  static String _alignmentCode(ListItemContentAlignmentEnum alignment) =>
      switch (alignment) {
        ListItemContentAlignmentEnum.center =>
          'OudsListItemContentAlignment.center',
        ListItemContentAlignmentEnum.top => 'OudsListItemContentAlignment.top',
      };

  static String _indicatorCode(ListItemIndicatorEnum indicator) =>
      switch (indicator) {
        ListItemIndicatorEnum.next => 'OudsListItemIndicatorNext()',
        ListItemIndicatorEnum.previous => 'OudsListItemIndicatorPrevious()',
        ListItemIndicatorEnum.external => 'OudsListItemIndicatorExternal()',
      };
}
