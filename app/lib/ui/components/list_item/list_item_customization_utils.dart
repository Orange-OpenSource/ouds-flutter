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
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item_avatar.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class ListItemCustomizationUtils {
  const ListItemCustomizationUtils._();

  /// Returns the background color for the icon status dropdown chip.
  static Color getIconStatusColor(BuildContext context, StatusEnum status) {
    final theme = OudsTheme.of(context).colorScheme(context);
    return switch (status) {
      StatusEnum.neutral => theme.surfaceSecondary,
      StatusEnum.accent => theme.surfaceStatusAccentMuted,
      StatusEnum.positive => theme.surfaceStatusPositiveMuted,
      StatusEnum.info => theme.surfaceStatusInfoMuted,
      StatusEnum.warning => theme.surfaceStatusWarningMuted,
      StatusEnum.negative => theme.surfaceStatusNegativeMuted,
    };
  }

  static OudsIconStatus getIconStatus(
    StatusEnum status,
    ThemeController themeController,
  ) {
    return switch (status) {
      StatusEnum.positive => Positive(),
      StatusEnum.info => Info(),
      StatusEnum.warning => Warning(),
      StatusEnum.negative => Negative(),
      StatusEnum.neutral => Neutral(
        icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
      ),
      StatusEnum.accent => Accent(
        icon: AppAssets.icons.assistanceTipsAndTricks(themeController),
      ),
    };
  }

  static OudsListItemSize getSize(ListItemSizeEnum size) {
    return switch (size) {
      ListItemSizeEnum.defaultSize => OudsListItemSize.defaultSize,
      ListItemSizeEnum.small => OudsListItemSize.smallSize,
    };
  }

  static OudsListItemContentAlignment getContentAlignment(
    ListItemContentAlignmentEnum alignment,
  ) => switch (alignment) {
    ListItemContentAlignmentEnum.top => OudsListItemContentAlignment.top,
    ListItemContentAlignmentEnum.center => OudsListItemContentAlignment.center,
  };

  static OudsListItemLeading? getLeading(
    ListItemLeadingEnum leading,
    OudsIconStatus iconStatus,
  ) {
    final assetImage = AssetImage(AppAssets.images.ilTopAppBarAvatar);
    return switch (leading) {
      ListItemLeadingEnum.none => null,
      ListItemLeadingEnum.icon => OudsListItemLeadingIcon(iconStatus),
      ListItemLeadingEnum.image => OudsListItemLeadingImage(asset: assetImage),
      ListItemLeadingEnum.avatar => OudsListItemLeadingAvatar(
        OudsListItemAvatarImage(assetImage),
      ),
      ListItemLeadingEnum.flag => OudsListItemLeadingFlag(asset: assetImage),
      ListItemLeadingEnum.video => OudsListItemLeadingVideo(
        Uri.parse('https://example.com/video.mp4'),
      ),
    };
  }

  static OudsListItemTrailing? getTrailing(
    ListItemTrailingEnum trailing,
    OudsIconStatus iconStatus,
  ) {
    final assetImage = AssetImage(AppAssets.images.ilTopAppBarAvatar);
    return switch (trailing) {
      ListItemTrailingEnum.none => null,
      ListItemTrailingEnum.text => const OudsListItemTrailingText(
        OudsListItemTrailingLabel('Label'),
      ),
      ListItemTrailingEnum.badge => OudsListItemTrailingBadge(
        (enable) => OudsBadge.standard(
          status: Info(),
          semanticsLabel: 'Info badge',
          enabled: enable,
        ),
      ),
      ListItemTrailingEnum.tag => OudsListItemTrailingTag(
        (enable) =>
            OudsTag.text(label: 'Label', status: Positive(), enabled: enable),
      ),
      ListItemTrailingEnum.icon => OudsListItemTrailingIcon(iconStatus),
      ListItemTrailingEnum.image => OudsListItemTrailingImage(
        asset: assetImage,
      ),
      ListItemTrailingEnum.avatar => OudsListItemTrailingAvatar(
        OudsListItemAvatarImage(assetImage),
      ),
      ListItemTrailingEnum.flag => OudsListItemTrailingFlag(asset: assetImage),
      ListItemTrailingEnum.video => OudsListItemTrailingVideo(
        Uri.parse('https://example.com/video.mp4'),
      ),
    };
  }

  static String? emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static OudsListItem buildListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final iconStatus = getIconStatus(state.iconStatus, themeController);
    return OudsListItem(
      label: state.label,
      size: getSize(state.size),
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(state.leading, iconStatus),
      trailing: getTrailing(state.trailing, iconStatus),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
    );
  }
}
