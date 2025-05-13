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

import 'package:flutter/material.dart';

/// OUDS Divider is a styled thin line of 1dp thickness that groups content in lists and layouts.
class OudsDivider extends StatelessWidget {
  const OudsDivider({super.key});

  final double _dividerOpacity = 0.12;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      thickness: 1,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(_dividerOpacity),
    );
  }
}
