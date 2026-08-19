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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
// TODO[v0.4]: uncomment when avatar is available
// import 'package:ouds_core/components/avatar/ouds_avatar.dart';
// TODO[v0.3]: uncomment when badge is available
// import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
// TODO[v0.4]: uncomment when flag is available
// import 'package:ouds_core/components/flag/ouds_flag.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
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

/// Helpers used to build and configure the list item demo previews.
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

  /// Builds the icon status used by the demo chips and icon slots.
  ///
  /// The chosen [status] determines whether the slot uses a fixed functional
  /// icon or a themed custom asset from the active [themeController].
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

  /// Maps the demo size enum to the corresponding list item size.
  static OudsListItemSize getSize(ListItemSizeEnum size) {
    return switch (size) {
      ListItemSizeEnum.defaultSize => OudsListItemSize.defaultSize,
      ListItemSizeEnum.small => OudsListItemSize.smallSize,
    };
  }

  /// Maps the demo alignment enum to the corresponding list item alignment.
  static OudsListItemContentAlignment getContentAlignment(
    ListItemContentAlignmentEnum alignment,
  ) => switch (alignment) {
    ListItemContentAlignmentEnum.top => OudsListItemContentAlignment.top,
    ListItemContentAlignmentEnum.center => OudsListItemContentAlignment.center,
  };

  /// Builds the full-size leading slot from the current demo selections.
  ///
  /// The returned slot is shared by list and card item previews.
  static OudsListItemLeading? getLeading(
    ListItemLeadingEnum leading,
    OudsIconStatus leadingIconStatus,
    ListItemIconSizeEnum leadingIconSize,
    ListItemImageSizeEnum leadingImageSize,
    ListItemImageFormatEnum leadingImageFormat,
    bool leadingImageRounded,
  ) {
    final assetPath =
        _convertImageFormat(leadingImageFormat) ==
            OudsListItemImageFormat.widescreen
        ? AppAssets.icons.icUntintedWidescreen
        : AppAssets.icons.icUntintedSquare;
    return switch (leading) {
      ListItemLeadingEnum.none => null,
      ListItemLeadingEnum.icon => OudsListItemLeadingIcon(
        leadingIconStatus,
        size: _convertIconSizeEnum(leadingIconSize),
      ),
      ListItemLeadingEnum.image => OudsListItemLeadingImage(
        asset: assetPath,
        contentDescription: 'Information image',
        size: _convertImageSize(leadingImageSize),
        format: _convertImageFormat(leadingImageFormat),
        rounded: leadingImageRounded,
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

  /// Builds the full-size trailing slot from the current demo selections.
  ///
  /// The returned slot is shared by list and card item previews.
  static OudsListItemTrailing? getTrailing(
    ListItemTrailingEnum trailing,
    OudsIconStatus trailingIconStatus,
    ListItemIconSizeEnum trailingIconSize,
    ListItemImageSizeEnum trailingImageSize,
    ListItemImageFormatEnum trailingImageFormat,
    bool trailingImageRounded,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
    String trailingTextExtraLabel,
  ) {
    final assetPath =
        _convertImageFormat(trailingImageFormat) ==
            OudsListItemImageFormat.widescreen
        ? AppAssets.icons.icUntintedWidescreen
        : AppAssets.icons.icUntintedSquare;
    return switch (trailing) {
      ListItemTrailingEnum.none => null,
      ListItemTrailingEnum.text => OudsListItemTrailingText(
        _buildTrailingTextType(
          trailingTextStyle,
          trailingTextLabel,
          trailingTextExtraLabel,
        ),
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
        trailingIconStatus,
        size: _convertIconSizeEnum(trailingIconSize),
      ),
      ListItemTrailingEnum.image => OudsListItemTrailingImage(
        asset: assetPath,
        contentDescription: 'Information image',
        size: _convertImageSize(trailingImageSize),
        format: _convertImageFormat(trailingImageFormat),
        rounded: trailingImageRounded,
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

  /// Converts blank text input to `null` so optional fields stay omitted.
  static String? emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  /// Maps the demo indicator enum to the list item navigation indicator.
  static OudsListItemIndicator getIndicator(ListItemIndicatorEnum indicator) {
    return switch (indicator) {
      ListItemIndicatorEnum.next => const OudsListItemIndicatorNext(),
      ListItemIndicatorEnum.previous => const OudsListItemIndicatorPrevious(),
      ListItemIndicatorEnum.external => const OudsListItemIndicatorExternal(),
    };
  }

  /// Builds the full-size navigation preview from the current demo state.
  static OudsListItem buildNavigationListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconSize,
        state.leadingImageSize,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingIconSize,
        state.trailingImageSize,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextStyle,
        state.trailingTextLabel,
        state.trailingTextExtraLabel,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: () {},
      indicator: getIndicator(state.indicator),
      edgeToEdge: state.edgeToEdge,
    );
  }

  /// Builds the compact navigation preview from the current demo state.
  static OudsSmallListItem buildNavigationSmallListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingImageFormat,
      ),
      trailing: getSmallTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingTextLabel,
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

  /// Builds the full-size static preview from the current demo state.
  static OudsListItem buildListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconSize,
        state.leadingImageSize,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingIconSize,
        state.trailingImageSize,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextStyle,
        state.trailingTextLabel,
        state.trailingTextExtraLabel,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      edgeToEdge: state.edgeToEdge,
    );
  }

  /// Builds the compact static preview from the current demo state.
  static OudsSmallListItem buildSmallListItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingImageFormat,
      ),
      trailing: getSmallTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingTextLabel,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      edgeToEdge: state.edgeToEdge,
    );
  }

  /// Builds the compact leading slot from the current demo selections.
  static OudsSmallListItemLeading? getSmallLeading(
    ListItemLeadingEnum leading,
    OudsIconStatus leadingIconStatus,
    ListItemImageFormatEnum leadingImageFormat,
  ) {
    final assetPath =
        _convertImageFormat(leadingImageFormat) ==
            OudsListItemImageFormat.widescreen
        ? AppAssets.icons.icUntintedWidescreen
        : AppAssets.icons.icUntintedSquare;
    return switch (leading) {
      ListItemLeadingEnum.none => null,
      ListItemLeadingEnum.icon => OudsSmallListItemLeadingIcon(
        leadingIconStatus,
      ),
      ListItemLeadingEnum.image => OudsSmallListItemLeadingImage(
        asset: assetPath,
        format: _convertImageFormat(leadingImageFormat),
      ),
    };
  }

  /// Builds the compact trailing slot from the current demo selections.
  static OudsSmallListItemTrailing? getSmallTrailing(
    ListItemTrailingEnum trailing,
    OudsIconStatus trailingIconStatus,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    ListItemImageFormatEnum trailingImageFormat,
    String trailingTextLabel,
  ) {
    final assetPath =
        _convertImageFormat(trailingImageFormat) ==
            OudsListItemImageFormat.widescreen
        ? AppAssets.icons.icUntintedWidescreen
        : AppAssets.icons.icUntintedSquare;
    return switch (trailing) {
      ListItemTrailingEnum.none => null,
      ListItemTrailingEnum.text => OudsSmallListItemTrailingText(
        trailingTextLabel,
        style: _convertTrailingTextStyle(trailingTextStyle),
      ),
      ListItemTrailingEnum.icon => OudsSmallListItemTrailingIcon(
        trailingIconStatus,
      ),
      ListItemTrailingEnum.image => OudsSmallListItemTrailingImage(
        asset: assetPath,
        format: _convertImageFormat(trailingImageFormat),
      ),
    };
  }

  /// Converts the trailing text style enum to [OudsListItemTextStyle].
  ///
  /// The compact variant falls back to `label` when `labelAndExtraLabel` is
  /// selected, because that extra-label layout is not available there.
  static OudsListItemTextStyle _convertTrailingTextStyle(
    ListItemTrailingTextStyleEnum style,
  ) {
    return switch (style) {
      ListItemTrailingTextStyleEnum.label => OudsListItemTextStyle.label,
      ListItemTrailingTextStyleEnum.labelMuted =>
        OudsListItemTextStyle.labelMuted,
      ListItemTrailingTextStyleEnum.labelStrong =>
        OudsListItemTextStyle.labelStrong,
      ListItemTrailingTextStyleEnum.labelAndExtraLabel =>
        OudsListItemTextStyle.label,
    };
  }

  /// Builds the trailing text model used by the full-size component.
  static OudsListItemTrailingTextType _buildTrailingTextType(
    ListItemTrailingTextStyleEnum style,
    String label,
    String extraLabel,
  ) {
    return switch (style) {
      ListItemTrailingTextStyleEnum.label => OudsListItemTrailingLabel(label),
      ListItemTrailingTextStyleEnum.labelMuted =>
        OudsListItemTrailingLabelMuted(label),
      ListItemTrailingTextStyleEnum.labelStrong =>
        OudsListItemTrailingLabelStrong(label),
      ListItemTrailingTextStyleEnum.labelAndExtraLabel =>
        OudsListItemTrailingLabelAndExtraLabel(label, extraLabel),
    };
  }

  /// Converts the demo image size enum to [OudsListItemImageSize].
  static OudsListItemImageSize _convertImageSize(ListItemImageSizeEnum size) =>
      switch (size) {
        ListItemImageSizeEnum.medium => OudsListItemImageSize.medium,
        ListItemImageSizeEnum.large => OudsListItemImageSize.large,
        ListItemImageSizeEnum.extraLarge => OudsListItemImageSize.extraLarge,
      };

  /// Converts the demo image format enum to [OudsListItemImageFormat].
  static OudsListItemImageFormat _convertImageFormat(
    ListItemImageFormatEnum format,
  ) => switch (format) {
    ListItemImageFormatEnum.square => OudsListItemImageFormat.square,
    ListItemImageFormatEnum.widescreen => OudsListItemImageFormat.widescreen,
  };

  /// Converts the demo icon size enum to [OudsListItemIconSize].
  static OudsListItemIconSize _convertIconSizeEnum(ListItemIconSizeEnum size) =>
      switch (size) {
        ListItemIconSizeEnum.medium => OudsListItemIconSize.medium,
        ListItemIconSizeEnum.large => OudsListItemIconSize.large,
      };

  /// Converts a [ListItemCardDecorationEnum] to the corresponding [OudsListItemDecoration].
  static OudsListItemDecoration _convertCardDecoration(
    ListItemCardDecorationEnum decoration,
    bool divider,
  ) => switch (decoration) {
    ListItemCardDecorationEnum.background => OudsListItemDecorationBackground(
      divider: divider,
    ),
    ListItemCardDecorationEnum.backgroundOnInteraction =>
      OudsListItemDecorationBackgroundOnInteraction(divider: divider),
    ListItemCardDecorationEnum.outlined =>
      const OudsListItemDecorationOutlined(),
    ListItemCardDecorationEnum.outlinedOnInteraction =>
      const OudsListItemDecorationOutlinedOnInteraction(),
  };

  /// Builds the default-size [OudsCardItem] from the current demo state.
  static OudsCardItem buildCardItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsCardItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconSize,
        state.leadingImageSize,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingIconSize,
        state.trailingImageSize,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextStyle,
        state.trailingTextLabel,
        state.trailingTextExtraLabel,
      ),
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: state.clickable ? () {} : null,
      indicator: getIndicator(state.indicator),
      decoration: _convertCardDecoration(state.cardDecoration, state.divider),
    );
  }

  /// Builds the compact [OudsSmallCardItem] from the current demo state.
  static OudsSmallCardItem buildSmallCardItem(
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      state.leadingIconStatus,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      state.trailingIconStatus,
      themeController,
    );
    return OudsSmallCardItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingImageFormat,
      ),
      trailing: getSmallTrailing(
        state.trailing,
        trailingIconStatus,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingTextLabel,
      ),
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: state.clickable ? () {} : null,
      indicator: getIndicator(state.indicator),
      decoration: _convertCardDecoration(state.cardDecoration, state.divider),
    );
  }
}
