import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/link/ouds_link.dart';

void main() {
  group('OudsAlertMessage', () {
    testWidgets('renders label and description', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OudsAlertMessage(
            label: 'Test Label',
            description: 'Test Description',
            status: Neutral(),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('renders with different statuses', (WidgetTester tester) async {
      for (final status in [
        const Neutral(),
        const Accent(),
        Positive(),
        Info(),
        Warning(),
        Negative(),
      ]) {
        await tester.pumpWidget(
          MaterialApp(
            home: OudsAlertMessage(label: 'Test', status: status),
          ),
        );
        // Verify that the widget renders without crashing
        expect(find.byType(OudsAlertMessage), findsOneWidget);
      }
    });

    testWidgets('calls onClose when close button is pressed', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: OudsAlertMessage(
            label: 'Test',
            status: const Neutral(),
            onClose: () => closed = true,
          ),
        ),
      );

      await tester.tap(find.byType(OudsButton));
      expect(closed, isTrue);
    });

    testWidgets('calls action.onPressed when action link is pressed', (
      WidgetTester tester,
    ) async {
      bool actionPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: OudsAlertMessage(
            label: 'Test',
            status: const Neutral(),
            actionLink: OudsAlertMessageActionLink(
              text: 'Action',
              onClick: () => actionPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OudsLink));
      expect(actionPressed, isTrue);
    });
  });
}
