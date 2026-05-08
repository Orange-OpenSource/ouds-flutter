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
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/modal_bottom_sheet_customization.dart';

/// Generates the live code snippet for [ModalBottomSheetDemoScreen].
///
/// Mirrors `modalBottomSheetDemoCodeSnippet` from the Android app.
class ModalBottomSheetCodeGenerator {
  static String updateCode(BuildContext context) {
    final state = ModalBottomSheetCustomization.of(context);
    final dragHandle = state?.hasDragHandle ?? true;
    final gesturesEnabled = state?.hasSheetGesturesEnabled ?? true;

    final buf = StringBuffer();
    buf.writeln('OudsModalBottomSheet(');
    buf.writeln('  dragHandle: $dragHandle,');
    buf.writeln('  sheetGesturesEnabled: $gesturesEnabled,');
    buf.writeln('  builder: (context) {');
    buf.writeln('    // sheet content');
    buf.writeln('  },');
    buf.writeln(').show(');
    buf.writeln('  context: context,');
    buf.writeln('  onDismissRequest: () {');
    buf.writeln('    // do something on dismiss');
    buf.writeln('  },');
    buf.writeln(')');
    return buf.toString();
  }
}
