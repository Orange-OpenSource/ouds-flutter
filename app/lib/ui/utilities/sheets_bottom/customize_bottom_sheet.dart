//
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/constants_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Centralized `OudsBottomSheetScaffold` wrapper used by every component demo
/// screen, so the scaffold configuration (drag handle, peek height, expand /
/// collapse wiring, accessibility exclusion of the body) and the
/// customization header (drag pill + title/chevron row) are defined once
/// instead of being duplicated in every screen — mirroring the
/// `CustomizationBottomSheetScaffold` composable centralizing the same
/// behavior in the OUDS Android app.
///
/// `OudsBottomSheetScaffold` intentionally mirrors the OUDS Android API
/// (`core/component/OudsBottomSheetScaffold.kt`), which exposes only
/// `sheetContent`, `sheetPeekHeight`, `sheetDragHandle`, `sheetSwipeEnabled`,
/// `topBar` and `content` — there is no header or content-adaptive-height
/// concept on the Android side, since Jetpack Compose's Material 3
/// `BottomSheetScaffold` already sizes itself to its actual content. This
/// widget reproduces the same adaptive behavior purely at the app level,
/// without adding any Android-less parameter to `ouds_core`.
///
/// A demo screen only has to provide its [topBar], the [title] of the
/// customization panel, the [customizationContent] revealed inside the sheet
/// and the [body] displayed behind it:
///
/// ```dart
/// CustomizeBottomSheet(
///   topBar: MainAppBar(title: 'Button', showBackButton: true),
///   title: context.l10n.app_common_customize_label,
///   customizationContent: const _CustomizationContent(),
///   body: _Body(),
/// )
/// ```
///
/// The expanded height automatically fits [customizationContent]'s natural
/// size, capped at [ConstantSheetBottom.expandedHeightFraction] of the real
/// screen height, so a short customization panel doesn't leave an empty gap
/// while a tall one is still capped instead of covering the whole screen.
class CustomizeBottomSheet extends StatefulWidget {
  /// Creates a [CustomizeBottomSheet].
  const CustomizeBottomSheet({
    super.key,
    required this.topBar,
    required this.title,
    required this.customizationContent,
    required this.body,
  });

  /// The top app bar of the screen, forwarded to the underlying
  /// `OudsBottomSheetScaffold`.
  final PreferredSizeWidget topBar;

  /// The title displayed next to the chevron in the sheet header.
  final String title;

  /// The customization content revealed while the sheet is expanded.
  final Widget customizationContent;

  /// The main screen content displayed behind the sheet.
  final Widget body;

  @override
  State<CustomizeBottomSheet> createState() => _CustomizeBottomSheetState();
}

class _CustomizeBottomSheetState extends State<CustomizeBottomSheet> {
  final _scaffoldKey = GlobalKey<OudsBottomSheetScaffoldState>();
  final _headerKey = GlobalKey();
  final _contentKey = GlobalKey();
  bool _isExpanded = false;
  double? _measuredHeaderHeight;
  double? _measuredContentHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  /// Reads the natural (unconstrained) height of the header and of the
  /// customization content, so [build] can size the expanded sheet to fit
  /// its actual content instead of always jumping to the maximum height.
  void _measure() {
    if (!mounted) return;
    final headerBox =
        _headerKey.currentContext?.findRenderObject() as RenderBox?;
    final contentBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    final headerHeight = headerBox != null && headerBox.hasSize
        ? headerBox.size.height
        : _measuredHeaderHeight;
    final contentHeight = contentBox != null && contentBox.hasSize
        ? contentBox.size.height
        : _measuredContentHeight;
    if (headerHeight != _measuredHeaderHeight ||
        contentHeight != _measuredContentHeight) {
      setState(() {
        _measuredHeaderHeight = headerHeight;
        _measuredContentHeight = contentHeight;
      });
    }
  }

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }

  void _toggle() {
    if (_isExpanded) {
      _scaffoldKey.currentState?.partialExpand();
    } else {
      _scaffoldKey.currentState?.expand();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // `OudsBottomSheetScaffold.expand()` always targets 85 % of its
    // available height (mirroring the fixed constant used internally by
    // `ouds_core`, itself matching Android's expanded-sheet sizing before
    // any content-fit adjustment). To make the expanded sheet fit its actual
    // content — capped at `expandedHeightFraction` of the true screen —
    // without touching `ouds_core` (whose public API intentionally mirrors
    // Android's, which has no such parameter), report a reduced height via
    // MediaQuery so that 85 % of that reduced height equals the desired
    // expanded height.
    final maxAllowedHeight =
        mediaQuery.size.height * ConstantSheetBottom.expandedHeightFraction;
    final naturalHeight =
        (_measuredHeaderHeight ?? 0) + (_measuredContentHeight ?? 0);
    final desiredExpandedHeight = naturalHeight > 0
        ? naturalHeight.clamp(
            ConstantSheetBottom.collapsedHeight,
            maxAllowedHeight,
          )
        // Fallback used only before the first post-frame measurement.
        : maxAllowedHeight;
    final reducedHeight =
        desiredExpandedHeight /
            ConstantSheetBottom.oudsBottomSheetMaxExpandedFraction +
        mediaQuery.padding.top +
        kToolbarHeight;

    return MediaQuery(
      data: mediaQuery.copyWith(
        size: Size(mediaQuery.size.width, reducedHeight),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: defaultTargetPlatform == TargetPlatform.android
              ? mediaQuery.viewPadding.bottom
              : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
        ),
        child: OudsBottomSheetScaffold(
          key: _scaffoldKey,
          onExpansionChanged: _onExpansionChanged,
          sheetDragHandle: false,
          sheetPeekHeight: ConstantSheetBottom.collapsedHeight,
          topBar: widget.topBar,
          sheetContent: (sheetContext) =>
              NotificationListener<SizeChangedLayoutNotification>(
                onNotification: (notification) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _measure(),
                  );
                  return false;
                },
                child: _CustomizeBottomSheetContent(
                  headerKey: _headerKey,
                  contentKey: _contentKey,
                  title: widget.title,
                  isExpanded: _isExpanded,
                  onToggle: _toggle,
                  child: widget.customizationContent,
                ),
              ),
          content: (bodyContext) =>
              ExcludeSemantics(excluding: _isExpanded, child: widget.body),
        ),
      ),
    );
  }
}

