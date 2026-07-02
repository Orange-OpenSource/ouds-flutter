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
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// Demo enum for [OudsListItem.size].
enum ListItemSizeEnum {
  defaultSize,
  small;

  static String enumName(BuildContext context) => 'Size';
}

extension ListItemSizeLabel on ListItemSizeEnum {
  String stringValue(BuildContext context) => switch (this) {
    ListItemSizeEnum.defaultSize => 'Default',
    ListItemSizeEnum.small => 'Small',
  };
}

/// Demo enum for [OudsListItem.contentAlignment].
enum ListItemContentAlignmentEnum {
  center,
  top;

  static String enumName(BuildContext context) => 'Content alignment';
}

extension ListItemContentAlignmentLabel on ListItemContentAlignmentEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}

/// Demo enum for [OudsListItem.leading].
enum ListItemLeadingEnum {
  none,
  icon,
  image,
  avatar,
  flag,
  video;

  static String enumName(BuildContext context) => 'Leading';

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
  badge,
  tag,
  icon,
  image,
  avatar,
  flag,
  video;

  static String enumName(BuildContext context) => 'Trailing';

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

/// Demo enum for [OudsListItem.indicator] (navigation variant only).
enum ListItemIndicatorEnum {
  next,
  previous,
  external;

  static String enumName(BuildContext context) => 'Indicator';
}

extension ListItemIndicatorLabel on ListItemIndicatorEnum {
  String stringValue(BuildContext context) => capitalizeEnumValue(this);
}
