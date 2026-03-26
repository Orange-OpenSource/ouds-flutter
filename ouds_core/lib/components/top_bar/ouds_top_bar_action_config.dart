
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
import 'package:ouds_core/components/avatar/ouds_avatar.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_toolbar_top_action_modifier.dart';
import 'package:ouds_core/components/top_bar/internal/ouds_toolbar_top_text_style_modifier.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

/// A configuration object that defines the appearance and behavior of a single
/// action within an [OudsTopBar].
///
/// Use the provided factory constructors like [OudsTopBarActionConfig.icon],
/// or [OudsTopBarActionConfig.text] to create type-safe and platform-appropriate actions.
///
/// ### Common Parameters (All Platforms)
///
/// - [type]: The type of action from [OudsTopBarActionType].
/// - [onActionPressed]: Callback invoked when the action is pressed.
/// - [contentDescription]: Accessibility description for the action.
/// - [widget]: A custom widget to display as the action. This is only used when [type] is [OudsTopBarActionType.widget].
/// - [icon]: Path to custom icon asset. This is used when [type] is [OudsTopBarActionType.icon] or [OudsTopBarActionType.custom].
///
/// ### iOS/Cupertino-Only Parameters
///
/// - [actionLabel]: Text label for the action (used with [OudsTopBarActionType.text]).
/// - [previousPageTitle]:  The title of the previous page for back navigation context
/// **Behavior:**
/// - When provided with [OudsTopBarActionType.back]: Displays the back icon followed by this text (e.g., "← Home")
/// - When null and the type [OudsTopBarActionType.back] is provided: Displays only the back icon (e.g., "←")
///
/// This helps users understand their navigation context by showing where
/// the back action will take them.
///
/// ### Android/Material-Only Parameters
///
/// - [badge]: Configuration for a notification badge. This is only used on Material when [type] is [OudsTopBarActionType.icon].
/// - [avatarConfig]: Configuration for an avatar. This is only used on Material when [type] is [OudsTopBarActionType.avatar].
///
/// ### Example of usage
///
/// ```dart
/// OudsTopBar(
///   title: "My App",
///   leadingActions: [
///     OudsTopBarActionConfig.back(onActionPressed: () => Navigator.pop(context)),
///     previousPageTitle: 'Settings', // Shows: "← Settings"
///   ],
///   trailingActions: [
///     OudsTopBarActionConfig.icon(
///       icon: 'assets/icons/search.svg',
///       contentDescription: 'Search',
///       onActionPressed: () => _handleSearch(),
///     ),
///     OudsTopBarActionConfig.text(
///       actionLabel: 'Done',
///       onActionPressed: () => _handleDone(),
///     ),
///   ],
/// )
/// ```
///
/// ## Platform-Specific Considerations
///
/// ### iOS Guidelines
/// - Use [OudsTopBarActionConfig.text] for primary actions.
/// - Keep action labels short (1-2 words).
/// - A maximum of 3 trailing actions is recommended.
///
/// ### Android Guidelines
/// - Use [OudsTopBarActionConfig.icon] for most actions.
/// - A maximum of 3 trailing actions is recommended.
/// - Use an overflow menu for additional actions (not directly provided by this component).
///
/// ## See Also
///
/// - [OudsTopBar] - The adaptive top bar component that uses this configuration.
/// - [OudsTopAppBar] - The Material Design implementation of the top bar.
/// - [OudsToolbarTop] - The Cupertino (iOS) implementation of the top bar.
///
class OudsTopBarActionConfig {
  ///Common parameters
  final OudsTopBarActionType type ;
  final VoidCallback? onActionPressed;
  final String? contentDescription;
  final Widget? widget;
  final String? icon;

  ///Cupertino-Only Parameters
  final String? actionLabel;
  final String? previousPageTitle;

  ///Material-Only Parameters
  final OudsTopAppBarAvatarConfig? avatarConfig;
  final OudsTopAppBarActionBadge? badge;

  /// Private base constructor.
  const OudsTopBarActionConfig._({
    required this.type,
    this.onActionPressed,
    this.widget,
    this.badge,
    this.contentDescription,
    this.avatarConfig,
    this.actionLabel,
    this.icon,
    this.previousPageTitle
  });

  /// Creates a configuration for an icon-based action.
  ///
  /// The [badge] parameter is only applied on Material and will be ignored on iOS.
  factory OudsTopBarActionConfig.icon({
    required String icon, // Make this non-nullable for clarity
    VoidCallback? onActionPressed,
    String? contentDescription,
    OudsTopAppBarActionBadge? badge, // Material-only
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.icon,
      icon: icon,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
      badge: badge,
    );
  }