/// The drag handle pill, title/chevron header and expand/collapse-driven
/// visibility of [child], rendered inside the `OudsBottomSheetScaffold`'s
/// `sheetContent`.
///
/// [child] is always mounted — hidden via [Offstage] instead of removed from
/// the tree while collapsed — so its natural (unconstrained) height can
/// always be measured (via [contentKey]) regardless of the sheet's current
/// state, letting [CustomizeBottomSheet] size the expanded sheet to fit it.
///
/// [child] is always wrapped in a [SingleChildScrollView] with extra bottom
/// padding, so it never triggers a `RenderFlex` overflow — including while
/// the sheet is still animating towards its expanded height — and so its
/// last item is never flush against (or clipped by) the bottom edge of the
/// sheet.
class _CustomizeBottomSheetContent extends StatelessWidget {
  const _CustomizeBottomSheetContent({
    required this.headerKey,
    required this.contentKey,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  /// Key used by [CustomizeBottomSheet] to measure the header's natural
  /// height.
  final Key headerKey;

  /// Key used by [CustomizeBottomSheet] to measure [child]'s natural height.
  final Key contentKey;

  /// The title displayed next to the chevron.
  final String title;

  /// Whether the bottom sheet is currently expanded.
  final bool isExpanded;

  /// Called when the user taps the drag handle or the header, or swipes the
  /// sheet, to toggle between expanded and collapsed states.
  final VoidCallback onToggle;

  /// The customization content revealed while the sheet is expanded.
  final Widget child;

  void _handlePanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dy;
    if (velocity.abs() > 100 && velocity != 0.0) {
      onToggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final l10n = OudsLocalizations.of(context);

    return Semantics(
      label: l10n?.core_bottom_sheets_label_a11y,
      value: isExpanded
          ? l10n?.core_bottom_sheets_expanded_a11y
          : l10n?.core_bottom_sheets_collapsed_a11y,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizeChangedLayoutNotifier(
            child: KeyedSubtree(
              key: headerKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onToggle,
                    onPanEnd: _handlePanEnd,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: theme.spaceScheme(context).scaledMedium,
                            ),
                            child: Container(
                              width: 40,
                              height: 5,
                              margin: EdgeInsetsDirectional.symmetric(
                                vertical: theme
                                    .spaceScheme(context)
                                    .scaledTwoExtraSmall,
                              ),
                              decoration: BoxDecoration(
                                color: theme
                                    .colorScheme(context)
                                    .contentDefault,
                                borderRadius: BorderRadius.circular(
                                  ConstantSheetBottom.sheetRadius,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ExcludeSemantics(
                    child: GestureDetector(
                      onTap: onToggle,
                      onPanEnd: _handlePanEnd,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            AnimatedRotation(
                              turns: isExpanded
                                  ? ConstantSheetBottom.chevronTurns
                                  : 0.0,
                              duration: Duration(
                                milliseconds: ConstantSheetBottom
                                    .animatedRotationDuration,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.expand_more,
                                  size: ConstantSheetBottom.expandIconSize,
                                ),
                                onPressed: onToggle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                style: theme.typographyTokens
                                    .typeBodyStrongLarge(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Offstage(
              offstage: !isExpanded,
              child: SingleChildScrollView(
                child: SizeChangedLayoutNotifier(
                  child: KeyedSubtree(
                    key: contentKey,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: theme.spaceScheme(context).fixedMedium,
                      ),
                      child: child,
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
