
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
/// {@category TopBar}
library;
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

/// Configuration class for actions in the Ouds Top Bar.
///
/// This class defines the properties for configuring individual actions
/// (such as icons, text, or avatars) within the Bar Top component.
///
/// ### Common Parameters (All Platforms)
///
/// - [type]: The type of action from [OudsTopBarActionType].
/// - [onActionPressed]: Callback invoked when the action is pressed.
/// - [contentDescription]: Accessibility description for the action.
/// - [widget]: Custom widget (required when type is [OudsTopBarActionType.widget]).
///
/// ### iOS/Cupertino-Only Parameters
///
/// - [actionLabel]: Text label for the action (used with [OudsTopBarActionType.text]).
/// - [customIcon]: Path to custom icon asset (used with [OudsTopBarActionType.icon]).
///
/// ### Android/Material-Only Parameters
///
/// - [customLeadingIcon]: Path to custom leading icon asset.
/// - [badge]: Badge configuration [OudsTopAppBarActionBadge].
/// - [avatarConfig]: Avatar configuration [OudsTopAppBarAvatarConfig].
///
/// ### Example
///
/// ```dart
/// // Icon action
/// OudsTopBarActionConfig(
///   type: OudsTopBarActionType.icon,
///   customIcon: 'assets/icons/search.svg',
///   contentDescription: 'Search',
///   onActionPressed: () => _handleSearch(),
/// )
///
/// // Text action (iOS)
/// OudsTopBarActionConfig(
///   type: OudsTopBarActionType.text,
///   actionLabel: 'Done',
///   onActionPressed: () => _handleDone(),
/// )
/// ```
/// ## Platform-Specific Considerations
///
/// ### iOS Guidelines
/// - Use [OudsTopBarActionType.text] for primary actions
/// - Keep action labels short (1-2 words)
/// - Maximum 3 trailing actions recommended
///
/// ### Android Guidelines
/// - Use icons for most actions
/// - Maximum 3 trailing actions recommended
/// - Use overflow menu for additional actions
///
/// ## See Also
///
/// - [OudsTopAppBar] - Material implementation of top bar
/// - [OudsToolbarTop] - Cupertino implementation of top bar
/// - [OudsTopBarActionType] - Enumeration of available action types
/// - [OudsTopAppBarActionBadge] - Badge configuration for Android
/// - [OudsTopAppBarAvatarConfig] - Avatar configuration for Android
///
class OudsTopBarActionConfig {
  ///Common parameters
  final OudsTopBarActionType type ;
  final VoidCallback? onActionPressed;
  final String? contentDescription;
  final Widget? widget;
  ///Cupertino-Only Parameters
  final String? actionLabel;
  final String? customIcon;

  ///Material-Only Parameters
  final OudsTopAppBarAvatarConfig? avatarConfig;
  final OudsTopAppBarActionBadge? badge;
  final String? customLeadingIcon;

  OudsTopBarActionConfig({
    required this.type,
    this.onActionPressed,
    this.widget,
    this.badge,
    this.contentDescription,
    this.avatarConfig,
    this.actionLabel,
    this.customIcon,
    this.customLeadingIcon
  });

