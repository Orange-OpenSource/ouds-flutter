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

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/component_life_cycle.dart';

class Component {
  String title;
  Widget? customComponent;
  String description;
  Widget? screen;
  List<VariantComponent>? variants;
  final ComponentType type;

  Component(
    this.title,
    this.customComponent,
    this.description,
    this.type,
    this.screen,
  );

  Component.withVariant(
    this.title,
    this.customComponent,
    this.description,
    this.type,
    this.variants,
  );
}

class VariantComponent {
  String title;
  Widget screen;

  VariantComponent(this.title, this.screen);
}
