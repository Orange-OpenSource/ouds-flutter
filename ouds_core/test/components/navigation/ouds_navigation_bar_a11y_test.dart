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

// Accessibility tests for OudsNavigationBar — semantic labels & TalkBack contract.
//
// Coverage:
//  1. [OudsNavigationBarA11y.buildTabSemanticLabel] — pure label-building logic.
//  2. [buildNavItemAccessibleLabel]                 — backward-compat top-level helper.
//  3. Badge Semantics geometry                      — non-zero rect required by TalkBack.
//  4. TalkBack reading-order                        — badge node must be below label node.
//  5. [kNavBarMaxTextScale] constant value.
//
// Expected TalkBack announcement for a badged item:
//
//   "Label, 1 notification, Tab 2 of 3"
//    ──┬──  ───────┬───────  ───────┬──
//      │           │                └─ IndexedSemantics  (Material, not tested here)
//      │           └─ Semantics(label: badge.contentDescription,
//      │                container: true, child: SizedBox(height: 1))
//      └─ NavigationDestination(label: 'Label')
//
// ⚠ The badge Semantics child MUST have a non-zero rect — SizedBox.shrink() (0×0)
//   causes Flutter to mark the node invisible and TalkBack silently skips it.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_a11y.dart';
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';

// ---------------------------------------------------------------------------
// Test helpers
// ---------------------------------------------------------------------------

/// Convenience factory for [OudsNavigationBarItemBadge].
OudsNavigationBarItemBadge _badge({
  String contentDescription = '1 notification',
  int? count = 1,
}) => OudsNavigationBarItemBadge(
  contentDescription: contentDescription,
  count: count,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // ─── 1. OudsNavigationBarA11y.buildTabSemanticLabel ───────────────────────
  group('OudsNavigationBarA11y.buildTabSemanticLabel', () {
    test('returns label only when badge is null', () {
      expect(
        OudsNavigationBarA11y.buildTabSemanticLabel('Accueil', null),
        'Accueil',
      );
    });

    test('returns "label, badge description" when badge is present', () {
      expect(
        OudsNavigationBarA11y.buildTabSemanticLabel(
          'Accueil',
          _badge(contentDescription: '1 notification'),
        ),
        'Accueil, 1 notification',
      );
    });

    test('does not duplicate label when badge description contains label', () {
      expect(
        OudsNavigationBarA11y.buildTabSemanticLabel(
          'Messages',
          _badge(contentDescription: '3 messages'),
        ),
        'Messages, 3 messages',
      );
    });

    test('handles empty badge description gracefully', () {
      expect(
        OudsNavigationBarA11y.buildTabSemanticLabel(
          'Home',
          _badge(contentDescription: ''),
        ),
        'Home, ',
      );
    });
  });

  // ─── 2. buildNavItemAccessibleLabel (deprecated top-level helper) ─────────
  group('buildNavItemAccessibleLabel', () {
    test('returns label when no badge', () {
      // ignore: deprecated_member_use
      expect(buildNavItemAccessibleLabel('Profile', null), 'Profile');
    });

    test('returns "label, badge" string when badge present', () {
      expect(
        // ignore: deprecated_member_use
        buildNavItemAccessibleLabel(
          'Profile',
          _badge(contentDescription: '5 alerts'),
        ),
        'Profile, 5 alerts',
      );
    });
  });

  // ─── 3. Badge Semantics node — geometry contract ──────────────────────────
  //
  // TalkBack determines node visibility from its layout rect.
  // A rect with width == 0 || height == 0 is flagged isInvisible = true and
  // skipped. SizedBox(height: 1) keeps the rect non-empty while remaining
  // visually imperceptible.
  group('Badge Semantics node — geometry contract', () {
    testWidgets(
      'SizedBox(height: 1) renders a non-empty rect inside a NavigationBar-style Column',
      (WidgetTester tester) async {
        // Mirrors the badge-node placement in toNavigationDestination,
        // without introducing an OudsTheme dependency.
        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 4), // indicator placeholder
                          const Text('Accueil'), // label placeholder
                          // Widget under test ↓
                          Semantics(
                            label: '1 notification',
                            container: true,
                            child: const SizedBox(height: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final box = tester.renderObject<RenderBox>(
          find.descendant(
            of: find.byWidgetPredicate(
              (w) =>
                  w is Semantics &&
                  w.properties.label == '1 notification' &&
                  w.container == true,
            ),
            matching: find.byType(SizedBox),
          ),
        );

        expect(
          box.size.height,
          greaterThan(0),
          reason:
              'height > 0 prevents Flutter from marking the node invisible — TalkBack would skip a 0-height node.',
        );
      },
    );

    testWidgets(
      'Badge Semantics node is discoverable via find.bySemanticsLabel',
      (WidgetTester tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 80,
                child: MergeSemantics(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        label: 'Accueil',
                        container: true,
                        child: const SizedBox(height: 24),
                      ),
                      Semantics(
                        label: '1 notification',
                        container: true,
                        child: const SizedBox(height: 1), // must be > 0
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.bySemanticsLabel('1 notification'),
          findsAtLeastNWidgets(1),
          reason:
              'Badge Semantics node must appear in the semantic tree for TalkBack to announce it.',
        );

        handle.dispose();
      },
    );
  });

  // ─── 4. TalkBack reading-order contract ───────────────────────────────────
  //
  // TalkBack traverses nodes by layout position (top-to-bottom, left-to-right).
  // The badge Semantics node must be placed BELOW NavigationDestination in the
  // Column so that rect.top(badge) ≥ rect.top(label), producing the order:
  //   "Label → badge description → Tab X of Y"
  group('TalkBack reading-order contract', () {
    testWidgets(
      'Badge Semantics node is positioned below label node (rect.top ≥ label rect.top)',
      (WidgetTester tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. Label node — mirrors NavigationDestination.
                    Semantics(
                      label: 'Accueil',
                      container: true,
                      child: const SizedBox(height: 24),
                    ),
                    // 2. Badge node — placed after label so rect.top is larger,
                    //    guaranteeing TalkBack reads: label → badge → Tab X of Y.
                    Semantics(
                      label: '1 notification',
                      container: true,
                      child: const SizedBox(height: 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.bySemanticsLabel('Accueil'), findsAtLeastNWidgets(1));
        expect(
          find.bySemanticsLabel('1 notification'),
          findsAtLeastNWidgets(1),
          reason:
              'A height-0 SizedBox would make the rect empty and prune this node — use SizedBox(height: 1).',
        );

        final labelRect = tester.getRect(
          find.bySemanticsLabel('Accueil').first,
        );
        final badgeRect = tester.getRect(
          find.bySemanticsLabel('1 notification').first,
        );

        expect(
          badgeRect.top,
          greaterThanOrEqualTo(labelRect.top),
          reason:
              'Badge rect.top (${badgeRect.top}) must be ≥ label rect.top (${labelRect.top}) '
              'to produce the reading order: "Accueil, 1 notification, Tab 2 de 3".',
        );

        handle.dispose();
      },
    );
  });

  // ─── 5. kNavBarMaxTextScale constant ─────────────────────────────────────
  group('kNavBarMaxTextScale', () {
    test('is capped at 1.6', () {
      expect(kNavBarMaxTextScale, equals(1.6));
    });
  });
}
