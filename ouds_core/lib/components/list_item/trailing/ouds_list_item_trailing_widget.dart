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
import 'package:ouds_core/components/list_item/ouds_list_item_avatar.dart';
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
      // Icon handles disabled color internally via OudsListItemIconModifier.
      OudsListItemTrailingIcon(:final icon) => OudsListItemIconModifier(
        context,
      ).buildIcon(icon, enable: enable),
      // Image, flag, video and avatar have no enabled API — rendered as-is.
      // Interaction is already blocked by IgnorePointer on the root widget.
      OudsListItemTrailingImage(:final asset) => Image(
        image: asset,
        width: 28,
        height: 28,
        fit: BoxFit.cover,
      ),
      OudsListItemTrailingFlag(:final asset) => ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image(image: asset, width: 28, height: 20, fit: BoxFit.cover),
      ),
      OudsListItemTrailingVideo() => const SizedBox(
        width: 28,
        height: 28,
        child: Icon(Icons.play_circle_outline),
      ),
      OudsListItemTrailingAvatar(:final avatar) => _buildAvatar(avatar),
    };
  }

  Widget _buildText(
    BuildContext context,
    OudsListItemTrailingTextType textType,
  ) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    // When disabled, both primary and muted roles map to contentDisabled.
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

  Widget _buildAvatar(OudsListItemAvatar avatar) {
    return switch (avatar) {
      OudsListItemAvatarImage(:final image) => CircleAvatar(
        radius: 14,
        backgroundImage: image,
      ),
      OudsListItemAvatarInitials(:final initials) => CircleAvatar(
        radius: 14,
        child: Text(initials),
      ),
      OudsListItemAvatarIcon() => const CircleAvatar(
        radius: 14,
        child: Icon(Icons.person_outline, size: 16),
      ),
    };
  }
}
