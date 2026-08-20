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

/// Generates Flutter code snippets for [OudsListItem], [OudsSmallListItem],
/// [OudsCardItem] and [OudsSmallCardItem], mirroring the current customization state.
class ListItemCodeGenerator {
  ListItemCodeGenerator._();

  /// Builds the code string for the current list item customization state.
  ///
  /// Set [isSmall] to `true` to generate [OudsSmallListItem] code,
  /// otherwise generates [OudsListItem] code.
  static String updateCode(BuildContext context, {required bool isSmall}) {
    final state = ListItemCustomization.of(context)!;
    return isSmall ? _smallCode(state) : _defaultCode(state);
  }

  /// Builds the code string for the current card item customization state.
  ///
  /// Set [isSmall] to `true` to generate [OudsSmallCardItem] code,
  /// otherwise generates [OudsCardItem] code.
  static String updateCardCode(BuildContext context, {required bool isSmall}) {
    final state = ListItemCustomization.of(context)!;
    return isSmall ? _smallCardCode(state) : _defaultCardCode(state);
  }

  static String _defaultCode(ListItemCustomizationState state) {
    final params = <String>[
      "  label: '${state.label}',",
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
        '  trailing: ${_trailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state.trailingTextExtraLabel)},',
      if (!state.divider) '  divider: false,',
      if (state.background) '  background: true,',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    return 'OudsListItem(\n${params.join('\n')}\n)';
  }

  static String _smallCode(ListItemCustomizationState state) {
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
        '  trailing: ${_smallTrailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel)},',
      if (!state.divider) '  divider: false,',
      '  background: ${state.background},',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    return 'OudsSmallListItem(\n${params.join('\n')}\n)';
  }

  /// Card item always renders with a background — no decoration parameter is
  /// emitted since [OudsCardItemDecorationBackground] is already the default.
  static String _defaultCardCode(ListItemCustomizationState state) {
    final params = <String>[
      "  label: '${state.label}',",
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
        '  trailing: ${_trailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state.trailingTextExtraLabel)},',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    return 'OudsCardItem(\n${params.join('\n')}\n)';
  }

  /// Small card item — no overline / extraLabel, leading/trailing restricted to smallOptions.
  static String _smallCardCode(ListItemCustomizationState state) {
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
        '  trailing: ${_smallTrailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel)},',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    return 'OudsSmallCardItem(\n${params.join('\n')}\n)';
  }

  static String _leadingCode(ListItemLeadingEnum leading) => switch (leading) {
    ListItemLeadingEnum.none => '',
    ListItemLeadingEnum.icon =>
      "OudsListItemLeadingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemLeadingEnum.image =>
      "OudsListItemLeadingImage(asset: 'assets/photo.jpg')",
    // TODO[v0.4]: uncomment avatar when available
    // ListItemLeadingEnum.avatar =>
    //   "OudsListItemLeadingAvatar(OudsAvatar(monogram: 'AB'))",
    // TODO[v0.4]: uncomment flag when available
    // ListItemLeadingEnum.flag =>
    //   "OudsListItemLeadingFlag(asset: AssetImage('assets/flag.png'))",
    // TODO[v0.4]: uncomment video when available
    // ListItemLeadingEnum.video =>
    //   "OudsListItemLeadingVideo(Uri.parse('https://example.com/video.mp4'))",
  };

  static String _smallLeadingCode(ListItemLeadingEnum leading) =>
      switch (leading) {
        ListItemLeadingEnum.icon =>
          "OudsSmallListItemLeadingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
        ListItemLeadingEnum.image =>
          "OudsSmallListItemLeadingImage(asset: 'assets/photo.jpg')",
        _ => '',
      };

  static String _trailingCode(
    ListItemTrailingEnum trailing,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
    String trailingTextExtraLabel,
  ) => switch (trailing) {
    ListItemTrailingEnum.none => '',
    ListItemTrailingEnum.text => switch (trailingTextStyle) {
      ListItemTrailingTextStyleEnum.label =>
        "OudsListItemTrailingText(OudsListItemTrailingLabel('$trailingTextLabel'))",
      ListItemTrailingTextStyleEnum.labelMuted =>
        "OudsListItemTrailingText(OudsListItemTrailingLabelMuted('$trailingTextLabel'))",
      ListItemTrailingTextStyleEnum.labelStrong =>
        "OudsListItemTrailingText(OudsListItemTrailingLabelStrong('$trailingTextLabel'))",
      ListItemTrailingTextStyleEnum.labelAndExtraLabel =>
        "OudsListItemTrailingText(OudsListItemTrailingLabelAndExtraLabel('$trailingTextLabel', '$trailingTextExtraLabel'))",
    },
    // TODO[v0.3]: uncomment badge when available
    // TODO[v0.3]: uncomment tag when available
    ListItemTrailingEnum.icon =>
      "OudsListItemTrailingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemTrailingEnum.image =>
      "OudsListItemTrailingImage(asset: 'assets/photo.jpg')",
    // TODO[v0.4]: uncomment avatar when available
    // TODO[v0.4]: uncomment flag when available
    // TODO[v0.4]: uncomment video when available
  };

  static String _smallTrailingCode(
    ListItemTrailingEnum trailing,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
  ) => switch (trailing) {
    ListItemTrailingEnum.text => switch (trailingTextStyle) {
      ListItemTrailingTextStyleEnum.label =>
        "OudsSmallListItemTrailingText('$trailingTextLabel')",
      ListItemTrailingTextStyleEnum.labelMuted =>
        "OudsSmallListItemTrailingText('$trailingTextLabel', style: OudsListItemTextStyle.labelMuted)",
      ListItemTrailingTextStyleEnum.labelStrong =>
        "OudsSmallListItemTrailingText('$trailingTextLabel', style: OudsListItemTextStyle.labelStrong)",
      // labelAndExtraLabel is not supported in small — falls back to label
      ListItemTrailingTextStyleEnum.labelAndExtraLabel =>
        "OudsSmallListItemTrailingText('$trailingTextLabel')",
    },
    ListItemTrailingEnum.icon =>
      "OudsSmallListItemTrailingIcon(Neutral(icon: 'assets/ic_heart.svg'))",
    ListItemTrailingEnum.image =>
      "OudsSmallListItemTrailingImage(asset: 'assets/photo.jpg')",
    _ => '',
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
