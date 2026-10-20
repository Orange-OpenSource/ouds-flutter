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
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';

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
      if (state.labelContentEnabled)
        '  labelContent: (context, state) => /* custom label content */,'
      else
        "  label: '${state.label}',",
      if (state.contentAlignment != ListItemContentAlignmentEnum.center)
        '  contentAlignment: ${_alignmentCode(state.contentAlignment)},',
      if (state.overline.trim().isNotEmpty)
        "  overline: '${state.overline.trim()}',",
      if (state.extraLabel.trim().isNotEmpty)
        "  extraLabel: '${state.extraLabel.trim()}',",
      if (state.description.trim().isNotEmpty)
        "  description: '${state.description.trim()}',",
      if (state.belowTextContentEnabled)
        '  belowTextContent: (context, state) => /* custom content */,',
      if (state.leading != ListItemLeadingEnum.none)
        '  leading: ${_leadingCode(state.leading, state)},',
      if (state.trailing != ListItemTrailingEnum.none)
        '  trailing: ${_trailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state.trailingTextExtraLabel, state)},',
      if (state.bottomContentEnabled)
        '  bottomContent: (context, state) => /* custom content */,',
      if (!state.divider) '  divider: false,',
      if (state.background) '  background: true,',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
      if (!state.edgeToEdge) '  edgeToEdge: false,',
    ];
    final ctor = state.labelContentEnabled
        ? 'OudsListItem.labelContent'
        : 'OudsListItem';
    return '$ctor(\n${params.join('\n')}\n)';
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
        '  leading: ${_smallLeadingCode(state.leading, state)},',
      if (state.trailing != ListItemTrailingEnum.none &&
          ListItemTrailingEnum.smallOptions.contains(state.trailing))
        '  trailing: ${_smallTrailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state)},',
      if (!state.divider) '  divider: false,',
      if (state.background) '  background: true,',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
      if (!state.edgeToEdge) '  edgeToEdge: false,',
    ];
    return 'OudsSmallListItem(\n${params.join('\n')}\n)';
  }

  /// Card item renders with a persistent background by default
  /// ([OudsCardItemDefaults.decoration]) — the `decoration` parameter is only
  /// emitted when the customization state differs from that default.
  static String _defaultCardCode(ListItemCustomizationState state) {
    final decorationCode = _cardDecorationCode(
      state.cardDecoration,
      state.divider,
    );
    final params = <String>[
      if (state.labelContentEnabled)
        '  labelContent: (context, state) => /* custom label content */,'
      else
        "  label: '${state.label}',",
      if (state.contentAlignment != ListItemContentAlignmentEnum.center)
        '  contentAlignment: ${_alignmentCode(state.contentAlignment)},',
      if (decorationCode != null) '  decoration: $decorationCode,',
      if (state.overline.trim().isNotEmpty)
        "  overline: '${state.overline.trim()}',",
      if (state.extraLabel.trim().isNotEmpty)
        "  extraLabel: '${state.extraLabel.trim()}',",
      if (state.description.trim().isNotEmpty)
        "  description: '${state.description.trim()}',",
      if (state.belowTextContentEnabled)
        '  belowTextContent: (context, state) => /* custom content */,',
      if (state.leading != ListItemLeadingEnum.none)
        '  leading: ${_leadingCode(state.leading, state)},',
      if (state.trailing != ListItemTrailingEnum.none)
        '  trailing: ${_trailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state.trailingTextExtraLabel, state)},',
      if (state.bottomContentEnabled)
        '  bottomContent: (context, state) => /* custom content */,',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    final ctor = state.labelContentEnabled
        ? 'OudsCardItem.labelContent'
        : 'OudsCardItem';
    return '$ctor(\n${params.join('\n')}\n)';
  }

  /// Small card item — no overline / extraLabel, leading/trailing restricted to smallOptions.
  static String _smallCardCode(ListItemCustomizationState state) {
    final decorationCode = _cardDecorationCode(
      state.cardDecoration,
      state.divider,
    );
    final params = <String>[
      "  label: '${state.label}',",
      if (state.contentAlignment != ListItemContentAlignmentEnum.center)
        '  contentAlignment: ${_alignmentCode(state.contentAlignment)},',
      if (decorationCode != null) '  decoration: $decorationCode,',
      if (state.description.trim().isNotEmpty)
        "  description: '${state.description.trim()}',",
      if (state.leading != ListItemLeadingEnum.none &&
          ListItemLeadingEnum.smallOptions.contains(state.leading))
        '  leading: ${_smallLeadingCode(state.leading, state)},',
      if (state.trailing != ListItemTrailingEnum.none &&
          ListItemTrailingEnum.smallOptions.contains(state.trailing))
        '  trailing: ${_smallTrailingCode(state.trailing, state.trailingTextStyle, state.trailingTextLabel, state)},',
      if (state.helperText.trim().isNotEmpty)
        "  helperText: '${state.helperText.trim()}',",
      if (state.boldLabel) '  boldLabel: true,',
      if (!state.enable) '  enable: false,',
      if (state.clickable) '  onTap: () { /* navigate */ },',
      if (state.clickable) '  indicator: ${_indicatorCode(state.indicator)},',
    ];
    return 'OudsSmallCardItem(\n${params.join('\n')}\n)';
  }

  /// Formats a constructor call with one argument per line, as `dart format`
  /// would render it when the call does not fit on a single line.
  ///
  /// [depth] is the nesting level of the call, used to indent the argument
  /// lines and the closing parenthesis relatively to the line on which the
  /// snippet starts.
  static String _call(String name, List<String> args, {int depth = 1}) {
    final inner = '  ' * depth;
    final closing = '  ' * (depth - 1);
    return '$name(\n${args.map((a) => '$inner$a').join('\n')}\n$closing)';
  }

  /// Icon snippet: `tinted:` / `size:` arguments are omitted when they match
  /// the defaults; the call stays on one line when only the status remains.
  ///
  /// [tintedInStatus] selects where the untinted flag is expressed: inside
  /// the [Neutral] status (large list item icons) or as a `tinted:` argument
  /// of the slot configuration (small list item icons).
  static String _iconCode(
    String name, {
    required bool tinted,
    ListItemIconSizeEnum? size,
    bool tintedInStatus = false,
  }) {
    final status = tinted
        ? "Neutral(icon: 'assets/ic_heart.svg')"
        : "Neutral(icon: 'assets/ic_heart.svg', tinted: false)";
    final args = <String>[
      if (tintedInStatus)
        '$status,'
      else ...[
        "Neutral(icon: 'assets/ic_heart.svg'),",
        if (!tinted) 'tinted: false,',
      ],
      if (size != null && size != ListItemIconSizeEnum.medium)
        'size: OudsListItemIconSize.${size.name},',
    ];
    if (args.length == 1) return '$name(${args.first})';
    return _call(name, args);
  }

  /// Image snippet: `size:` / `format:` / `rounded:` arguments are omitted
  /// when they match the defaults; the call stays on one line when only the
  /// asset remains. Pass a `null` [size] for small images (no size parameter).
  static String _imageCode(
    String name, {
    required ListItemImageFormatEnum format,
    required bool rounded,
    ListItemImageSizeEnum? size,
  }) {
    final args = <String>[
      "asset: 'assets/photo.jpg',",
      if (size != null && size != ListItemImageSizeEnum.medium)
        'size: OudsListItemImageSize.${size.name},',
      if (format != ListItemImageFormatEnum.square)
        'format: OudsListItemImageFormat.${format.name},',
      if (rounded) 'rounded: true,',
    ];
    if (args.length == 1) return '$name(${args.first})';
    return _call(name, args);
  }

  static String _leadingCode(
    ListItemLeadingEnum leading,
    ListItemCustomizationState state,
  ) => switch (leading) {
    ListItemLeadingEnum.none => '',
    ListItemLeadingEnum.icon => _iconCode(
      'OudsListItemLeadingIcon',
      tinted: state.leadingIconTinted,
      size: state.leadingIconSize,
      tintedInStatus: true,
    ),
    ListItemLeadingEnum.image => _imageCode(
      'OudsListItemLeadingImage',
      size: state.leadingImageSize,
      format: state.leadingImageFormat,
      rounded: state.leadingImageRounded,
    ),
    ListItemLeadingEnum.content =>
      "OudsListItemLeadingContent((context, state) => /* custom widget */)",
    // TODO[v1.0]: uncomment avatar when available
    // ListItemLeadingEnum.avatar =>
    //   "OudsListItemLeadingAvatar(OudsAvatar(monogram: 'AB'))",
    // TODO[v1.0]: uncomment flag when available
    // ListItemLeadingEnum.flag =>
    //   "OudsListItemLeadingFlag(asset: AssetImage('assets/flag.png'))",
  };

  static String _smallLeadingCode(
    ListItemLeadingEnum leading,
    ListItemCustomizationState state,
  ) => switch (leading) {
    ListItemLeadingEnum.icon => _iconCode(
      'OudsSmallListItemLeadingIcon',
      tinted: state.leadingIconTinted,
    ),
    ListItemLeadingEnum.image => _imageCode(
      'OudsSmallListItemLeadingImage',
      format: state.leadingImageFormat,
      rounded: state.leadingImageRounded,
    ),
    _ => '',
  };

  static String _trailingCode(
    ListItemTrailingEnum trailing,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
    String trailingTextExtraLabel,
    ListItemCustomizationState state,
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
    ListItemTrailingEnum.badge => _badgeCode(state),
    ListItemTrailingEnum.tag => _tagCode(state),
    ListItemTrailingEnum.icon => _iconCode(
      'OudsListItemTrailingIcon',
      tinted: state.trailingIconTinted,
      size: state.trailingIconSize,
      tintedInStatus: true,
    ),
    ListItemTrailingEnum.image => _imageCode(
      'OudsListItemTrailingImage',
      size: state.trailingImageSize,
      format: state.trailingImageFormat,
      rounded: state.trailingImageRounded,
    ),
    ListItemTrailingEnum.content =>
      "OudsListItemTrailingContent((context, state) => /* custom widget */)",
    // TODO[v1.0]: uncomment avatar when available
    // TODO[v1.0]: uncomment flag when available
  };

  /// Generates the badge trailing code snippet, from the current badge
  /// customization state.
  static String _badgeCode(ListItemCustomizationState state) {
    final status = state.trailingBadgeStatus.name;
    final size = state.trailingBadgeSize.name;
    final statusConstructor =
        '${status[0].toUpperCase()}${status.substring(1)}()';
    // When the demo switch is off, the badge is forced disabled whatever
    // the item state, like the preview.
    final enabledArg = state.trailingBadgeEnabled ? 'enable' : 'false';
    final isCount = state.trailingBadgeType == BadgeEnumType.count;
    final badgeArgs = <String>[
      if (isCount) "label: '${state.trailingBadgeCount}',",
      'status: $statusConstructor,',
      'size: OudsBadgeSize.$size,',
      'enabled: $enabledArg,',
    ];
    final badgeCall = _call(
      isCount ? 'OudsBadge.count' : 'OudsBadge.standard',
      badgeArgs,
      depth: 2,
    );
    return _call('OudsListItemTrailingBadge', ['(enable) => $badgeCall,']);
  }

  /// Generates the tag trailing code snippet, from the current tag
  /// customization state.
  static String _tagCode(ListItemCustomizationState state) {
    final status = state.trailingTagStatus.name;
    final statusConstructor =
        '${status[0].toUpperCase()}${status.substring(1)}()';
    final appearance = state.trailingTagAppearance.name;
    final size = state.trailingTagSize.name;
    final constructorName = switch (state.trailingTagLayout) {
      TagEnumLayout.bulletAndText => 'bullet',
      TagEnumLayout.iconAndText => 'icon',
      TagEnumLayout.textOnly => 'text',
    };
    // When the demo switch is off, the tag is forced disabled whatever
    // the item state, like the preview.
    final enabledArg = state.trailingTagEnabled ? 'enable' : 'false';
    final tagCall = _call('OudsTag.$constructorName', [
      "label: '${state.trailingTagLabel}',",
      'status: $statusConstructor,',
      'appearance: OudsTagAppearance.$appearance,',
      'size: OudsTagSize.$size,',
      'loading: ${state.trailingTagLoader},',
      'roundedCorners: ${state.trailingTagRoundedCorners},',
      'enabled: $enabledArg,',
    ], depth: 2);
    return _call('OudsListItemTrailingTag', ['(enable) => $tagCall,']);
  }

  static String _smallTrailingCode(
    ListItemTrailingEnum trailing,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
    ListItemCustomizationState state,
  ) => switch (trailing) {
    ListItemTrailingEnum.text => switch (trailingTextStyle) {
      ListItemTrailingTextStyleEnum.label =>
        "OudsSmallListItemTrailingText('$trailingTextLabel')",
      ListItemTrailingTextStyleEnum.labelMuted => _call(
        'OudsSmallListItemTrailingText',
        ["'$trailingTextLabel',", 'style: OudsListItemTextStyle.labelMuted,'],
      ),
      ListItemTrailingTextStyleEnum.labelStrong => _call(
        'OudsSmallListItemTrailingText',
        ["'$trailingTextLabel',", 'style: OudsListItemTextStyle.labelStrong,'],
      ),
      // labelAndExtraLabel is not supported in small — falls back to label
      ListItemTrailingTextStyleEnum.labelAndExtraLabel =>
        "OudsSmallListItemTrailingText('$trailingTextLabel')",
    },
    ListItemTrailingEnum.badge => _badgeCode(state).replaceFirst(
      'OudsListItemTrailingBadge',
      'OudsSmallListItemTrailingBadge',
    ),
    ListItemTrailingEnum.tag => _tagCode(
      state,
    ).replaceFirst('OudsListItemTrailingTag', 'OudsSmallListItemTrailingTag'),
    ListItemTrailingEnum.icon => _iconCode(
      'OudsSmallListItemTrailingIcon',
      tinted: state.trailingIconTinted,
    ),
    ListItemTrailingEnum.image => _imageCode(
      'OudsSmallListItemTrailingImage',
      format: state.trailingImageFormat,
      rounded: state.trailingImageRounded,
    ),
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

  /// Builds the `decoration:` code for a card item, mirroring
  /// [ListItemCustomizationUtils.buildCardItem]'s `_convertCardDecoration`.
  ///
  /// Returns `null` when the current state matches
  /// [OudsCardItemDefaults.decoration] (persistent background with divider),
  /// so the parameter is omitted from the generated snippet.
  static String? _cardDecorationCode(
    ListItemCardDecorationEnum decoration,
    bool divider,
  ) => switch (decoration) {
    ListItemCardDecorationEnum.background =>
      divider ? null : 'OudsListItemDecorationBackground(divider: false)',
    ListItemCardDecorationEnum.backgroundOnInteraction =>
      'OudsListItemDecorationBackgroundOnInteraction(divider: $divider)',
    ListItemCardDecorationEnum.outlined => 'OudsListItemDecorationOutlined()',
    ListItemCardDecorationEnum.outlinedOnInteraction =>
      'OudsListItemDecorationOutlinedOnInteraction()',
  };
}
