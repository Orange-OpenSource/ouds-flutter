// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.

/// @nodoc
library;

import 'package:flutter/widgets.dart';

/// Shares the enabled state of the nearest card with its content so OUDS
/// components placed in the card slot render their disabled appearance.
class OudsCardScope extends InheritedWidget {
  const OudsCardScope({super.key, required this.enabled, required super.child});

  final bool enabled;

  /// Whether the content is enabled; true outside of any card.
  static bool enabledOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OudsCardScope>()?.enabled ??
      true;

  @override
  bool updateShouldNotify(OudsCardScope oldWidget) =>
      enabled != oldWidget.enabled;
}