  /// Creates a configuration for a custom leading icon-based action.
  factory OudsTopBarActionConfig.custom({
    required String icon, // Make this non-nullable for clarity
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.custom,
      icon: icon,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for a text-based action.
  ///
  /// This is primarily intended for use on iOS, following Cupertino design guidelines.
 factory OudsTopBarActionConfig.text({
    required String actionLabel,
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.text,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for an avatar action.
  ///
  /// This is only applied on Material and will be ignored on iOS.
  factory OudsTopBarActionConfig.avatar({
    required OudsTopAppBarAvatarConfig avatarConfig,
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.avatar,
      avatarConfig: avatarConfig,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for a standard 'back' navigation action.
  ///
  /// On iOS, an optional [previousPageTitle] can be displayed next to the back arrow.
  factory OudsTopBarActionConfig.back({
    String? previousPageTitle,
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.back,
      previousPageTitle: previousPageTitle,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for a standard 'menu' (hamburger) navigation action.
  factory OudsTopBarActionConfig.menu({
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.menu,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for a close action.
  factory OudsTopBarActionConfig.close({
    String? actionLabel,
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.close,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration that displays a custom, developer-defined [widget].
  factory OudsTopBarActionConfig.widget({
    required Widget widget,
    VoidCallback? onActionPressed,
    String? contentDescription,
  }) {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.widget,
      widget: widget,
      onActionPressed: onActionPressed,
      contentDescription: contentDescription,
    );
  }

  /// Creates a configuration for an empty action, resulting in no visible output.
  factory OudsTopBarActionConfig.none() {
    return OudsTopBarActionConfig._(
      type: OudsTopBarActionType.none,
    );
  }

  /// An internal method that builds the widget for this action on the iOS platform.
  ///
  /// This method is called by [OudsToolbarTop] to render the appropriate
  /// Cupertino-style widget based on the action's [type]. It is not intended
  /// to be called directly by application code.
  ///
  /// **Supported action types:**
  /// - [OudsTopBarActionType.text]: A [CupertinoButton] with a text label.
  /// - [OudsTopBarActionType.back]: A [CupertinoButton] with a back chevron icon and optional label.
  /// - [OudsTopBarActionType.icon]: A [CupertinoButton] with a custom SVG icon.
  /// - [OudsTopBarActionType.widget]: The custom widget provided in the configuration.
  /// - [OudsTopBarActionType.none]: An empty [SizedBox].
  ///
  /// **Throws:**
  /// - [UnimplementedError] if the action [type] is not supported for the iOS platform.

  Widget buildToolbarTopAction(
      BuildContext context,
      bool isLeadingAction) {

    final textStyleModifier = OudsToolbarTopTextStyleModifier();
    final actionModifier = OudsToolbarTopActionModifier();

    switch (type) {
    // TEXT ACTION
      case OudsTopBarActionType.text:
        return CupertinoButton(
              padding: EdgeInsetsDirectional.only(bottom: 1,start: isLeadingAction ? 9 : 1, end: isLeadingAction ? 0 : 8),
              child: Text(
                textAlign: TextAlign.start,
                actionLabel ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                  style: textStyleModifier.getTextActionStyle(context, onActionPressed)
              )
              , onPressed: (){
            onActionPressed?.call();
          }
        );
    // BACK ACTION (icon + optional label)
      case OudsTopBarActionType.back:
        return CupertinoButton(
          padding: EdgeInsetsDirectional.only(top: 5),
          onPressed: () {
            onActionPressed?.call();
          },
          child: Row(
            children: [
              Semantics(
                label: contentDescription
                    ?? OudsLocalizations.of(context)?.core_topAppBar_backNavigationIcon_a11y,
                child: actionModifier.buildBackIcon(context, onActionPressed != null),
              ),
              const SizedBox(width: 2), // Used for spacing
              SizedBox(
                width:  100, // Adjust this value as needed,
                child: Text(previousPageTitle ?? "",
                   overflow: TextOverflow.ellipsis,
                   maxLines: 1,
                   style: textStyleModifier.getTextActionStyle(context, onActionPressed)
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
        return Semantics(
          label: contentDescription,
          child: CupertinoButton(
            minimumSize: Size(26, 26),
            padding: EdgeInsetsDirectional.only(top: 5,start: 8),
            onPressed: () { onActionPressed?.call(); },
            child: actionModifier.buildActionIcon(context,icon,onActionPressed != null),
          ),
        );
    // CUSTOM ACTION (fully custom widget)
      case OudsTopBarActionType.widget:
        return widget ?? SizedBox.shrink();
      default:
        throw UnimplementedError('Type $type not supported for iOS');
    }
  }


  /// An internal method that builds the widget for this action on the Android platform.
  ///
  /// This method is called by [OudsTopAppBar] to render the appropriate
  /// Material-style widget based on the action's [type]. It is not intended
  /// to be called directly by application code.
  ///
  /// **Supported action types:**
  /// - [OudsTopBarActionType.icon]: An icon button, potentially with a badge.
  /// - [OudsTopBarActionType.avatar]: An [OudsAvatar] widget.
  /// - [OudsTopBarActionType.widget]: The custom widget provided in the configuration.
  ///
  /// **Parameters:**
  /// - [context]: The build context for accessing theme and component tokens.
  /// - [showAvatar]: Controls whether the avatar action should be displayed.
  ///   If `false`, returns [SizedBox.shrink] for avatar type. Has no effect on other action types.
  ///
  /// **Throws:**
  /// - [UnimplementedError] if the action [type] is not supported for the Material platform.
  ///
  Widget buildTopAppbarTrailingAction(BuildContext context,bool showAvatar) {

    final theme = OudsTheme.of(context);
      final iconButtonWithBadge =
      MergeSemantics(
        child: Semantics(
          label: contentDescription,
          child: BadgeIconButton(
            icon: icon,
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
          return showAvatar
              ? _buildAvatar(context,theme)
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