// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT

/// Shared configuration for content and action cards.
///
/// ```dart
/// OudsThemeConfigModel(
///   card: OudsCardConfig(rounded: true),
///   child: MyApp(),
/// )
/// ```
class OudsCardConfig {
  /// Creates card configuration, preserving square corners by default.
  const OudsCardConfig({this.rounded = false});

  /// Whether cards use rounded corners. Null uses the default square corners.
  final bool? rounded;
}
