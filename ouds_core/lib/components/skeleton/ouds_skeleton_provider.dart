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

import 'package:flutter/widgets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';

/// Controls the skeleton state of supported OUDS components in a subtree.
///
/// The nearest provider determines the shared state. An individual component
/// with `skeleton: true` remains in its skeleton state even when the provider
/// is disabled. Because `skeleton` defaults to `false`, setting it to `false`
/// does not override an enabled provider. A nested disabled provider can
/// exclude a subtree.
///
/// ```dart
/// import 'package:ouds_core/components/skeleton/ouds_skeleton_provider.dart';
///
/// OudsSkeletonProvider(
///   enabled: isLoading,
///   semanticsLabel: localizedLoadingMessage,
///   child: Column(
///     children: [
///       OudsButton(
///         label: 'Continue',
///         appearance: OudsButtonAppearance.defaultAppearance,
///         onPressed: () {},
///       ),
///       OudsTag.text(label: 'Status'),
///     ],
///   ),
/// )
/// ```
///
/// An enabled provider exposes one loading live region and suppresses the
/// individual announcements of skeletons in its scope. Other descendants
/// remain accessible. Supply a localized [semanticsLabel]; no default label
/// is provided. Consecutive enabled providers share the outer announcement;
/// a disabled provider starts an independent scope.
class OudsSkeletonProvider extends StatelessWidget {
  /// Whether supported descendant components display their skeletons.
  final bool enabled;

  /// Optional localized loading announcement for this group.
  ///
  /// For the OUDS loading message, use [OudsLocalizations]:
  /// `OudsLocalizations.of(context)?.core_common_loading_a11y`. If omitted,
  /// the provider has no loading label.
  final String? semanticsLabel;

  /// Descendants controlled by this provider.
  final Widget child;

  /// Creates a scope for a shared skeleton state.
  ///
  /// ```dart
  /// OudsSkeletonProvider(
  ///   enabled: isLoading,
  ///   semanticsLabel: localizedLoadingMessage,
  ///   child: content,
  /// )
  /// ```
  const OudsSkeletonProvider({
    super.key,
    required this.enabled,
    this.semanticsLabel,
    required this.child,
  });

  /// Returns the nearest shared skeleton state, or `false` without a provider.
  static bool isEnabledOf(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_SkeletonScope>()
            ?.enabled ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final announce = enabled && !isEnabledOf(context);
    return _SkeletonScope(
      enabled: enabled,
      child: Semantics(
        container: announce,
        explicitChildNodes: announce,
        liveRegion: announce,
        label: announce
            ? semanticsLabel
            : null,
        child: child,
      ),
    );
  }
}

class _SkeletonScope extends InheritedWidget {
  const _SkeletonScope({required this.enabled, required super.child});

  final bool enabled;

  @override
  bool updateShouldNotify(_SkeletonScope oldWidget) =>
      enabled != oldWidget.enabled;
}
