/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter/theme_contract/theme/tokens/ouds_key_tokens.dart';

class OudsTypographyKeyToken extends OudsKeyToken {
  final String _name;
  final TextStyle _value;

  OudsTypographyKeyToken({required String name, required TextStyle value})
      : _name = name,
        _value = value;

  @override
  String get name => _name;

  @override
  TextStyle get value => _value;
}
