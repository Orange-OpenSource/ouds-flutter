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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/ouds_colored_box.dart';

class OudsButtonSamples {
  /// Text only button sample.
  static Widget textOnly() {
    return OudsButton(
      label: 'Label',
      style: OudsButtonStyle.defaultStyle,
      hierarchy: OudsButtonHierarchy.defaultHierarchy,
      onPressed: () {
        // Handle button tap.
      },
    );
  }

  /// Text only button on colored background.
  static Widget textOnlyOnColoredBackground() {
    return OudsColoredBox(
      color: OudsColoredBoxColor.brandPrimary,
      child: OudsButton(
        label: 'Label',
        onPressed: () {},
        style: OudsButtonStyle.defaultStyle,
        hierarchy: OudsButtonHierarchy.defaultHierarchy,
      ),
    );
  }

  /// Icon only button sample.
  static Widget iconOnly() {
    return OudsButton(
      icon: Icon(Icons.star),
      onPressed: () {},
      style: OudsButtonStyle.defaultStyle,
      hierarchy: OudsButtonHierarchy.defaultHierarchy,
    );
  }

  /// Icon only button on colored background.
  static Widget iconOnlyOnColoredBackground() {
    return OudsColoredBox(
      color: OudsColoredBoxColor.brandPrimary,
      child: OudsButton(
        icon: Icon(Icons.star),
        onPressed: () {},
        style: OudsButtonStyle.defaultStyle,
        hierarchy: OudsButtonHierarchy.defaultHierarchy,
      ),
    );
  }

  /// Icon and text button sample.
  static Widget iconAndText() {
    return OudsButton(
      icon: Icon(Icons.star),
      label: 'Label',
      onPressed: () {},
      style: OudsButtonStyle.defaultStyle,
      hierarchy: OudsButtonHierarchy.defaultHierarchy,
    );
  }

  /// Icon and text button on colored background.
  static Widget iconAndTextOnColoredBackground() {
    return OudsColoredBox(
      color: OudsColoredBoxColor.brandPrimary,
      child: OudsButton(
        icon: Icon(Icons.star),
        label: 'Label',
        onPressed: () {},
        style: OudsButtonStyle.defaultStyle,
        hierarchy: OudsButtonHierarchy.defaultHierarchy,
      ),
    );
  }
}
