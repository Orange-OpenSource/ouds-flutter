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
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_constants.dart';
import 'package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart';

void main() {
  // ── OudsBottomSheetConstants ─────────────────────────────────────────────
  group('OudsBottomSheetConstants', () {
    test('handleWidth is 32 dp', () {
      expect(OudsBottomSheetConstants.handleWidth, 32.0);
    });

    test('handleHeight is 4 dp', () {
      expect(OudsBottomSheetConstants.handleHeight, 4.0);
    });

    test('handleRadius is positive', () {
      expect(OudsBottomSheetConstants.handleRadius, greaterThan(0));
    });
  });

  // ── OudsBottomSheetScaffold ─────────────────────────────────────────────
  group('OudsBottomSheetScaffold', () {
    test('default sheetDragHandle is true', () {
      final sheet = OudsBottomSheetScaffold(
        sheetContent: (_) => const SizedBox(),
        content: (_) => const SizedBox(),
      );
      expect(sheet.sheetDragHandle, true);
    });

    test('default sheetSwipeEnabled is true', () {
      final sheet = OudsBottomSheetScaffold(
        sheetContent: (_) => const SizedBox(),
        content: (_) => const SizedBox(),
      );
      expect(sheet.sheetSwipeEnabled, true);
    });

    test('default sheetPeekHeight is kOudsBottomSheetPeekHeight', () {
      final sheet = OudsBottomSheetScaffold(
        sheetContent: (_) => const SizedBox(),
        content: (_) => const SizedBox(),
      );
      expect(sheet.sheetPeekHeight, kOudsBottomSheetPeekHeight);
    });

    test('custom parameters are stored correctly', () {
      final sheet = OudsBottomSheetScaffold(
        sheetDragHandle: false,
        sheetSwipeEnabled: false,
        sheetPeekHeight: 100,
        sheetContent: (_) => const SizedBox(),
        content: (_) => const SizedBox(),
      );
      expect(sheet.sheetDragHandle, false);
      expect(sheet.sheetSwipeEnabled, false);
      expect(sheet.sheetPeekHeight, 100);
    });
  });
}
