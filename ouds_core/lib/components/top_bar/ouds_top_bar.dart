
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
/// A platform-adaptive top bar that provides screen titles and actions.
///
/// This library contains [OudsTopBar], a versatile app bar that automatically
/// renders a Material [OudsTopAppBar] on Android and a Cupertino
/// [OudsToolbarTop] on iOS, allowing for a single, unified API in your app.
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/top_bar/ouds_toolbar_top.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';

/// Alias for [OudsTopBar].
///
/// This can be used for developers who prefer an API that more closely
/// resembles Flutter's `AppBar` naming convention.
typedef OudsAppBar = OudsTopBar;

/// Specifies the vertical size of the [OudsTopBar].
enum OudsTopBarSize {
  /// A standard-height top bar.
  small,
  /// An expanded-height top bar.(Material only).
  medium,
  /// A larger expanded-height top bar, often used for prominent titles or imagery.
  large
}

/// Defines the type of action to be displayed in an [OudsTopBar].
///
/// This enum is used by [OudsTopBarActionConfig] to determine how an action
/// should be rendered.
enum OudsTopBarActionType {
  // Common Types
  /// No action is displayed.
  none,

  /// Displays a single icon button.
  icon,

  /// Displays a custom widget.
  widget,

  // Navigation Types
  /// Displays a back arrow.
  back,

  /// A developer-defined custom leading icon. For Material only.
  custom,

  /// Displays a close (X) button. For Material only.
  close,

  /// Displays a menu icon. For Material only
  menu,

  // Platform-Specific Types
  /// An action displayed as a text label. Primarily for Cupertino.
  text,

  /// An action that displays a user avatar. For Material only.
  avatar,
}

/// A platform-adaptive top app bar that displays information and actions
/// relating to the current screen.
///
/// **Reference design version : 1.0.0**
///
/// The Bar top is a top-aligned component that displays the screen title
/// and provides access to key actions and navigation elements.
///
/// `OudsTopBar` is a high-level component that provides a consistent top bar
/// experience across platforms by rendering the appropriate underlying widget:
/// - **[OudsTopAppBar]** on Android (based on Material 3 [AppBar]).
/// - **[OudsToolbarTop]** on iOS (based on [CupertinoNavigationBar]).
///
/// This abstraction allows you to define your app bar once, with the component
/// handling the platform-specific rendering details.
///
/// ### Parameters:
///
/// #### Common parameters
///
/// - [title]: The title to be displayed in the top bar.
/// - [size]: The size of the Bar Top defined by [OudsTopBarSize].
///   - Medium size is only supported in the Material variant.
/// - [translucent]: Whether the Bar Top should be translucent.
///
/// - [leadingActions]: A list of actions to display before the title.
///   - Material: Supports a single leading action.
///   - Cupertino: Supports multiple leading actions.
///
/// - [trailingActions]: A list of actions to display at the end of the Bar Top. These can be
///     type of [OudsTopBarActionConfig].
///     The default layout here is a [Row], so actions will be placed horizontally.
///     The maximum recommended number of actions is three, it list of [OudsTopBarActionConfig],
///     Please use a dropdown menu if you need more than three actions.
///
/// #### Material variant only (ignored on Cupertino)
///  -[materialConfig]: This parameter is only applied on Material and other non-iOS platforms where
///     the widget renders an [OudsTopAppBar]. Use this to control Material-only features like
///     `centerTitle` or `expandedHeight`. See [OudsTopAppBarConfig]. It is ignored on iOS.
///
/// Use an [OudsTopAppBarConfig] object to control Material-specific features
/// such as:
/// - Centering the title (`centerTitle`).
/// - Setting a custom expanded height (`expandedHeight`).
/// - Specifying the maximum number of lines for the title (`titleMaxLines`).
/// - Enabling avatar support (`showAvatar`).
///
///
/// ### Example usage:
///
/// The following example shows a simple `OudsTopBar` with a back button and a
/// trailing search action.
///
/// ```dart
/// Scaffold(
///   appBar: OudsTopBar(
///     title: "My Screen",
///     leadingActions: [
///       OudsTopBarActionConfig.back(
///         onActionPressed: () => Navigator.of(context).pop(),
///       ),
///     ],
///     trailingActions: [
///       OudsTopBarActionConfig.icon(
///         customIcon: "assets/icons/search.svg",
///         contentDescription: "Search",
///         onActionPressed: () {
///           // Handle search action
///         },
///       ),
///     ],
///   ),
///   body: // ...
/// )
/// ```
///
/// ### Platform Differences
///
/// - **Leading Actions**: The Material `AppBar` typically has a single leading
///   action (e.g., a navigation icon). The Cupertino `CupertinoNavigationBar`
///   can support multiple leading actions. This widget enforces a single leading
///   action on Android to align with Material Design guidelines.
///
/// - **Size**: The `medium` and `large` sizes create an expandable `AppBar` on
///   Android. On iOS, `medium` is treated as `small`.
///
///
/// See also:
///
///  * [OudsTopAppBar], the Material Design implementation.
///  * [OudsToolbarTop], the Cupertino (iOS) implementation.
///  * [OudsTopBarActionConfig], the configuration object for actions.
///
class OudsTopBar extends StatelessWidget implements PreferredSizeWidget{

