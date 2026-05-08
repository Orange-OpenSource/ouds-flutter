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
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_customization.dart';

/// Generates the live code snippet for [StandardBottomSheetDemoScreen].
///
/// Mirrors `standardBottomSheetDemoCodeSnippet` from the Android app.
class StandardBottomSheetCodeGenerator {
  static String updateCode(BuildContext context) {
    final state = StandardBottomSheetCustomization.of(context);
    final dragHandle = state?.hasSheetDragHandle ?? true;
    final swipeEnabled = state?.hasSheetSwipeEnabled ?? true;
    final peekHeight = state?.sheetPeekHeight ?? 56;

    final buf = StringBuffer();
    buf.writeln('OudsBottomSheetScaffold(');
    buf.writeln('  sheetPeekHeight: ${peekHeight.round()},');
    buf.writeln('  sheetDragHandle: $dragHandle,');
    buf.writeln('  sheetSwipeEnabled: $swipeEnabled,');
    buf.writeln('  sheetContent: (context) {');
    buf.writeln('    // sheet content');
    buf.writeln('  },');
    buf.writeln('  content: (context) {');
    buf.writeln('    // main content');
    buf.writeln('  },');
    buf.writeln(')');
    return buf.toString();
  }
}
