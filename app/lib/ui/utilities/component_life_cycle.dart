// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:ouds_core/components/alert/ouds_inline_alert.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Identifies a component family whose design lifecycle is tracked.
enum ComponentType {
  /// Alert message and inline alert components.
  alert,

  /// Standard, count, and icon badges.
  badge,

  /// Bottom sheet components.
  bottomSheet,

  /// Navigation bar component.
  navigationBar,

  /// Button and navigation button components.
  button,

  /// Checkbox component.
  checkbox,

  /// Filter and suggestion chips.
  chip,

  /// Divider component.
  divider,

  /// Link component.
  link,

  /// List item and card item components.
  listItem,

  /// Password input component.
  passwordInput,

  /// Phone number input component.
  phoneNumberInput,

  /// PIN code input component.
  pinCodeInput,

  /// Circular and linear progress indicators.
  progressIndicator,

  /// Radio button component.
  radioButton,

  /// Skeleton loading component.
  skeleton,

  /// Switch button component.
  switchButton,

  /// Tag and input tag components.
  tag,

  /// Text input component.
  textInput,

  /// Top app bar component.
  topAppBar,

  /// Body, code, display, heading, and label typography components.
  typography,
}

/// Lifecycle maturity derived from a component's design version.
enum ComponentLifeCycleStatus {
  /// The design version is `0.0.0`.
  draft,

  /// The design version has a zero major number but is not `0.0.0`.
  wip,

  /// The design version has a non-zero major number.
  production,
}

/// Resolves component lifecycle status and builds its related demo UI.
///
/// Lifecycle is derived from the design version of every variant in a
/// [ComponentType]. When variants have different maturities, the least mature
/// status is used.
///
/// For example, wrap a demo screen to make its lifecycle alert available to
/// descendant widgets:
///
/// ```dart
/// ComponentLifeCycle.demoScreen(
///   ComponentType.button,
///   const ButtonDemoScreen(),
/// )
/// ```
class ComponentLifeCycle {
  const ComponentLifeCycle._();

  /// Associates [screen] with [type] for lifecycle-aware descendant widgets.
  ///
  /// A descendant can use [demoAlert] to show the appropriate lifecycle alert.
  static Widget demoScreen(ComponentType type, Widget screen) {
    return _ComponentLifeCycleScope(type: type, child: screen);
  }

  /// Returns the lifecycle alert for the nearest [demoScreen] scope.
  ///
  /// Returns `null` when the [context] is not below a lifecycle scope or when
  /// the scoped component is in production.
  static Widget? demoAlert(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_ComponentLifeCycleScope>();
    return scope == null ? null : alert(context, scope.type);
  }

  /// Returns the least mature status among the design versions for [type].
  static ComponentLifeCycleStatus status(ComponentType type) {
    final versions = switch (type) {
      ComponentType.alert => [
        OudsComponentVersion.alertMessage,
        OudsComponentVersion.inlineAlert,
      ],
      ComponentType.badge => [
        OudsComponentVersion.badge,
        OudsComponentVersion.badgeCount,
        OudsComponentVersion.badgeIcon,
      ],
      ComponentType.bottomSheet => [OudsComponentVersion.bottomSheet],
      ComponentType.navigationBar => [OudsComponentVersion.navigationBar],
      ComponentType.button => [
        OudsComponentVersion.button,
        OudsComponentVersion.navigationButton,
      ],
      ComponentType.checkbox => [OudsComponentVersion.checkbox],
      ComponentType.chip => [
        OudsComponentVersion.filterChip,
        OudsComponentVersion.suggestionChip,
      ],
      ComponentType.divider => [OudsComponentVersion.divider],
      ComponentType.link => [OudsComponentVersion.link],
      ComponentType.listItem => [
        OudsComponentVersion.staticListItem,
        OudsComponentVersion.navigationListItem,
        OudsComponentVersion.staticCardItem,
        OudsComponentVersion.navigationCardItem,
      ],
      ComponentType.passwordInput => [OudsComponentVersion.passwordInput],
      ComponentType.phoneNumberInput => [OudsComponentVersion.phoneNumberInput],
      ComponentType.pinCodeInput => [OudsComponentVersion.pinCodeInput],
      ComponentType.progressIndicator => [
        OudsComponentVersion.circularProgressIndicator,
        OudsComponentVersion.linearProgressIndicator,
      ],
      ComponentType.radioButton => [OudsComponentVersion.radioButton],
      ComponentType.skeleton => [OudsComponentVersion.skeleton],
      ComponentType.switchButton => [OudsComponentVersion.switchButton],
      ComponentType.tag => [
        OudsComponentVersion.tag,
        OudsComponentVersion.inputTag,
      ],
      ComponentType.textInput => [OudsComponentVersion.textInput],
      ComponentType.topAppBar => [OudsComponentVersion.appBar],
      ComponentType.typography => [
        OudsComponentVersion.body,
        OudsComponentVersion.code,
        OudsComponentVersion.display,
        OudsComponentVersion.heading,
        OudsComponentVersion.label,
      ],
    };
    return fromVersions(versions);
  }

