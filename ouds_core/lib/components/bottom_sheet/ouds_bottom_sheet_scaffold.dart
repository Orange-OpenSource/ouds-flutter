// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

/// {@category BottomSheet}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_constants.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_defaults.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_theme_helper.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Default peek height for the standard bottom sheet (56 dp).
const double kOudsBottomSheetPeekHeight =
    OudsBottomSheetConstants.sheetPeekHeight;

/// A scaffold that displays a standard (persistent) bottom sheet anchored to
/// the bottom of the screen, co-existing with the main content.
///
/// Unlike a modal bottom sheet, a standard bottom sheet remains visible while
/// the user interacts with the rest of the screen.
///
/// ## States
///
/// The sheet has two states:
///
/// | State                 | Height                                      |
/// |-----------------------|---------------------------------------------|
/// | Partially expanded    | [sheetPeekHeight] (default 56 dp)           |
/// | Expanded              | 85 % of the available body height           |
///
/// ## Gestures
///
/// When [sheetSwipeEnabled] is `true`:
/// - **Swipe up** → expands the sheet from partially expanded.
/// - **Swipe down** → collapses the sheet from expanded to peek height.
///
/// ## Programmatic control
///
/// Use a [GlobalKey] to call [OudsBottomSheetScaffoldState.expand] or
/// [OudsBottomSheetScaffoldState.partialExpand]:
///
/// ```dart
/// final scaffoldKey = GlobalKey<OudsBottomSheetScaffoldState>();
///
/// OudsBottomSheetScaffold(
///   key: scaffoldKey,
///   topBar: AppBar(title: Text('My screen')),
///   sheetContent: (context) => Text('Sheet content'),
///   content: (context) => Text('Main content'),
/// );
///
/// // Expand programmatically:
/// scaffoldKey.currentState?.expand();
///
/// // Collapse back to peek height:
/// scaffoldKey.currentState?.partialExpand();
/// ```
///
/// ## Parameters
///
/// - [sheetContent] – Builder for the bottom sheet body.
/// - [content] – Builder for the main screen body.
/// - [sheetPeekHeight] – Height when partially expanded (default 56 dp).
/// - [sheetDragHandle] – Whether to show the drag handle pill (default `true`).
/// - [sheetSwipeEnabled] – Whether swipe gestures are active (default `true`).
/// - [topBar] – Optional top app bar.
/// - [onExpansionChanged] – Called with `true` when expanded, `false` when collapsed.
///
/// ## See also
///
/// - [OudsModalBottomSheet] for a modal variant that blocks the main content.
/// - Flutter's [Scaffold] which this widget wraps internally.
class OudsBottomSheetScaffold extends StatefulWidget {
  const OudsBottomSheetScaffold({
    super.key,
    required this.sheetContent,
    required this.content,
    this.sheetPeekHeight = kOudsBottomSheetPeekHeight,
    this.sheetDragHandle = true,
    this.sheetSwipeEnabled = true,
    this.topBar,
    this.onExpansionChanged,
  });

  /// Builder for the content of the bottom sheet.
  final WidgetBuilder sheetContent;

  /// Builder for the main content of the screen.
  final WidgetBuilder content;

  /// The height of the bottom sheet when it is collapsed.
  final double sheetPeekHeight;

  /// Toggles the visibility of the drag handle at the top of the bottom sheet.
  /// When `true`, shows [OudsBottomSheetDefaults.dragHandle].
  final bool sheetDragHandle;

  /// Whether the sheet swiping is enabled and should react to the user's input.
  final bool sheetSwipeEnabled;

  /// The top app bar of the screen.
  final PreferredSizeWidget? topBar;

  /// Called when the sheet changes between expanded and partially expanded.
  /// `true` = expanded, `false` = collapsed.
  final ValueChanged<bool>? onExpansionChanged;

  @override
  OudsBottomSheetScaffoldState createState() => OudsBottomSheetScaffoldState();
}

