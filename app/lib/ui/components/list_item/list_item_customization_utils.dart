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
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
// TODO[v1.0]: uncomment when flag is available
// import 'package:ouds_core/components/flag/ouds_flag.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
// TODO[v1.0]: uncomment when avatar is available
// import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_enum.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/list_item/list_item_enum.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
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

  /// Status dropdown shared by the four list item demo screens.
  ///
  /// Each entry is prefixed by a color chip using [getIconStatusColor].
  /// Callers are expected to wrap [onChanged] in `setState`.
  static CustomizationDropdownMenu<StatusEnum> buildStatusDropdown({
    required BuildContext context,
    required List<StatusEnum> options,
    required int selectedItemIndex,
    required StatusEnum selectedOption,
    required void Function(StatusEnum) onChanged,
  }) {
    final chipSize = OudsTheme.of(context).spaceScheme(context).fixedMedium;
    return CustomizationDropdownMenu<StatusEnum>(
      label: StatusEnum.enumName(context),
      options: options,
      selectedItemIndex: selectedItemIndex,
      selectedOption: selectedOption,
      getText: (option) => option.stringValue(context),
      onSelectionChange: (value, index) => onChanged(value),
      itemLeadingIcons: options.map((status) {
        return () => Container(
          width: chipSize,
          height: chipSize,
          decoration: BoxDecoration(
            color: getIconStatusColor(context, status),
            shape: BoxShape.rectangle,
          ),
        );
      }).toList(),
    );
  }

  /// Badge customization controls for the trailing "badge" option, shared by
  /// the four list item demo screens.
  static List<Widget> buildBadgeTrailingControls(
    BuildContext context,
    ListItemCustomizationState state, {
    required FocusNode countFocus,
  }) {
    return [
      CustomizableChips<BadgeEnumType>(
        title: BadgeEnumType.enumName(context),
        options: const [BadgeEnumType.standard, BadgeEnumType.count],
        selectedOption: state.trailingBadgeType,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          state.trailingBadgeType = selectedOption;
          // Same rule as the standalone badge demo: count badge is not
          // available in xsmall/small sizes.
          if (selectedOption == BadgeEnumType.count &&
              (state.trailingBadgeSize == BadgeEnumSize.xsmall ||
                  state.trailingBadgeSize == BadgeEnumSize.small)) {
            state.trailingBadgeSize = BadgeEnumSize.medium;
          }
        },
      ),
      if (state.trailingBadgeType == BadgeEnumType.count)
        CustomizableTextField(
          title: context.l10n.app_components_badge_countType_label,
          text: state.trailingBadgeCount,
          focusNode: countFocus,
          fieldType: FieldType.listItemTrailingBadgeCount,
          keyboardType: TextInputType.number,
        ),
      CustomizableChips<BadgeEnumSize>(
        title: BadgeEnumSize.enumName(context),
        options: state.trailingBadgeSizeState.list,
        selectedOption: state.trailingBadgeSize,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          state.trailingBadgeSize = selectedOption;
          // Same rule as the standalone badge demo: count badge is not
          // available in xsmall/small sizes.
          if (state.trailingBadgeType == BadgeEnumType.count &&
              (selectedOption == BadgeEnumSize.xsmall ||
                  selectedOption == BadgeEnumSize.small)) {
            state.trailingBadgeSize = BadgeEnumSize.medium;
          }
        },
      ),
      buildStatusDropdown(
        context: context,
        options: state.trailingBadgeStatusState.list,
        selectedItemIndex: state.trailingBadgeStatusIndex,
        selectedOption: state.trailingBadgeStatus,
        onChanged: (value) {
          state.trailingBadgeStatus = value;
        },
      ),
      CustomizableSwitch(
        title: context.l10n.app_common_enabled_label,
        value: state.trailingBadgeEnabled,
        onChanged: (value) {
          state.trailingBadgeEnabled = value;
        },
      ),
    ];
  }

  /// Tag customization controls for the trailing "tag" option, shared by
  /// the four list item demo screens.
  static List<Widget> buildTagTrailingControls(
    BuildContext context,
    ListItemCustomizationState state, {
    required FocusNode labelFocus,
  }) {
    return [
      CustomizableSwitch(
        title: context.l10n.app_common_enabled_label,
        value: state.trailingTagEnabled,
        onChanged: state.trailingTagLoader
            ? null
            : (value) {
                state.trailingTagEnabled = value;
              },
      ),
      CustomizableChips<TagEnumAppearance>(
        title: TagEnumAppearance.enumName(context),
        options: state.trailingTagAppearanceState.list,
        selectedOption: state.trailingTagAppearance,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          state.trailingTagAppearance = selectedOption;
        },
      ),
      buildStatusDropdown(
        context: context,
        options: state.trailingTagStatusState.list,
        selectedItemIndex: state.trailingTagStatusIndex,
        selectedOption: state.trailingTagStatus,
        onChanged: (value) {
          state.trailingTagStatus = value;
        },
      ),
      CustomizableChips<TagEnumLayout>(
        title: TagEnumLayout.enumName(context),
        options: state.trailingTagLayoutState.list,
        selectedOption: state.trailingTagLayout,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          state.trailingTagLayout = selectedOption;
        },
      ),
      CustomizableSwitch(
        title: context.l10n.app_components_common_loader_label,
        value: state.trailingTagLoader,
        onChanged: !state.trailingTagEnabled
            ? null
            : (value) {
                state.trailingTagLoader = value;
              },
      ),
      CustomizableSwitch(
        title: context.l10n.app_components_common_roundedCorner_label,
        value: state.trailingTagRoundedCorners,
        onChanged: (value) {
          state.trailingTagRoundedCorners = value;
        },
      ),
      CustomizableChips<TagEnumSize>(
        title: TagEnumSize.enumName(context),
        options: state.trailingTagSizeState.list,
        selectedOption: state.trailingTagSize,
        getText: (option) => option.stringValue(context),
        onSelected: (selectedOption) {
          state.trailingTagSize = selectedOption;
        },
      ),
      CustomizableTextField(
        title: context.l10n.app_components_common_label_label,
        text: state.trailingTagLabel,
        focusNode: labelFocus,
        fieldType: FieldType.listItemTrailingTagLabel,
      ),
    ];
  }

  /// Builds the icon status used by the demo chips and icon slots.
  ///
  /// The chosen [status] determines whether the slot uses a fixed functional
  /// icon or a themed custom asset from the active [themeController].
  static OudsIconStatus getIconStatus(
    BuildContext context,
    StatusEnum status,
    bool tinted,
    ThemeController themeController,
  ) {
    return switch (status) {
      StatusEnum.positive => Positive(),
      StatusEnum.info => Info(),
      StatusEnum.warning => Warning(),
      StatusEnum.negative => Negative(),
      StatusEnum.neutral => Neutral(
        icon: tinted
            ? AppAssets.icons.assistanceTipsAndTricks(themeController)
            : AppAssets.icons.icUntintedSquare,
        semanticsLabel: context.l10n.app_components_listItem_icon_a11y,
        tinted: tinted,
        backgroundColor: tinted
            ? null
            : OudsTheme.of(context).colorScheme(context).surfaceBrandPrimary,
      ),
      StatusEnum.accent => Accent(
        icon: tinted
            ? AppAssets.icons.assistanceTipsAndTricks(themeController)
            : AppAssets.icons.icUntintedSquare,
        semanticsLabel: context.l10n.app_components_listItem_icon_a11y,
        tinted: tinted,
        backgroundColor: tinted
            ? null
            : OudsTheme.of(context).colorScheme(context).surfaceBrandPrimary,
      ),
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
    BuildContext context,
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
        semanticsLabel: context.l10n.app_components_listItem_image_a11y,
        size: _convertImageSize(leadingImageSize),
        format: _convertImageFormat(leadingImageFormat),
        rounded: leadingImageRounded,
      ),
      ListItemLeadingEnum.content => OudsListItemLeadingContent(
        // Fills the slot height, capped by sizeMaxSizeLeadingTrailingSlot
        // in the core.
        (context, state) => SizedBox(
          height: double.infinity,
          child: _buildDemoContent(context, state),
        ),
      ),
      // TODO[v1.0]: uncomment avatar when available — also add ListItemLeadingEnum.avatar to the enum and restore the import
      // ListItemLeadingEnum.avatar => OudsListItemLeadingAvatar(
      //   OudsAvatar(image: assetPath),
      // ),
      // TODO[v1.0]: uncomment flag when available — also add ListItemLeadingEnum.flag to the enum and restore the import
      // ListItemLeadingEnum.flag => OudsListItemLeadingFlag(OudsFlag('fr')),
    };
  }

  /// Builds the full-size trailing slot from the current demo selections.
  ///
  /// The returned slot is shared by list and card item previews.
  static OudsListItemTrailing? getTrailing(
    BuildContext context,
    ListItemTrailingEnum trailing,
    OudsIconStatus trailingIconStatus,
    ListItemIconSizeEnum trailingIconSize,
    ListItemImageSizeEnum trailingImageSize,
    ListItemImageFormatEnum trailingImageFormat,
    bool trailingImageRounded,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    String trailingTextLabel,
    String trailingTextExtraLabel,
    ListItemCustomizationState state,
    ThemeController themeController,
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
      ListItemTrailingEnum.badge => OudsListItemTrailingBadge(
        (enable) =>
            _buildTrailingBadge(context, state, themeController, enable),
      ),
      ListItemTrailingEnum.tag => OudsListItemTrailingTag(
        (enable) => _buildTrailingTag(context, state, themeController, enable),
      ),
      ListItemTrailingEnum.icon => OudsListItemTrailingIcon(
        trailingIconStatus,
        size: _convertIconSizeEnum(trailingIconSize),
      ),
      ListItemTrailingEnum.image => OudsListItemTrailingImage(
        asset: assetPath,
        semanticsLabel: context.l10n.app_components_listItem_image_a11y,
        size: _convertImageSize(trailingImageSize),
        format: _convertImageFormat(trailingImageFormat),
        rounded: trailingImageRounded,
      ),
      ListItemTrailingEnum.content => OudsListItemTrailingContent(
        // Fills the slot height, capped by sizeMaxSizeLeadingTrailingSlot
        // in the core.
        (context, state) => SizedBox(
          height: double.infinity,
          child: _buildDemoContent(context, state),
        ),
      ),
      // TODO[v1.0]: uncomment avatar when available — also add ListItemTrailingEnum.avatar to the enum and restore the import
      // ListItemTrailingEnum.avatar => OudsListItemTrailingAvatar(
      //   OudsAvatar(image: assetPath),
      // ),
      // TODO[v1.0]: uncomment flag when available — also add ListItemTrailingEnum.flag to the enum and restore the import
      // ListItemTrailingEnum.flag => OudsListItemTrailingFlag(OudsFlag('fr')),
    };
  }

  /// Builds the [OudsBadge] used by the list item trailing badge slot, from
  /// the same customization logic as the standalone badge demo screen
  /// (status-based semantics label with count prefix, blank count omitted).
  ///
  /// Note: only the standard and count badge types are available here.
  static Widget _buildTrailingBadge(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
    bool enable,
  ) {
    final status = _convertStatus(state.trailingBadgeStatus);
    final size = BadgeCustomizationUtils.getSize(state.trailingBadgeSize);
    final enabled = enable && state.trailingBadgeEnabled;
    final semanticsLabel = _trailingBadgeSemanticLabel(context, state);
    return switch (state.trailingBadgeType) {
      BadgeEnumType.count => OudsBadge.count(
        label: emptyToNull(state.trailingBadgeCount),
        status: status,
        size: size,
        enabled: enabled,
        semanticsLabel: semanticsLabel,
      ),
      _ => OudsBadge.standard(
        status: status,
        size: size,
        enabled: enabled,
        semanticsLabel: semanticsLabel,
      ),
    };
  }

  /// Builds the [OudsTag] used by the list item trailing tag slot, from the
  /// same customization controls as the standalone tag demo screen.
  static Widget _buildTrailingTag(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
    bool enable,
  ) {
    final enabled = enable && state.trailingTagEnabled;
    final appearance = TagCustomizationUtils.getAppearance(
      state.trailingTagAppearance,
    );
    final size = TagCustomizationUtils.getSize(state.trailingTagSize);
    final layout = TagCustomizationUtils.getLayout(state.trailingTagLayout);
    var status = _convertStatus(state.trailingTagStatus);
    if (layout == OudsTagLayout.textAndIcon &&
        (status is Neutral || status is Accent)) {
      final icon = AppAssets.icons.functionalSocialAndEngagementHeartRecommend(
        themeController,
      );
      status = status is Neutral ? Neutral(icon: icon) : Accent(icon: icon);
    }
    return switch (layout) {
      OudsTagLayout.textAndBullet => OudsTag.bullet(
        label: state.trailingTagLabel,
        status: status,
        appearance: appearance,
        size: size,
        loading: state.trailingTagLoader,
        roundedCorners: state.trailingTagRoundedCorners,
        enabled: enabled,
      ),
      OudsTagLayout.textAndIcon => OudsTag.icon(
        label: state.trailingTagLabel,
        status: status,
        appearance: appearance,
        size: size,
        loading: state.trailingTagLoader,
        roundedCorners: state.trailingTagRoundedCorners,
        enabled: enabled,
      ),
      OudsTagLayout.textOnly => OudsTag.text(
        label: state.trailingTagLabel,
        status: status,
        appearance: appearance,
        size: size,
        loading: state.trailingTagLoader,
        roundedCorners: state.trailingTagRoundedCorners,
        enabled: enabled,
      ),
    };
  }

  /// Info alert shown in the customization panel when a leading or trailing
  /// slot is set to content.
  static Widget buildContentExampleAlert(BuildContext context) {
    final theme = OudsTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: theme.spaceScheme(context).fixedSmall,
      ),
      child: OudsAlertMessage(
        label: context.l10n.app_components_listItem_contentExampleAlert_label,
        description: context
            .l10n
            .app_components_listItem_contentExampleAlert_description,
        status: Info(),
      ),
    );
  }

  /// Builds demo content for leading/trailing content slots.
  ///
  /// Displays a colored box with "Content" text, adapting to the control state.
  static Widget _buildDemoContent(
    BuildContext context,
    OudsListItemControlState state,
  ) {
    final enabled = state != OudsListItemControlState.disabled;
    final oudsTheme = OudsTheme.of(context);
    final theme = oudsTheme.colorScheme(context);
    final space = oudsTheme.spaceScheme(context);
    final color = enabled ? theme.surfaceStatusInfoMuted : theme.actionDisabled;
    final textColor = enabled
        ? theme.contentOnStatusInfoMuted
        : theme.contentOnActionDisabled;

    return Container(
      padding: EdgeInsets.all(space.fixedExtraSmall),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(space.fixedTwoExtraSmall),
      ),
      alignment: Alignment.center,
      child: Text(
        context.l10n.app_components_listItem_content_tech,
        style: oudsTheme.typographyTokens
            .typeLabelDefaultSmall(context)
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Semantics label of the trailing badge, mirroring the standalone badge
  /// demo: a status-based label, prefixed by the count for the count type.
  static String _trailingBadgeSemanticLabel(
    BuildContext context,
    ListItemCustomizationState state,
  ) {
    final baseLabel = switch (state.trailingBadgeStatus) {
      StatusEnum.neutral =>
        context.l10n.app_components_badge_notification_label_a11y,
      StatusEnum.accent =>
        context.l10n.app_components_badge_important_label_a11y,
      StatusEnum.positive =>
        context.l10n.app_components_badge_success_label_a11y,
      StatusEnum.info => context.l10n.app_components_badge_info_label_a11y,
      StatusEnum.warning =>
        context.l10n.app_components_badge_warning_label_a11y,
      StatusEnum.negative =>
        context.l10n.app_components_badge_negative_label_a11y,
    };
    final count = emptyToNull(state.trailingBadgeCount);
    final isCount = state.trailingBadgeType == BadgeEnumType.count;
    return isCount && count != null ? '$count $baseLabel' : baseLabel;
  }

  /// Converts the demo [StatusEnum] to the functional [OudsIconStatus] used
  /// by badge and tag status parameters (no custom icon/contextual variant).
  static OudsIconStatus _convertStatus(StatusEnum status) {
    return switch (status) {
      StatusEnum.neutral => Neutral(),
      StatusEnum.accent => Accent(),
      StatusEnum.positive => Positive(),
      StatusEnum.info => Info(),
      StatusEnum.warning => Warning(),
      StatusEnum.negative => Negative(),
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
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    return _listItem(
      label: state.label,
      labelContent: state.labelContentEnabled
          ? (context, controlState) => _buildLabelContent(context, controlState)
          : null,
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(
        context,
        state.leading,
        leadingIconStatus,
        state.leadingIconSize,
        state.leadingImageSize,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getTrailing(
        context,
        state.trailing,
        trailingIconStatus,
        state.trailingIconSize,
        state.trailingImageSize,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextStyle,
        state.trailingTextLabel,
        state.trailingTextExtraLabel,
        state,
        themeController,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: () {},
      indicator: getIndicator(state.indicator),
      edgeToEdge: state.edgeToEdge,
      belowTextContent: state.belowTextContentEnabled
          ? (context, state) => _buildBelowTextContent(context, state)
          : null,
      bottomContent: state.bottomContentEnabled
          ? (context, state) => _buildBottomContent(context, state)
          : null,
    );
  }

  /// Builds an [OudsListItem], selecting the plain-label constructor or the
  /// mutually exclusive [OudsListItem.labelContent] constructor.
  static OudsListItem _listItem({
    required String label,
    Widget Function(BuildContext context, OudsListItemControlState state)?
    labelContent,
    required OudsListItemContentAlignment contentAlignment,
    String? overline,
    String? extraLabel,
    String? description,
    OudsListItemLeading? leading,
    OudsListItemTrailing? trailing,
    required bool divider,
    required bool background,
    String? helperText,
    required bool boldLabel,
    required bool enable,
    VoidCallback? onTap,
    OudsListItemIndicator indicator = OudsListItemDefaults.indicator,
    required bool edgeToEdge,
    Widget Function(BuildContext context, OudsListItemControlState state)?
    belowTextContent,
    Widget Function(BuildContext context, OudsListItemControlState state)?
    bottomContent,
  }) {
    if (labelContent != null) {
      return OudsListItem.labelContent(
        labelContent: labelContent,
        contentAlignment: contentAlignment,
        overline: overline,
        extraLabel: extraLabel,
        description: description,
        leading: leading,
        trailing: trailing,
        divider: divider,
        background: background,
        helperText: helperText,
        boldLabel: boldLabel,
        enable: enable,
        onTap: onTap,
        indicator: indicator,
        edgeToEdge: edgeToEdge,
        belowTextContent: belowTextContent,
        bottomContent: bottomContent,
      );
    }
    return OudsListItem(
      label: label,
      contentAlignment: contentAlignment,
      overline: overline,
      extraLabel: extraLabel,
      description: description,
      leading: leading,
      trailing: trailing,
      divider: divider,
      background: background,
      helperText: helperText,
      boldLabel: boldLabel,
      enable: enable,
      onTap: onTap,
      indicator: indicator,
      edgeToEdge: edgeToEdge,
      belowTextContent: belowTextContent,
      bottomContent: bottomContent,
    );
  }

  /// Builds the custom label content widget for the demo.
  static Widget _buildLabelContent(
    BuildContext context,
    OudsListItemControlState state,
  ) {
    final theme = OudsTheme.of(context);
    final colorScheme = theme.colorScheme(context);
    final color = state == OudsListItemControlState.disabled
        ? colorScheme.contentDisabled
        : colorScheme.contentDefault;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.app_components_listItem_customLabel_text,
          style: theme.typographyTokens
              .typeLabelStrongMedium(context)
              .copyWith(color: color),
        ),
        SizedBox(width: theme.spaceScheme(context).fixedSmall),
        OudsTag.bullet(
          label: context.l10n.app_components_listItem_newTag_label,
          size: OudsTagSize.small,
          status: Accent(),
        ),
      ],
    );
  }

  /// Builds the below text content widget (tags) for the demo.
  static Widget _buildBelowTextContent(
    BuildContext context,
    OudsListItemControlState state,
  ) {
    // Generic content box, stretched to the text column width.
    return SizedBox(
      width: double.infinity,
      child: _buildDemoContent(context, state),
    );
  }

  /// Builds the bottom content widget for the demo.
  static Widget _buildBottomContent(
    BuildContext context,
    OudsListItemControlState state,
  ) {
    // Generic content box, stretched to the item width.
    return SizedBox(
      width: double.infinity,
      child: _buildDemoContent(context, state),
    );
  }

  /// Builds the compact navigation preview from the current demo state.
  static OudsSmallListItem buildNavigationSmallListItem(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconTinted,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getSmallTrailing(
        context,
        state.trailing,
        trailingIconStatus,
        state.trailingIconTinted,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextLabel,
        state,
        themeController,
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

  /// Builds the full-size static preview from the current demo state.
  static OudsListItem buildListItem(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    return _listItem(
      label: state.label,
      labelContent: state.labelContentEnabled
          ? (context, controlState) => _buildLabelContent(context, controlState)
          : null,
      contentAlignment: getContentAlignment(state.contentAlignment),
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      leading: getLeading(
        context,
        state.leading,
        leadingIconStatus,
        state.leadingIconSize,
        state.leadingImageSize,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getTrailing(
        context,
        state.trailing,
        trailingIconStatus,
        state.trailingIconSize,
        state.trailingImageSize,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextStyle,
        state.trailingTextLabel,
        state.trailingTextExtraLabel,
        state,
        themeController,
      ),
      divider: state.divider,
      background: state.background,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      edgeToEdge: state.edgeToEdge,
      belowTextContent: state.belowTextContentEnabled
          ? (context, state) => _buildBelowTextContent(context, state)
          : null,
      bottomContent: state.bottomContentEnabled
          ? (context, state) => _buildBottomContent(context, state)
          : null,
    );
  }

  /// Builds the compact static preview from the current demo state.
  static OudsSmallListItem buildSmallListItem(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    return OudsSmallListItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconTinted,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getSmallTrailing(
        context,
        state.trailing,
        trailingIconStatus,
        state.trailingIconTinted,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextLabel,
        state,
        themeController,
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
    bool tinted,
    ListItemImageFormatEnum leadingImageFormat,
    bool rounded,
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
        tinted: tinted,
      ),
      ListItemLeadingEnum.image => OudsSmallListItemLeadingImage(
        asset: assetPath,
        format: _convertImageFormat(leadingImageFormat),
        rounded: rounded,
      ),
      // content is only available for default size
      ListItemLeadingEnum.content => null,
    };
  }

  /// Builds the compact trailing slot from the current demo selections.
  static OudsSmallListItemTrailing? getSmallTrailing(
    BuildContext context,
    ListItemTrailingEnum trailing,
    OudsIconStatus trailingIconStatus,
    bool tinted,
    ListItemTrailingTextStyleEnum trailingTextStyle,
    ListItemImageFormatEnum trailingImageFormat,
    bool rounded,
    String trailingTextLabel,
    ListItemCustomizationState state,
    ThemeController themeController,
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
      ListItemTrailingEnum.badge => OudsSmallListItemTrailingBadge(
        (enable) =>
            _buildTrailingBadge(context, state, themeController, enable),
      ),
      ListItemTrailingEnum.tag => OudsSmallListItemTrailingTag(
        (enable) => _buildTrailingTag(context, state, themeController, enable),
      ),
      ListItemTrailingEnum.icon => OudsSmallListItemTrailingIcon(
        trailingIconStatus,
        tinted: tinted,
      ),
      ListItemTrailingEnum.image => OudsSmallListItemTrailingImage(
        asset: assetPath,
        format: _convertImageFormat(trailingImageFormat),
        rounded: rounded,
      ),
      // content is only available for default size
      ListItemTrailingEnum.content => null,
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
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    final contentAlignment = getContentAlignment(state.contentAlignment);
    final leading = getLeading(
      context,
      state.leading,
      leadingIconStatus,
      state.leadingIconSize,
      state.leadingImageSize,
      state.leadingImageFormat,
      state.leadingImageRounded,
    );
    final trailing = getTrailing(
      context,
      state.trailing,
      trailingIconStatus,
      state.trailingIconSize,
      state.trailingImageSize,
      state.trailingImageFormat,
      state.trailingImageRounded,
      state.trailingTextStyle,
      state.trailingTextLabel,
      state.trailingTextExtraLabel,
      state,
      themeController,
    );
    final decoration = _convertCardDecoration(
      state.cardDecoration,
      state.divider,
    );
    final belowTextContent = state.belowTextContentEnabled
        ? (context, controlState) =>
              _buildBelowTextContent(context, controlState)
        : null;
    final bottomContent = state.bottomContentEnabled
        ? (context, controlState) => _buildBottomContent(context, controlState)
        : null;

    if (state.labelContentEnabled) {
      return OudsCardItem.labelContent(
        labelContent: (context, controlState) =>
            _buildLabelContent(context, controlState),
        contentAlignment: contentAlignment,
        decoration: decoration,
        overline: emptyToNull(state.overline),
        extraLabel: emptyToNull(state.extraLabel),
        description: emptyToNull(state.description),
        belowTextContent: belowTextContent,
        leading: leading,
        trailing: trailing,
        bottomContent: bottomContent,
        helperText: emptyToNull(state.helperText),
        boldLabel: state.boldLabel,
        enable: state.enable,
        onTap: state.clickable ? () {} : null,
        indicator: getIndicator(state.indicator),
      );
    }
    return OudsCardItem(
      label: state.label,
      contentAlignment: contentAlignment,
      decoration: decoration,
      overline: emptyToNull(state.overline),
      extraLabel: emptyToNull(state.extraLabel),
      description: emptyToNull(state.description),
      belowTextContent: belowTextContent,
      leading: leading,
      trailing: trailing,
      bottomContent: bottomContent,
      helperText: emptyToNull(state.helperText),
      boldLabel: state.boldLabel,
      enable: state.enable,
      onTap: state.clickable ? () {} : null,
      indicator: getIndicator(state.indicator),
    );
  }

  /// Builds the compact [OudsSmallCardItem] from the current demo state.
  static OudsSmallCardItem buildSmallCardItem(
    BuildContext context,
    ListItemCustomizationState state,
    ThemeController themeController,
  ) {
    final leadingIconStatus = getIconStatus(
      context,
      state.leadingIconStatus,
      state.leadingIconTinted,
      themeController,
    );
    final trailingIconStatus = getIconStatus(
      context,
      state.trailingIconStatus,
      state.trailingIconTinted,
      themeController,
    );
    return OudsSmallCardItem(
      label: state.label,
      contentAlignment: getContentAlignment(state.contentAlignment),
      description: emptyToNull(state.description),
      leading: getSmallLeading(
        state.leading,
        leadingIconStatus,
        state.leadingIconTinted,
        state.leadingImageFormat,
        state.leadingImageRounded,
      ),
      trailing: getSmallTrailing(
        context,
        state.trailing,
        trailingIconStatus,
        state.trailingIconTinted,
        state.trailingTextStyle,
        state.trailingImageFormat,
        state.trailingImageRounded,
        state.trailingTextLabel,
        state,
        themeController,
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