  /// Converts a semantic design [version] into its lifecycle status.
  ///
  /// The version must use `major.minor.patch` numeric notation. `0.0.0` is
  /// draft, other `0.x.y` versions are work in progress, and versions with a
  /// non-zero major number are production.
  ///
  /// Throws [FormatException] if [version] is not a valid semantic version.
  static ComponentLifeCycleStatus fromVersion(String version) {
    final match = RegExp(
      r'^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$',
    ).firstMatch(version);
    if (match == null) {
      throw FormatException('Invalid component design version', version);
    }
    if (version == '0.0.0') return ComponentLifeCycleStatus.draft;
    if (match[1] == '0') return ComponentLifeCycleStatus.wip;
    return ComponentLifeCycleStatus.production;
  }

  /// Returns the least mature status among [versions].
  ///
  /// Throws [ArgumentError] when [versions] is empty, and [FormatException]
  /// when any version is invalid.
  static ComponentLifeCycleStatus fromVersions(List<String> versions) {
    if (versions.isEmpty) {
      throw ArgumentError.value(versions, 'versions', 'Must not be empty');
    }
    final maturities = versions.map(fromVersion).toList();
    if (maturities.contains(ComponentLifeCycleStatus.draft)) {
      return ComponentLifeCycleStatus.draft;
    }
    if (maturities.contains(ComponentLifeCycleStatus.wip)) {
      return ComponentLifeCycleStatus.wip;
    }
    return ComponentLifeCycleStatus.production;
  }

  /// Builds a lifecycle tag for [type], or returns `null` in production.
  static Widget? tag(BuildContext context, ComponentType type) {
    return switch (status(type)) {
      ComponentLifeCycleStatus.draft => OudsTag.text(
        label: context.l10n.app_components_maturity_draft_label,
        status: const Info(),
      ),
      ComponentLifeCycleStatus.wip => OudsTag.text(
        label: context.l10n.app_components_maturity_wip_label,
        status: const Info(),
        appearance: OudsTagAppearance.muted,
      ),
      ComponentLifeCycleStatus.production => null,
    };
  }

  /// Builds a lifecycle alert for [type], or returns `null` in production.
  static Widget? alert(BuildContext context, ComponentType type) {
    final lifeCycleStatus = status(type);
    if (lifeCycleStatus == ComponentLifeCycleStatus.production) return null;

    final inset = OudsTheme.of(context).spaceScheme(context).insetMedium;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: inset, end: inset, top: inset),
      child: OudsInlineAlert(
        status: const Info(),
        label: lifeCycleStatus == ComponentLifeCycleStatus.draft
            ? context.l10n.app_components_maturity_draft_description
            : context.l10n.app_components_maturity_wip_description,
      ),
    );
  }
}

class _ComponentLifeCycleScope extends InheritedWidget {
  const _ComponentLifeCycleScope({required this.type, required super.child});

  final ComponentType type;

  @override
  bool updateShouldNotify(_ComponentLifeCycleScope oldWidget) =>
      type != oldWidget.type;
}
