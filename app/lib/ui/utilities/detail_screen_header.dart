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

class DetailScreenDescription extends StatelessWidget {
  final String description;
  final Widget? widget;

  const DetailScreenDescription({
    super.key,
    required this.description,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        if (widget != null) widget!,
      ],
    );
  }
}