  /// Builds and returns the widget for a specific action based on its configuration.
  ///
  /// This method creates different widgets depending on the [action.type], such as text buttons,
  /// icons, or custom widgets. It throws unimplemented errors for unsupported types.
  ///
  /// **Supported action types:**
  /// - [OudsTopBarActionType.text]: Text button with customizable label and color
  /// - [OudsTopBarActionType.back]: Back navigation button with icon and optional label
  /// - [OudsTopBarActionType.none]: Empty widget (no visible action)
  /// - [OudsTopBarActionType.icon]: Icon button with SVG asset support
  /// - [OudsTopBarActionType.widget]: Custom widget provided by configuration
  ///
  /// **Parameters:**
  /// - [context]: The build context used to access theme and localization.
  /// - [isLeadingAction]: A boolean indicating whether this action is on the leading side.
  ///
  /// **Returns:**
  /// - A [Widget] representing the action, or throws an [UnimplementedError] for unsupported types.
  ///
  /// **Throws:**
  /// [UnimplementedError] if the action [type] is not supported for iOS platform
  ///
  Widget buildToolbarTopAction(
      BuildContext context,
      bool isLeadingAction) {

    final colorToken = OudsTheme.of(context).colorScheme(context).actionSelected;

    switch (type) {
    // TEXT ACTION
      case OudsTopBarActionType.text:
        return CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              actionLabel ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorToken),
            )
            , onPressed:(){
          onActionPressed?.call();
        });
    // BACK ACTION (icon + optional label)
      case OudsTopBarActionType.back:
        return CupertinoButton(
          padding: EdgeInsetsDirectional.zero,
          onPressed: () {
            onActionPressed?.call();
          },
          child: Row(
            children: [
              Semantics(
                label: contentDescription
                    ?? OudsLocalizations.of(context)?.core_topAppBar_backNavigationIcon_a11y,
                child: SvgPicture.asset(
                  alignment: Alignment.centerLeft,
                  excludeFromSemantics: true,
                  matchTextDirection: true,
                  AppAssets.icons.componentLinkPrevious,
                  package: OudsTheme.of(context).packageName,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    colorToken,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Text(actionLabel ?? "",
                style: TextStyle(
                    color: colorToken
                ),
              ),
            ],
          ),
        );
    // NO ACTION
      case OudsTopBarActionType.none:
        return SizedBox.shrink();
    // ICON ACTION
      case OudsTopBarActionType.icon:
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () { onActionPressed?.call(); },
          child: SvgPicture.asset(
            alignment: AlignmentDirectional.centerStart,
            excludeFromSemantics: true,
            matchTextDirection: true,
            AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            package: OudsTheme.of(context).packageName,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              colorToken,
              BlendMode.srcIn,
            ),
          ),
        );
    // CUSTOM ACTION (fully custom widget)
      case OudsTopBarActionType.widget:
        return widget ?? SizedBox.shrink();
      default:
        throw UnimplementedError('Type $type not supported for iOS');
    }
  }

  /// Builds a single trailing action widget for the top app bar (Material).
  ///
  /// Creates the appropriate widget based on the action type (icon, avatar, or custom widget).
  /// For avatar actions, the visibility is controlled by the [showAvatar] parameter.
  ///
  /// **Supported action types:**
  /// - [OudsTopBarActionType.icon]: Icon button with optional badge and semantic label
  /// - [OudsTopBarActionType.avatar]: User avatar with monogram support (conditionally displayed)
  /// - [OudsTopBarActionType.widget]: Custom widget provided in configuration
  ///
  /// **Parameters:**
  /// - [context]: The build context for accessing theme and component tokens
  /// - [showAvatar]: Controls whether the avatar action should be displayed.
  ///   If `false`, returns [SizedBox.shrink] for avatar type. Has no effect on other action types.
  ///
  /// **Returns:**
  /// A [Widget] representing the configured action:
  /// - For icon type: A [BadgeIconButton] wrapped with semantic labels
  /// - For avatar type: An [OudsAvatar] with padding (or empty widget if [showAvatar] is false)
  /// - For widget type: The custom widget provided in configuration
  ///
  /// **Throws:**
  /// [UnimplementedError] if the action type is not supported for Material design
  ///
  Widget buildTopAppbarTrailingAction(BuildContext context,bool showAvatar) {

    final theme = OudsTheme.of(context);
      final iconButtonWithBadge =
      MergeSemantics(
        child: Semantics(
          label: contentDescription,
          child: BadgeIconButton(
            icon: AppAssets.icons.functionalSocialAndEngagementHeartEmpty,
            badge: badge,
            onPressed: () {
              onActionPressed?.call();
            },
          ),
        ),
      );

      switch (type) {
        case OudsTopBarActionType.icon:
          return iconButtonWithBadge;
        case OudsTopBarActionType.avatar :{
          return showAvatar ? Semantics(
              label: avatarConfig?.contentDescription,
              button: true,
              child:  _buildAvatar(context,theme)
            )
           : SizedBox.shrink();
        }
        case OudsTopBarActionType.widget:
          return widget!;
        default:
          throw UnimplementedError('Type $type not supported for Material');
      }
    }

  /// Builds the avatar widget with proper padding and semantics.
  Widget _buildAvatar(BuildContext context, OudsThemeContract theme) {
    return Padding(
      padding: EdgeInsetsDirectional.all(
        theme.componentsTokens(context).button.spaceInsetIconOnly,
      ),
      child: Semantics(
        label: avatarConfig?.contentDescription,
        button: true,
        child: OudsAvatar(
          image: avatarConfig?.image,
          monogramBackgroundColor:
          avatarConfig?.monogramBackgroundColor ??
              theme.colorScheme(context).surfaceInverseHigh,
          monogram: avatarConfig?.monogram,
          monogramColor:
          avatarConfig?.monogramColor ??
              theme.colorScheme(context).contentOnActionEnabled,
          onClick: onActionPressed,
        ),
      ),
    );
  }
}