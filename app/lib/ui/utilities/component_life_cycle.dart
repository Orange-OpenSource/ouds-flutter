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

enum ComponentType {
  alert,
  badge,
  bottomSheet,
  navigationBar,
  button,
  checkbox,
  chip,
  divider,
  link,
  listItem,
  passwordInput,
  phoneNumberInput,
  pinCodeInput,
  progressIndicator,
  radioButton,
  skeleton,
  switchButton,
  tag,
  textInput,
  topAppBar,
  typography,
}

enum ComponentLifeCycleStatus { draft, wip, production }

class ComponentLifeCycle {
  const ComponentLifeCycle._();

  static Widget demoScreen(ComponentType type, Widget screen) {
    return _ComponentLifeCycleScope(type: type, child: screen);
  }

  static Widget? demoAlert(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_ComponentLifeCycleScope>();
    return scope == null ? null : alert(context, scope.type);
  }

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
