// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

/// {@category BottomSheet}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_defaults.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_theme_helper.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A modal bottom sheet that temporarily blocks interaction with the main
/// screen, displaying secondary content anchored to the bottom.
///
/// The sheet appears in front of app content with a scrim overlay, and remains
/// on screen until dismissed by the user (tap outside, swipe down, or back
/// button).
///
/// ## Height
///
/// The sheet occupies up to **95 %** of the available body height (screen
/// minus status bar and toolbar), ensuring the top bar stays visible.
///
/// ## Drag handle
///
/// When [dragHandle] is `true` (default), a custom OUDS drag handle pill is
/// displayed at the top of the sheet, matching the Android implementation.
///
/// ## Usage
///
/// ```dart
/// OudsModalBottomSheet(
///   dragHandle: true,
///   sheetGesturesEnabled: true,
///   builder: (context) {
///     return Text('Sheet content');
///   },
/// ).show(context: context);
/// ```
///
/// ## Parameters
///
/// - [dragHandle] – Whether to show the drag handle pill (default `true`).
/// - [builder] – Builder for the sheet content.
/// - [sheetGesturesEnabled] – Whether swipe-to-dismiss is enabled (default `true`).
///   Maps to Flutter's `enableDrag` parameter.
///
/// ## See also
///
/// - [OudsBottomSheetScaffold] for a persistent (standard) bottom sheet.
/// - Flutter's [showModalBottomSheet] which this class wraps internally.
class OudsModalBottomSheet {
  const OudsModalBottomSheet({
    this.dragHandle = true,
    required this.builder,
    this.sheetGesturesEnabled = true,
  });

  /// Whether to show the drag handle pill.
  final bool dragHandle;

  /// Builder for the sheet content.
  final WidgetBuilder builder;

  /// Whether drag gestures are enabled.
  /// Maps to Flutter's [showModalBottomSheet.enableDrag].
  final bool sheetGesturesEnabled;

  /// Display this [OudsModalBottomSheet] as a modal dialog.
  ///
  /// Wraps Flutter's [showModalBottomSheet] with OUDS theming applied.
  ///
  /// ## Parameters
  ///
  /// - [context] – The build context used to look up the [Navigator].
  /// - [onDismissRequest] – Optional callback invoked when the sheet is dismissed.
  /// - [isScrollControlled] – Whether the sheet height is controlled by its
  ///   content (default `true`). Maps to [showModalBottomSheet.isScrollControlled].
  /// - [useRootNavigator] – Whether to use the root navigator (default `false`).
  /// - [routeSettings] – Optional route settings passed to the modal route.
  Future<T?> show<T>({
    required BuildContext context,
    VoidCallback? onDismissRequest,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) {
    final theme = OudsTheme.of(context);
    final colorScheme = theme.colorScheme(context);
    final contentColor = colorScheme.contentDefault;

    final bottomSheetTheme = OudsBottomSheetThemeHelper.buildThemeData(context);

    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: bottomSheetTheme.modalBackgroundColor,
      barrierColor: bottomSheetTheme.modalBarrierColor,
      shape: bottomSheetTheme.shape,
      elevation: bottomSheetTheme.modalElevation,
      clipBehavior: bottomSheetTheme.clipBehavior,
      isDismissible: true,
      enableDrag: sheetGesturesEnabled,
      showDragHandle: false,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      constraints: BoxConstraints(
        maxHeight:
            (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight) *
            0.95,
      ),
      builder: (sheetContext) {
        return DefaultTextStyle(
          style: TextStyle(color: contentColor),
          child: IconTheme(
            data: IconThemeData(color: contentColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (dragHandle)
                  OudsBottomSheetDefaults.dragHandle(sheetContext),
                Expanded(child: builder(sheetContext)),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() => onDismissRequest?.call());
  }
}
