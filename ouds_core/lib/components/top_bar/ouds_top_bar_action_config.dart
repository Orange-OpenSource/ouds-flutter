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
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
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
/// - [badge]: Configuration for a notification badge. This is used  when [type] is [OudsTopBarActionType.icon].
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
  final OudsTopBarActionType type;
  final VoidCallback? onActionPressed;
  final String? contentDescription;
  final Widget? widget;
  final String? icon;
  final OudsTopBarActionBadge? badge;

  ///Cupertino-Only Parameters
  final String? actionLabel;
  final String? previousPageTitle;

  ///Material-Only Parameters
  final OudsTopAppBarAvatarConfig? avatarConfig;

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
    this.previousPageTitle,
  });

  /// Creates a configuration for an icon-based action.
  factory OudsTopBarActionConfig.icon({
    required String icon, // Make this non-nullable for clarity
    VoidCallback? onActionPressed,
    String? contentDescription,
    OudsTopBarActionBadge? badge,
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
    return OudsTopBarActionConfig._(type: OudsTopBarActionType.none);
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

  Widget buildToolbarTopAction(BuildContext context, bool isLeadingAction) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);

    switch (type) {
      // TEXT ACTION
      case OudsTopBarActionType.text:
        return _CustomCupertinoButton(
          type: type,
          onActionPressed: onActionPressed,
          actionLabel: actionLabel,
          isLeadingAction: isLeadingAction,
        );
      // BACK ACTION (icon + optional label)
      case OudsTopBarActionType.back:
        return _CustomCupertinoButton(
          contentDescription: contentDescription,
          onActionPressed: onActionPressed,
          previousPageTitle: previousPageTitle,
          route: currentRoute,
          type: type,
        );
      // NO ACTION
      case OudsTopBarActionType.none:
        return SizedBox.shrink();
      // ICON ACTION
      case OudsTopBarActionType.icon:
        final customCupertinoButton = _CustomCupertinoButton(
          contentDescription: contentDescription,
          type: type,
          onActionPressed: onActionPressed,
          icon: icon,
        );
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: isLeadingAction ? 16 : 0,
            end: isLeadingAction ? 0 : 16,
          ),
          child: badge != null
              ? (badge!.hasCount
                    ? OudsBadge.count(
                        semanticsLabel: badge?.contentDescription,
                        label: badge?.count.toString(),
                        status: Negative(),
                        size: OudsBadgeSize.medium,
                        child: customCupertinoButton,
                      )
                    : OudsBadge.standard(
                        semanticsLabel: badge?.contentDescription,
                        status: Negative(),
                        size: OudsBadgeSize.xsmall,
                        child: customCupertinoButton,
                      ))
              : customCupertinoButton,
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
  Widget buildTopAppbarTrailingAction(BuildContext context, bool showAvatar) {
    final theme = OudsTheme.of(context);
    final iconButtonWithBadge = MergeSemantics(
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
      case OudsTopBarActionType.avatar:
        {
          return showAvatar ? _buildAvatar(context, theme) : SizedBox.shrink();
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

/// NOTE ON THE PRIVATE WIDGETS BELOW
///
/// The standard `CupertinoNavigationBarBackButton` provided by Flutter is not
/// customizable enough to meet the specific requirements of the OUDS design system.
/// We were therefore required to recreate its behavior by referencing Flutter's
/// source code.
///
/// The primary reasons for this custom implementation are:
/// 1.  **Custom Icon**: To replace the default iOS chevron with the specific
///     back arrow icon defined by the OUDS design guidelines.
/// 2.  **Custom Styling**: To gain full control over the appearance (color, opacity)
///     of both the icon and the label, especially during the pressed state (`isPressed`),
///     to match the design system's visual feedback.
/// 3.  **Label Logic**: To implement the design rule where a long previous page
///     title is automatically replaced by the generic "Back" label.
///
/// The following widgets (`_ToolbarTopBackChevron`, `_ToolbarTopBackLabel`, and
/// `_CustomCupertinoButton`) work together to achieve this custom behavior.

/// A private widget that renders the back arrow (chevron) for the Cupertino back button.
class _ToolbarTopBackChevron extends StatelessWidget {
  final String? contentDescription;
  final VoidCallback? onActionPressed;
  final bool isPressed;

  const _ToolbarTopBackChevron(
    this.contentDescription,
    this.onActionPressed,
    this.isPressed,
  );

  @override
  Widget build(BuildContext context) {
    final actionModifier = OudsToolbarTopActionModifier(context);

    // Builds the back icon using a modifier class, which centralizes icon creation.
    // The icon's appearance changes based on whether it's enabled or pressed.
    Widget iconWidget = Semantics(
      label:
          contentDescription ??
          OudsLocalizations.of(context)?.core_topAppBar_backNavigationIcon_a11y,
      child: actionModifier.buildBackIcon(onActionPressed != null, isPressed),
    );

    // KeyedSubtree gives this part of the widget tree a stable identity,
    // which can be useful for testing or advanced framework features.
    return KeyedSubtree(
      key: StandardComponentType.backButton.key,
      child: iconWidget,
    );
  }
}

/// A private widget that displays the title of the previous page next to the
/// back chevron, a common pattern in iOS navigation.
class _ToolbarTopBackLabel extends StatelessWidget {
  const _ToolbarTopBackLabel({
    required this.specifiedPreviousTitle,
    required this.route,
    this.onActionPressed,
    required this.isPressed,
  });

  final String? specifiedPreviousTitle;
  final ModalRoute<dynamic>? route;
  final VoidCallback? onActionPressed;
  final bool isPressed;

  // Builds the Text widget for the previous page's title.
  Widget _buildPreviousTitleWidget(
    BuildContext context,
    String? previousTitle,
    Widget? child,
  ) {
    if (previousTitle == null) {
      return const SizedBox.shrink();
    }
    final textStyleModifier = OudsToolbarTopTextStyleModifier(context);

    // Applies a specific style that can change based on the pressed state.
    Text textWidget = Text(
      previousTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyleModifier.getTextActionStyle(onActionPressed, isPressed),
    );

    // If the title is too long, it defaults to the standard "Back" label
    // provided by Cupertino localizations, adhering to iOS design guidelines.
    if (previousTitle.length > 12) {
      textWidget = Text(CupertinoLocalizations.of(context).backButtonLabel);
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1.0,
      child: textWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    // If a title is explicitly provided, use it.
    if (specifiedPreviousTitle != null) {
      return _buildPreviousTitleWidget(context, specifiedPreviousTitle, null);
    }
    // Otherwise, try to automatically get the title from the previous route
    // using CupertinoRouteTransitionMixin.
    else if (route is CupertinoRouteTransitionMixin<dynamic> &&
        !route!.isFirst) {
      final CupertinoRouteTransitionMixin<dynamic> cupertinoRoute =
          route! as CupertinoRouteTransitionMixin<dynamic>;
      // ValueListenableBuilder ensures the widget rebuilds if the previous
      // route's title changes.
      return ValueListenableBuilder<String?>(
        valueListenable: cupertinoRoute.previousTitle,
        builder: _buildPreviousTitleWidget,
      );
    } else {
      // If no title is available, show nothing.
      return const SizedBox.shrink();
    }
  }
}

/// A custom stateful widget that wraps Cupertino-style actions to manage
/// their pressed state and visual feedback.
class _CustomCupertinoButton extends StatefulWidget {
  final String? contentDescription;
  final String? previousPageTitle;
  final ModalRoute<dynamic>? route;
  final VoidCallback? onActionPressed;
  final OudsTopBarActionType type;
  final bool? isLeadingAction;
  final String? actionLabel;
  final String? icon;

  const _CustomCupertinoButton({
    this.contentDescription,
    this.onActionPressed,
    this.previousPageTitle,
    this.route,
    required this.type,
    this.isLeadingAction,
    this.actionLabel,
    this.icon,
  });

  @override
  State<_CustomCupertinoButton> createState() => _CustomCupertinoButtonState();
}

class _CustomCupertinoButtonState extends State<_CustomCupertinoButton> {
  // Local state to track if the button is currently being pressed.
  bool _isPressed = false;

  // The minimum tap target width for the back button, ensuring it's easy to press.
  final double _kNavBarBackButtonTapWidth = 50.0;

  @override
  Widget build(BuildContext context) {
    final textStyleModifier = OudsToolbarTopTextStyleModifier(context);
    final actionModifier = OudsToolbarTopActionModifier(context);

    // GestureDetector is used to manually control the pressed state,
    // allowing for custom visual feedback without relying on CupertinoButton's
    // default opacity change.
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {}, // onTap is handled by the inner CupertinoButton
      child: _buildButtonByType(context, textStyleModifier, actionModifier),
    );
  }

  /// Builds the appropriate CupertinoButton based on the action type.
  Widget _buildButtonByType(
    BuildContext context,
    OudsToolbarTopTextStyleModifier textStyleModifier,
    OudsToolbarTopActionModifier actionModifier,
  ) {
    switch (widget.type) {
      case OudsTopBarActionType.back:
        return CupertinoButton(
          pressedOpacity: 1, // Disable default opacity feedback.
          padding: EdgeInsetsDirectional.only(top: 5.0, start: 8),
          child: DefaultTextStyle(
            // The text style is passed the `_isPressed` state for custom feedback.
            style: textStyleModifier.getTextActionStyle(
              widget.onActionPressed,
              _isPressed,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: _kNavBarBackButtonTapWidth),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _ToolbarTopBackChevron(
                    widget.contentDescription,
                    widget.onActionPressed,
                    _isPressed,
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 2.0),
                  ),
                  Flexible(
                    child: _ToolbarTopBackLabel(
                      specifiedPreviousTitle: widget.previousPageTitle,
                      route: widget.route,
                      onActionPressed: widget.onActionPressed,
                      isPressed: _isPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            if (widget.onActionPressed != null) {
              widget.onActionPressed!();
            } else {
              // Default back button behavior.
              Navigator.maybePop(context);
            }
          },
        );
      case OudsTopBarActionType.text:
        return CupertinoButton(
          pressedOpacity: 1,
          padding: EdgeInsetsDirectional.only(
            bottom: 1,
            start: (widget.isLeadingAction ?? false) ? 16 : 1,
            end: (widget.isLeadingAction ?? false) ? 1 : 16,
          ),
          onPressed: widget.onActionPressed,
          child: Text(
            widget.actionLabel ?? "",
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // Style changes based on pressed state.
            style: textStyleModifier.getTextActionStyle(
              widget.onActionPressed,
              _isPressed,
            ),
          ),
        );
      case OudsTopBarActionType.icon:
        return Semantics(
          label: widget.contentDescription,
          button: true,
          onTap: widget.onActionPressed,
          child: ExcludeSemantics(
            child: CupertinoButton(
              pressedOpacity: 1,
              minimumSize: Size(26, 26),
              padding: EdgeInsetsDirectional.only(top: 5),
              onPressed: widget.onActionPressed,
              // The icon's appearance changes based on the pressed state.
              child: actionModifier.buildActionIcon(
                widget.icon,
                widget.onActionPressed != null,
                _isPressed,
              ),
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
