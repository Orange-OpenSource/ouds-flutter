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
// TODO[v0.4]: uncomment when avatar is available
// import 'package:ouds_core/components/avatar/ouds_avatar.dart';
// TODO[v0.3]: uncomment when badge is available
// import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
// TODO[v0.4]: uncomment when flag is available
// import 'package:ouds_core/components/flag/ouds_flag.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
// TODO[v0.3]: uncomment when tag is available
// import 'package:ouds_core/components/tag/ouds_tag.dart';
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
    ListItemImageSizeEnum imageSize,
    ListItemImageFormatEnum imageFormat,
    bool imageRounded,
  ) {
    final assetPath = AppAssets.images.ilTopAppBarAvatar;
    return switch (leading) {
      ListItemLeadingEnum.none => null,
      ListItemLeadingEnum.icon => OudsListItemLeadingIcon(
        iconStatus,
        size: _convertIconSize(imageSize),
      ),
      ListItemLeadingEnum.image => OudsListItemLeadingImage(
        asset: AssetImage(assetPath),
        size: _convertImageSize(imageSize),
        format: _convertImageFormat(imageFormat),
        rounded: imageRounded,
      ),
      // TODO[v0.4]: uncomment avatar when available — also add ListItemLeadingEnum.avatar to the enum and restore the import
      // ListItemLeadingEnum.avatar => OudsListItemLeadingAvatar(
      //   OudsAvatar(image: assetPath),
      // ),
      // TODO[v0.4]: uncomment flag when available — also add ListItemLeadingEnum.flag to the enum and restore the import
      // ListItemLeadingEnum.flag => OudsListItemLeadingFlag(OudsFlag('fr')),
      // TODO[v0.4]: uncomment video when available — also add ListItemLeadingEnum.video to the enum
      // ListItemLeadingEnum.video => OudsListItemLeadingVideo(
      //   Uri.parse('https://example.com/video.mp4'),
      // ),
    };
  }

  static OudsListItemTrailing? getTrailing(
    ListItemTrailingEnum trailing,
    OudsIconStatus iconStatus,
    ListItemImageSizeEnum imageSize,
    ListItemImageFormatEnum imageFormat,
    bool imageRounded,
  ) {
    final assetPath = AppAssets.images.ilTopAppBarAvatar;
    return switch (trailing) {
      ListItemTrailingEnum.none => null,
      ListItemTrailingEnum.text => const OudsListItemTrailingText(
        OudsListItemTrailingLabel('Label'),
      ),
      // TODO[v0.3]: uncomment badge when available — also add ListItemTrailingEnum.badge to the enum and restore the import
      // ListItemTrailingEnum.badge => OudsListItemTrailingBadge(
      //   (enable) => OudsBadge.standard(
      //     status: Info(),
      //     semanticsLabel: 'Info badge',
      //     enabled: enable,
      //   ),
      // ),
      // TODO[v0.3]: uncomment tag when available — also add ListItemTrailingEnum.tag to the enum and restore the import
      // ListItemTrailingEnum.tag => OudsListItemTrailingTag(
      //   (enable) =>
      //       OudsTag.text(label: 'Label', status: Positive(), enabled: enable),
      // ),
      ListItemTrailingEnum.icon => OudsListItemTrailingIcon(
        iconStatus,
        size: _convertIconSize(imageSize),
      ),
      ListItemTrailingEnum.image => OudsListItemTrailingImage(
        asset: AssetImage(assetPath),
        size: _convertImageSize(imageSize),
        format: _convertImageFormat(imageFormat),
        rounded: imageRounded,
      ),
      // TODO[v0.4]: uncomment avatar when available — also add ListItemTrailingEnum.avatar to the enum and restore the import
      // ListItemTrailingEnum.avatar => OudsListItemTrailingAvatar(
      //   OudsAvatar(image: assetPath),
      // ),
      // TODO[v0.4]: uncomment flag when available — also add ListItemTrailingEnum.flag to the enum and restore the import
      // ListItemTrailingEnum.flag => OudsListItemTrailingFlag(OudsFlag('fr')),
      // TODO[v0.4]: uncomment video when available — also add ListItemTrailingEnum.video to the enum
      // ListItemTrailingEnum.video => OudsListItemTrailingVideo(
      //   Uri.parse('https://example.com/video.mp4'),
      // ),
    };
  }

  static String? emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static OudsListItemIndicator getIndicator(ListItemIndicatorEnum indicator) {
    return switch (indicator) {
      ListItemIndicatorEnum.next => const OudsListItemIndicatorNext(),
      ListItemIndicatorEnum.previous => const OudsListItemIndicatorPrevious(),
      ListItemIndicatorEnum.external => const OudsListItemIndicatorExternal(),
    };
  }

  static OudsListItem buildNavigationListItem(
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
      leading: getLeading(
        state.leading,
        iconStatus,
        state.imageSize,
        state.imageFormat,
        state.imageRounded,
      ),
      trailing: getTrailing(
        state.trailing,
        iconStatus,
        state.imageSize,
        state.imageFormat,
        state.imageRounded,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: () {},
      indicator: getIndicator(state.indicator),
    );
  }

  static OudsSmallListItem buildNavigationSmallListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final iconStatus = getIconStatus(state.iconStatus, themeController);
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(state.leading, iconStatus),
      trailing: getSmallTrailing(state.trailing, iconStatus),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: () {},
      indicator: getIndicator(state.indicator),
    );
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
      leading: getLeading(
        state.leading,
        iconStatus,
        state.imageSize,
        state.imageFormat,
        state.imageRounded,
      ),
      trailing: getTrailing(
        state.trailing,
        iconStatus,
        state.imageSize,
        state.imageFormat,
        state.imageRounded,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
    );
  }

  static OudsSmallListItem buildSmallListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final iconStatus = getIconStatus(state.iconStatus, themeController);
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(state.leading, iconStatus),
      trailing: getSmallTrailing(state.trailing, iconStatus),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
    );
  }

  static OudsSmallListItemLeading? getSmallLeading(
    ListItemLeadingEnum leading,
    OudsIconStatus iconStatus,
  ) {
    final assetPath = AppAssets.images.ilTopAppBarAvatar;
    return switch (leading) {
      ListItemLeadingEnum.none => null,
      ListItemLeadingEnum.icon => OudsSmallListItemLeadingIcon(iconStatus),
      ListItemLeadingEnum.image => OudsSmallListItemLeadingImage(
        asset: AssetImage(assetPath),
      ),
    };
  }

  static OudsSmallListItemTrailing? getSmallTrailing(
    ListItemTrailingEnum trailing,
    OudsIconStatus iconStatus,
  ) {
    final assetPath = AppAssets.images.ilTopAppBarAvatar;
    return switch (trailing) {
      ListItemTrailingEnum.none => null,
      ListItemTrailingEnum.text => const OudsSmallListItemTrailingText('Label'),
      ListItemTrailingEnum.icon => OudsSmallListItemTrailingIcon(iconStatus),
      ListItemTrailingEnum.image => OudsSmallListItemTrailingImage(
        asset: AssetImage(assetPath),
      ),
    };
  }

  /// Converts demo enum to OUDS list item image size.
  static OudsListItemImageSize _convertImageSize(ListItemImageSizeEnum size) =>
      switch (size) {
        ListItemImageSizeEnum.medium => OudsListItemImageSize.medium,
        ListItemImageSizeEnum.large => OudsListItemImageSize.large,
        ListItemImageSizeEnum.extraLarge => OudsListItemImageSize.extraLarge,
      };

  /// Converts demo enum to OUDS list item image format.
  static OudsListItemImageFormat _convertImageFormat(
    ListItemImageFormatEnum format,
  ) => switch (format) {
    ListItemImageFormatEnum.square => OudsListItemImageFormat.square,
    ListItemImageFormatEnum.panoramic => OudsListItemImageFormat.panoramic,
  };

  /// Converts demo enum to OUDS list item icon size.
  static OudsListItemIconSize _convertIconSize(ListItemImageSizeEnum size) =>
      switch (size) {
        ListItemImageSizeEnum.medium => OudsListItemIconSize.medium,
        ListItemImageSizeEnum.large => OudsListItemIconSize.large,
        ListItemImageSizeEnum.extraLarge =>
          OudsListItemIconSize.large, // Icon only has medium/large
      };
}