/// State for [OudsBottomSheetScaffold].
///
/// Exposes two public methods for programmatic control:
///
/// - [expand] – animates the sheet to its maximum height (85 % of body).
/// - [partialExpand] – animates the sheet back to [OudsBottomSheetScaffold.sheetPeekHeight].
///
/// Access via a [GlobalKey]:
/// ```dart
/// final key = GlobalKey<OudsBottomSheetScaffoldState>();
/// key.currentState?.expand();
/// ```
class OudsBottomSheetScaffoldState extends State<OudsBottomSheetScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late double _currentHeight;
  bool _isExpanded = false;

  /// Whether the sheet is currently expanded.
  bool get isExpanded => _isExpanded;

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.sheetPeekHeight;
    _controller = AnimationController(
      vsync: this,
      duration: OudsBottomSheetConstants.animationDuration,
    );
    _heightAnimation = AlwaysStoppedAnimation(_currentHeight);
    _controller.addListener(() {
      setState(() {
        _currentHeight = _heightAnimation.value;
      });
    });
  }

  @override
  void didUpdateWidget(OudsBottomSheetScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isExpanded &&
        widget.sheetPeekHeight != oldWidget.sheetPeekHeight &&
        !_controller.isAnimating) {
      setState(() {
        _currentHeight = widget.sheetPeekHeight;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _computeExpandedHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight =
        mediaQuery.size.height - mediaQuery.padding.top - kToolbarHeight;
    return (availableHeight * OudsBottomSheetConstants.maxExpandedFraction)
        .clamp(widget.sheetPeekHeight, double.infinity);
  }

  void _animateTo(double to) {
    _heightAnimation = Tween<double>(begin: _currentHeight, end: to).animate(
      CurvedAnimation(
        parent: _controller,
        curve: OudsBottomSheetConstants.animationCurve,
      ),
    );
    _controller.forward(from: 0.0);
  }

  /// Expand the sheet to its maximum height.
  void expand() {
    if (_isExpanded) return;
    _isExpanded = true;
    _animateTo(_computeExpandedHeight(context));
    widget.onExpansionChanged?.call(true);
  }

  /// Collapse the sheet to its peek height.
  void partialExpand() {
    if (!_isExpanded) return;
    _isExpanded = false;
    _animateTo(widget.sheetPeekHeight);
    widget.onExpansionChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final contentColor = theme.colorScheme(context).contentDefault;
    final bottomSheetTheme = OudsBottomSheetThemeHelper.buildThemeData(context);
    final l10n = OudsLocalizations.of(context);

    return Scaffold(
      appBar: widget.topBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.sheetPeekHeight),
              child: widget.content(context),
            ),
          ),
          if (_currentHeight > 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Semantics(
                label: l10n?.core_bottom_sheets_label_a11y ?? '',
                value: _isExpanded
                    ? (l10n?.core_bottom_sheets_expanded_a11y ?? '')
                    : (l10n?.core_bottom_sheets_collapsed_a11y ?? ''),
                child: GestureDetector(
                  // Allows taps to pass through to children while still detecting swipe gestures on the sheet.
                  behavior: HitTestBehavior.translucent,
                  onVerticalDragEnd: widget.sheetSwipeEnabled
                      ? (details) {
                          final velocity = details.primaryVelocity ?? 0;
                          if (velocity <
                                  -OudsBottomSheetConstants
                                      .animationDuration
                                      .inMilliseconds &&
                              !_isExpanded) {
                            expand();
                          } else if (velocity >
                                  OudsBottomSheetConstants
                                      .animationDuration
                                      .inMilliseconds &&
                              _isExpanded) {
                            partialExpand();
                          }
                        }
                      : null,
                  // Wrap with Container for top shadow, matching Android's
                  // sheetShadowElevation = OudsTheme.elevations.emphasized.
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          (bottomSheetTheme.shape as RoundedRectangleBorder?)
                              ?.borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: theme
                              .colorScheme(context)
                              .alwaysBlack
                              .withAlpha((0.30 * 255).round()),
                          // Negative Y offset to cast shadow upward, since
                          // the sheet is anchored at the bottom of the screen.
                          offset: Offset(
                            0,
                            -theme.elevationTokens.emphasized / 2,
                          ),
                          blurRadius: theme.elevationTokens.emphasized,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Material(
                      color: bottomSheetTheme.backgroundColor,
                      elevation: 0,
                      shape: bottomSheetTheme.shape,
                      clipBehavior: bottomSheetTheme.clipBehavior ?? Clip.none,
                      child: SizedBox(
                        height: _currentHeight,
                        child: DefaultTextStyle(
                          style: TextStyle(color: contentColor),
                          child: IconTheme(
                            data: IconThemeData(color: contentColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.sheetDragHandle)
                                  OudsBottomSheetDefaults.dragHandle(context),
                                Flexible(child: widget.sheetContent(context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
