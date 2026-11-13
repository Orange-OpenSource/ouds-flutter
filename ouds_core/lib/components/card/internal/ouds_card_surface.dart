// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/card/internal/ouds_card_modifier.dart';
import 'package:ouds_core/components/card/internal/ouds_card_scope.dart';
import 'package:ouds_core/components/card/ouds_action_card.dart';
import 'package:ouds_core/components/card/ouds_card_style.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/internal/ouds_progress_indicator_utils.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_core/components/skeleton/internal/ouds_skeleton_layout.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsCardSurface extends StatefulWidget {
  const OudsCardSurface({
    super.key,
    this.semanticsLabel,
    required this.child,
    this.actionable = false,
    this.onPressed,
    this.style = OudsCardStyle.filled,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.loader,
    this.skeleton,
  });

  final String? semanticsLabel;
  final Widget child;
  final bool actionable;
  final VoidCallback? onPressed;
  final OudsCardStyle style;
  final bool enabled;
  final bool backgroundColor;
  final bool divider;
  final OudsCardLoader? loader;
  final OudsSkeleton? skeleton;

  @override
  State<OudsCardSurface> createState() => _OudsCardSurfaceState();
}

class _OudsCardSurfaceState extends State<OudsCardSurface> {
  final _states = WidgetStatesController();

  @override
  void dispose() {
    _states.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final enabled =
        widget.enabled && (!widget.actionable || widget.onPressed != null);
    final loader = widget.loader;
    final progress = loader?.progress;
    final loading = enabled && loader != null && widget.skeleton == null;
    final interactive = enabled && !loading && widget.skeleton == null;
    // A nested card cannot re-enable the content of a disabled parent.
    final contentEnabled = enabled && OudsCardScope.enabledOf(context);
    _states.update(WidgetState.disabled, !interactive);
    final rounded = OudsThemeConfigModel.of(context)?.card?.rounded ?? false;
    final radius = rounded
        ? theme.borderTokens.radiusLarge
        : theme.borderTokens.radiusNone;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );

    final cardModifier = OudsCardModifier(context);

    return OudsSkeletonLayout(
      visible: widget.skeleton != null,
      hasSecurityMargin: widget.skeleton?.hasSecurityMargin ?? false,
      animated: widget.skeleton?.animated ?? false,
      shape: shape,
      content: (context) => ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _states,
        builder: (context, states, _) {
          final colors = theme.colorScheme(context);
          final focused =
              widget.actionable &&
              interactive &&
              states.contains(WidgetState.focused);
          final pressed =
              widget.actionable &&
              interactive &&
              states.contains(WidgetState.pressed);
          final hovered =
              widget.actionable &&
              interactive &&
              states.contains(WidgetState.hovered);
          final (:borderColor, :overlayColor) = cardModifier
              .getInteractionColors(
                style: widget.style,
                enabled: enabled,
                loading: loading,
                pressed: pressed,
                focused: focused,
                hovered: hovered,
              );

          final surfaceShape = shape.copyWith(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(
                    color: borderColor,
                    width: theme.borderTokens.widthThin,
                  ),
          );

          final cardBorderRadius = OudsCardModifier.getBorderRadiusFocus(
            context,
          );
          final content = ExcludeFocus(
            excluding: widget.actionable || !interactive,
            child: AbsorbPointer(
              absorbing: widget.actionable || !interactive,
              child: ExcludeSemantics(
                excluding: widget.actionable || loading,
                child: Visibility(
                  visible: !loading,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: OudsCardScope(
                    enabled: contentEnabled,
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );

          final body = Stack(
            alignment: AlignmentDirectional.centerStart,
            clipBehavior: Clip.none,
            children: [
              content,
              if (overlayColor != null)
                Positioned.fill(
                  child: IgnorePointer(child: ColoredBox(color: overlayColor)),
                ),
              if (widget.divider && widget.style == OudsCardStyle.filled)
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: 0,
                  child: ExcludeSemantics(
                    child: SizedBox(
                      height: theme.borderTokens.widthThin,
                      child: ColoredBox(color: colors.borderMuted),
                    ),
                  ),
                ),
              if (loading)
                Positioned.fill(
                  child: Center(
                    child: ExcludeSemantics(
                      child: OudsCircularProgressIndicator(
                        progressType: progress == null
                            ? OudsProgressIndicatorType.indeterminate
                            : OudsProgressIndicatorType.determinate,
                        value: progress?.clamp(0, 1).toDouble(),
                        status: const Accent(),
                        track: false,
                      ),
                    ),
                  ),
                ),
              if (focused)
                Positioned.fill(
                  left: -theme.borderTokens.widthFocus,
                  right: -theme.borderTokens.widthFocus,
                  top: -theme.borderTokens.widthFocus,
                  bottom: -theme.borderTokens.widthFocus,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        border: OudsBorder().borderAll(
                          color: theme.colorScheme(context).borderFocus,
                          width: theme.borderTokens.widthFocus / 2,
                        ),
                        // The border radius should match the card's radius.
                        borderRadius: cardBorderRadius,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: OudsBorder().borderAll(
                            color: OudsTheme.of(
                              context,
                            ).colorScheme(context).borderFocusInset,
                            width: theme.borderTokens.widthFocusInset,
                          ),
                          borderRadius: cardBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
          return Semantics(
            container: true,
            explicitChildNodes: !widget.actionable,
            label: widget.semanticsLabel,
            button: widget.actionable ? true : null,
            enabled: widget.actionable || !enabled ? interactive : null,
            liveRegion: loading,
            value: loading
                ? OudsProgressIndicatorUtils.buildSemanticsLabel(
                    OudsLocalizations.of(context)?.core_common_loading_a11y,
                    OudsProgressIndicatorUtils.buildSemanticValueLabel(
                      progress == null
                          ? OudsProgressIndicatorType.indeterminate
                          : OudsProgressIndicatorType.determinate,
                      progress,
                      OudsLocalizations.of(context),
                    ),
                  )
                : null,
            onTap: widget.actionable && interactive ? widget.onPressed : null,
            child: Material(
              type: MaterialType.card,
             color: cardModifier.getBackgroundColor(
                widget.style,
                widget.backgroundColor,
                enabled,
              ),
              shadowColor: theme.colorScheme(context).actionEnabled,//todo change to ouds/elevation/color/raised
              surfaceTintColor: Colors.transparent,
              elevation: widget.style == OudsCardStyle.elevated
                  ? theme.elevationTokens.raised
                  : theme.elevationTokens.none,
              shape: focused
                  ? shape.copyWith(
                      side: BorderSide(
                        color: theme.colorScheme(context).actionFocus,
                        width: theme.borderTokens.widthThin,
                      ),
                    )
                  : surfaceShape,
              child: widget.actionable
                  ? InkWell(
                      onTap: interactive ? widget.onPressed : null,
                      canRequestFocus: interactive,
                      excludeFromSemantics: true,
                      statesController: _states,
                      customBorder: shape,
                      overlayColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      child: body,
                    )
                  : body,
            ),
          );
        },
      ),
    );
  }
}