  /// Common parameters
  final String? title;
  final bool translucent;
  final OudsTopBarSize size;
  final List<OudsTopBarActionConfig>? leadingActions;
  final List<OudsTopBarActionConfig>? trailingActions;

  /// Platform-specific configuration for Material (Android).
  final OudsTopAppBarConfig? materialConfig;

  const OudsTopBar({
    super.key,
    this.title,
    this.translucent = false,
    this.size = OudsTopBarSize.small,
    this.leadingActions,
    this.trailingActions,

    /// This parameter is ignored on iOS/Cupertino
    this.materialConfig,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return OudsToolbarTop(
        title: title,
        translucent: translucent,
        style: size,
        leadingActions: leadingActions,
        trailingActions: trailingActions,
      );
    }else{
      // Material only supports single leading action
      assert(
      leadingActions == null || leadingActions!.length <= 1,
      'Material variant only supports a single leading action. '
          'Received ${leadingActions?.length} actions.',
      );
      return OudsTopAppBar(
        title: title,
        translucent: translucent,
        size: size,
        leadingActions: leadingActions,
        trailingActions: trailingActions,
        centerTitle: materialConfig?.centerTitle,
        expandedHeight: materialConfig?.expandedHeight,
        titleMaxLines: materialConfig?.titleMaxLines ?? 1,
        showAvatar: materialConfig?.showAvatar ?? false,
      );
    }
  }

  /// Returns the preferred size based on the platform: OudsToolbarTop size for iOS,
  /// OudsTopAppBar size for Android and other platforms.
  @override
  Size get preferredSize => defaultTargetPlatform == TargetPlatform.iOS
      ? OudsToolbarTop.getPreferredSize
      : OudsTopAppBar.getPreferredSize(size: size,expandedHeight: materialConfig?.expandedHeight);

  /// Returns the preferred size based on the platform: OudsToolbarTop size for iOS,
  /// OudsTopAppBar size for Android and other platforms.
  ///
  /// This method is static, so it can be called outside this class without instantiating the widget.
  /// Note: The parameters is only required for Android; it is ignored on iOS.
  ///
  /// Parameters:
  /// - [size]: The size of the top bar.
  /// - [expandedHeight]: The expanded height of the bar.
  ///
  /// Returns:
  /// - A [Size] object representing the preferred size.
  static Size getPreferredSize({OudsTopBarSize? size, double? expandedHeight}){
   return defaultTargetPlatform == TargetPlatform.iOS
        ? OudsToolbarTop.getPreferredSize
        : OudsTopAppBar.getPreferredSize(size: size!,expandedHeight: expandedHeight);
  }
}
/// A configuration object for Material-specific properties.
///
/// - [centerTitle]: Whether to center the title. Defaults to false.
/// - [expandedHeight]: This Bar Top's height. Should be applied only for
///     [OudsTopBarSize.medium] and [OudsTopBarSize.large] for [OudsTopBarSize.small] wll be ignored,
///     this value will represent the maximum height that the bar will be allowed to expand.
/// - [titleMaxLines]: Specifies the number of lines the title can span for medium and large Bar Tops.
/// - [showAvatar]: Whether avatar support is enabled in the Bar Top.
///
/// ### Example usage:
///
/// ```dart
/// Scaffold(
///   appBar: OudsTopBar(
///     title: "Profile",
///     size: OudsTopBarSize.large,
///     materialConfig: const OudsTopAppBarConfig(
///       centerTitle: true,
///       expandedHeight: 200.0,
///       titleMaxLines: 2,
///       showAvatar: true,
///     ),
///   ),
/// )
/// ```
class OudsTopAppBarConfig {
  final bool centerTitle;
  final double? expandedHeight;
  final int titleMaxLines;
  final bool showAvatar;

  const OudsTopAppBarConfig({
    this.centerTitle = false,
    this.expandedHeight,
    this.titleMaxLines = 1,
    this.showAvatar = false,
  });
}