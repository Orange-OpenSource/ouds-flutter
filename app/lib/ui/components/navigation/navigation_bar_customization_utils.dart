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
import 'package:flutter/widgets.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';
import 'package:ouds_flutter_demo/l10n/gen/ouds_flutter_app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/components/navigation/navigation_bar_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

class NavigationBarCustomizationUtils {
  static const int itemBadgeCount = 1;
  static const int minItemCount = 3;
  static const int maxItemCount = 5;

  /// Returns an optional navigation bar item badge based on the selected badge type
  /// (count badge, standard badge, or none).
  static OudsNavigationBarItemBadge? getItemBadge(
    NavigationBarCustomizationState customizationState,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return customizationState.selectedItemBadge == ItemBadge.count
        ? OudsNavigationBarItemBadge(
            contentDescription: l10n
                .app_components_navigationBar_badge_count_a11y(itemBadgeCount),
            count: itemBadgeCount,
          )
        : customizationState.selectedItemBadge == ItemBadge.dot
        ? OudsNavigationBarItemBadge(
            contentDescription:
                l10n.app_components_navigationBar_badge_dot_a11y,
          )
        : null;
  }

  /// Generates a list of consecutive item count values from [minItemCount] to [maxItemCount] (inclusive).
  static final itemCountOptions = List<int>.generate(
    maxItemCount - minItemCount + 1,
    (index) => minItemCount + index,
  );

  /// Builds a shared list of navigation bar items based on the current
  /// customization state and theme.
  static List<OudsNavigationBarItem> buildItems({
    required ThemeController themeController,
    required BuildContext context,
    NavigationBarCustomizationState? customizationState,
    int itemCount = minItemCount,
  }) {
    final safeItemCount = itemCount.clamp(minItemCount, maxItemCount);

    return List.generate(safeItemCount, (index) {
      final isLastItem = index == safeItemCount - 1;

      return OudsNavigationBarItem(
        icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty(
          themeController,
        ),
        label: 'Label', //'item ${index + 1}',
        badge: (isLastItem && customizationState != null)
            ? getItemBadge(customizationState, context)
            : null,
      );
    });
  }
}
