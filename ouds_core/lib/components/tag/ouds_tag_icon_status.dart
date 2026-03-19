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

/// {@category Tag}
library;

/// Describes the configuration for a Tag's icon and status, without resolving colors.
/// This class defines the *intent* of the tag's appearance.
sealed class OudsTagIconStatus {

  const OudsTagIconStatus();
}

/// Status for general labels. The icon is customizable.
class Neutral extends OudsTagIconStatus {
  final String? icon;
  const Neutral({this.icon});
}

/// Status to highlight content related to discovery. The icon is customizable.
class Accent extends OudsTagIconStatus {
  final String? icon;
  const Accent({this.icon});
}

/// Indicates success, completion, or approval. The icon is fixed.
class Positive extends OudsTagIconStatus {
  const Positive();
}

/// Provides informational context. The icon is fixed.
class Info extends OudsTagIconStatus {
  const Info();
}

/// Alerts the user to potential risks. The icon is fixed.
class Warning extends OudsTagIconStatus {
  const Warning();
}

/// Draws attention to important or critical information. The icon is fixed.
class Negative extends OudsTagIconStatus {
  const Negative();
}