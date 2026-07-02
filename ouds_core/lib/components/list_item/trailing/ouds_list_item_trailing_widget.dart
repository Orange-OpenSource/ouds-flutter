/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// {@category List item}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_icon_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsListItemTrailingWidget extends StatelessWidget {
  final OudsListItemTrailing trailing;
  final bool enable;

  const OudsListItemTrailingWidget({
    super.key,
    required this.trailing,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return switch (trailing) {
      OudsListItemTrailingText(:final textType) => _buildText(
        context,
        textType,
      ),
      // Badge and tag forward `enable` directly into their own `enabled` parameter.
      OudsListItemTrailingBadge(:final badge) => badge(enable),
      OudsListItemTrailingTag(:final tag) => tag(enable),
      // Icon handles disabled color and size internally via OudsListItemIconModifier.
      OudsListItemTrailingIcon(:final icon, :final size, :final tinted) =>
        OudsListItemIconModifier(
          context,
        ).buildIcon(icon, enable: enable, size: size.assetSize, tinted: tinted),
      // Image rendered with token-based size and format ratio.
      OudsListItemTrailingImage(:final asset, :final size, :final format) =>
        _buildImage(context, asset, size, format),
      OudsListItemTrailingFlag(:final asset) => _buildFlag(context, asset),
      OudsListItemTrailingVideo() => _buildVideoPlaceholder(context),
      // Avatar uses the OudsAvatar component directly.
      OudsListItemTrailingAvatar(:final avatar) => avatar,
      OudsListItemTrailingCustom(:final builder) => builder(context, enable: enable),
    };
  }

  Widget _buildText(
    BuildContext context,
    OudsListItemTrailingTextType textType,
  ) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    final contentColor = foreground.contentColor(enable);
    final mutedColor = foreground.mutedColor(enable);

    return switch (textType) {
      OudsListItemTrailingLabel(:final text) => Text(
        text,
        style: typography
            .typeLabelDefaultMedium(context)
            .copyWith(color: contentColor),
      ),
      OudsListItemTrailingLabelMuted(:final text) => Text(
        text,
        style: typography
            .typeLabelDefaultMedium(context)
            .copyWith(color: mutedColor),
      ),
      OudsListItemTrailingLabelStrong(:final text) => Text(
        text,
        style: typography
            .typeLabelStrongMedium(context)
            .copyWith(color: contentColor),
      ),
      OudsListItemTrailingLabelAndExtraLabel(:final text, :final extraLabel) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: typography
                  .typeLabelDefaultMedium(context)
                  .copyWith(color: contentColor),
            ),
            Text(
              extraLabel,
              style: typography
                  .typeLabelStrongMedium(context)
                  .copyWith(color: contentColor),
            ),
          ],
        ),
    };
  }

  Widget _buildImage(
    BuildContext context,
    ImageProvider asset,
    OudsListItemImageSize size,
    OudsListItemImageFormat format,
  ) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final height = size.assetSize.value(tokens);
    final width = height * format.ratio;
    return Image(image: asset, width: width, height: height, fit: BoxFit.cover);
  }

  Widget _buildFlag(BuildContext context, ImageProvider asset) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image(
        image: asset,
        width: tokens.sizeAssetMedium,
        height: tokens.sizeFlagHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVideoPlaceholder(BuildContext context) {
    final color = OudsListItemForegroundModifier(context).contentColor(enable);
    final size = OudsTheme.of(
      context,
    ).componentsTokens(context).listItem.sizeAssetMedium;
    return SizedBox(
      width: size,
      height: size,
      child: Icon(Icons.play_circle_outline, color: color),
    );
  }
}
