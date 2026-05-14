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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart'
    show OudsCheckbox;
import 'package:ouds_core/components/chip/ouds_filter_chip.dart'
    show OudsFilterChip;
import 'package:ouds_core/components/chip/ouds_suggestion_chip.dart'
    show OudsSuggestionChip;
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart'
    show OudsRadioButton;
import 'package:ouds_core/components/switch/ouds_switch.dart' show OudsSwitch;

/// Wraps a widget with the minimum setup required for widget tests.
Widget _testableWidget(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

/// Regression tests for the "Null check operator used on a null value" crash.
///
/// The bug occurred when a component with an async `didChangeDependencies`
/// callback (calling `OudsAccessibilityPlugin.isHighContrastEnabled`) was
/// disposed before the Future completed, causing `setState` on an unmounted
/// State. The fix adds a `if (mounted)` guard before `setState`.
///
/// These tests verify that quickly removing each component from the tree
/// does NOT throw "Null check operator used on a null value".
void main() {
  group('Mounted guard - no setState after dispose', () {
    testWidgets('OudsRadioButton does not crash when disposed quickly', (
      tester,
    ) async {
      // Track if "Null check operator" error occurs (the crash we fixed).
      String? nullCheckError;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Null check operator')) {
          nullCheckError = details.exceptionAsString();
        }
      };

      await tester.pumpWidget(
        _testableWidget(
          OudsRadioButton<int>(value: 1, groupValue: 1, onChanged: (_) {}),
        ),
      );

      await tester.pumpWidget(_testableWidget(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 1));

      FlutterError.onError = originalOnError;
      expect(
        nullCheckError,
        isNull,
        reason: 'setState was called after dispose',
      );
    });

    testWidgets('OudsCheckbox does not crash when disposed quickly', (
      tester,
    ) async {
      String? nullCheckError;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Null check operator')) {
          nullCheckError = details.exceptionAsString();
        }
      };

      await tester.pumpWidget(
        _testableWidget(OudsCheckbox(value: true, onChanged: (_) {})),
      );

      await tester.pumpWidget(_testableWidget(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 1));

      FlutterError.onError = originalOnError;
      expect(
        nullCheckError,
        isNull,
        reason: 'setState was called after dispose',
      );
    });

    testWidgets('OudsSwitch does not crash when disposed quickly', (
      tester,
    ) async {
      String? nullCheckError;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Null check operator')) {
          nullCheckError = details.exceptionAsString();
        }
      };

      await tester.pumpWidget(
        _testableWidget(OudsSwitch(value: true, onChanged: (_) {})),
      );

      await tester.pumpWidget(_testableWidget(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 1));

      FlutterError.onError = originalOnError;
      expect(
        nullCheckError,
        isNull,
        reason: 'setState was called after dispose',
      );
    });

    testWidgets('OudsSuggestionChip does not crash when disposed quickly', (
      tester,
    ) async {
      String? nullCheckError;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Null check operator')) {
          nullCheckError = details.exceptionAsString();
        }
      };

      await tester.pumpWidget(
        _testableWidget(OudsSuggestionChip(label: 'Test', onPressed: () {})),
      );

      await tester.pumpWidget(_testableWidget(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 1));

      FlutterError.onError = originalOnError;
      expect(
        nullCheckError,
        isNull,
        reason: 'setState was called after dispose',
      );
    });

    testWidgets('OudsFilterChip does not crash when disposed quickly', (
      tester,
    ) async {
      String? nullCheckError;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Null check operator')) {
          nullCheckError = details.exceptionAsString();
        }
      };

      await tester.pumpWidget(
        _testableWidget(OudsFilterChip(label: 'Test', onSelected: (_) {})),
      );

      await tester.pumpWidget(_testableWidget(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 1));

      FlutterError.onError = originalOnError;
      expect(
        nullCheckError,
        isNull,
        reason: 'setState was called after dispose',
      );
    });
  });
}
