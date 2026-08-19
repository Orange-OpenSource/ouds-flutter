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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// Demo enum for [OudsListItem.size].
enum ListItemSizeEnum {
  defaultSize,
  small;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_size_tech;
}

extension ListItemSizeLabel on ListItemSizeEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItem.contentAlignment].
enum ListItemContentAlignmentEnum {
  center,
  top;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_alignment_tech;
}

extension ListItemContentAlignmentLabel on ListItemContentAlignmentEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItem.leading].
enum ListItemLeadingEnum {
  none,
  icon,
  image; // TODO[v0.4]: add avatar, flag — TODO[v0.4]: add video

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_leading_tech;

  /// Options available for [OudsSmallListItem] (icon and image only).
  static const List<ListItemLeadingEnum> smallOptions = [
    ListItemLeadingEnum.none,
    ListItemLeadingEnum.icon,
    ListItemLeadingEnum.image,
  ];
}

extension ListItemLeadingLabel on ListItemLeadingEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItem.trailing].
enum ListItemTrailingEnum {
  none,
  text,
  icon,
  image; // TODO[v0.3]: add badge, tag — TODO[v0.4]: add avatar, flag, video

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_trailing_tech;

  /// Options available for [OudsSmallListItem] (icon, image and text only).
  static const List<ListItemTrailingEnum> smallOptions = [
    ListItemTrailingEnum.none,
    ListItemTrailingEnum.text,
    ListItemTrailingEnum.icon,
    ListItemTrailingEnum.image,
  ];
}

extension ListItemTrailingLabel on ListItemTrailingEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for the text style of [OudsListItemTrailingText].
enum ListItemTrailingTextStyleEnum {
  label,
  labelMuted,
  labelStrong,
  labelAndExtraLabel;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_trailing_textType_tech;

  /// Options available for [OudsSmallListItem] — no [labelAndExtraLabel]
  /// since [OudsSmallListItemTrailingText] does not support an extra label.
  static const List<ListItemTrailingTextStyleEnum> smallOptions = [
    ListItemTrailingTextStyleEnum.label,
    ListItemTrailingTextStyleEnum.labelMuted,
    ListItemTrailingTextStyleEnum.labelStrong,
  ];
}

extension ListItemTrailingTextStyleLabel on ListItemTrailingTextStyleEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItem.indicator] (navigation variant only).
enum ListItemIndicatorEnum {
  next,
  previous,
  external;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_indicatorType_tech;
}

extension ListItemIndicatorLabel on ListItemIndicatorEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for generic asset size (icon, image, etc.) in leading/trailing.
enum ListItemImageSizeEnum {
  medium,
  large,
  extraLarge;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_imageSize_tech;
}

extension ListItemImageSizeLabel on ListItemImageSizeEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItemImageFormat] (when leading/trailing is image).
enum ListItemImageFormatEnum {
  square,
  widescreen;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_imageFormat_tech;
}

extension ListItemImageFormatLabel on ListItemImageFormatEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItemIconSize] in leading and trailing icon slots.
enum ListItemIconSizeEnum {
  medium,
  large;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_iconSize_tech;
}

extension ListItemIconSizeLabel on ListItemIconSizeEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItemDecoration] applied to card item previews.
enum ListItemCardDecorationEnum {
  background,
  backgroundOnInteraction,
  outlined,
  outlinedOnInteraction;

  static String enumName(BuildContext context) =>
      context.l10n.app_components_listItem_cardItem_decoration_tech;

  bool get supportsDivider =>
      this == ListItemCardDecorationEnum.background ||
      this == ListItemCardDecorationEnum.backgroundOnInteraction;
}

extension ListItemCardDecorationLabel on ListItemCardDecorationEnum {
  String stringValue(BuildContext context) => switch (this) {
    ListItemCardDecorationEnum.background => capitalizeEnumValue(
      ListItemCardDecorationEnum.background,
    ),
    ListItemCardDecorationEnum.backgroundOnInteraction => capitalizeEnumValue(
      ListItemCardDecorationEnum.backgroundOnInteraction,
    ),
    ListItemCardDecorationEnum.outlined => capitalizeEnumValue(
      ListItemCardDecorationEnum.outlined,
    ),
    ListItemCardDecorationEnum.outlinedOnInteraction => capitalizeEnumValue(
      ListItemCardDecorationEnum.outlinedOnInteraction,
    ),
  };
}
