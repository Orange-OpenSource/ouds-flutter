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

/// @nodoc
library;

import 'package:flutter/foundation.dart';

/// Returns the platform's native monospace font family, used to render [OudsCodeText]
/// without bundling a dedicated font asset in each theme package.
///
String get oudsSystemMonospaceFontFamily {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return 'Menlo';
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    return 'Monospace';
  }
  return '';
}
