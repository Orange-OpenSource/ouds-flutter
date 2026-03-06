/*
 * Software Name : Orange Design System
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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/tokens/color/color_tokens_model.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatelessWidget {
  final String illustration;
  const ColorScreen({super.key, required this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    final tokenGroups = ColorTokensModel.fromTheme(context, currentTheme).all;

    return Scaffold(
      appBar: MainAppBar(title: context.l10n.app_tokens_color_label),
      body: SafeArea(
        child: ListView(
          children: [
            SvgPicture.asset(
              AdaptiveImageHelper.getImage(context, illustration),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge),
              child: Column(
                children: [
                  Text(
                    context.l10n.app_tokens_color_description_text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Code(
              titleText: context.l10n.app_tokens_viewCodeExample_label,
              code: 'OudsTheme.of(context).colorScheme(context).actionDisabled',
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                top: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
                bottom: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
              ),
              children: [
                for (var entry in tokenGroups.entries) ...[
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: currentTheme.spaceScheme(context).rowGapLarge,
                      horizontal: currentTheme.spaceScheme(context).rowGapLarge,
                    ),
                    child: Semantics(
                      header: true,
                      child: Text(
                        entry.key,
                        style: currentTheme.typographyTokens.typeBodyStrongLarge(context).copyWith(color: currentTheme.colorScheme(context).contentDefault),
                      ),
                    ),
                  ),
                  ...entry.value.map(
                    (item) => Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge,
                      ),
                      child: ColorWidget(colorTokenItem: item),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.colorTokenItem});

  final ColorTokenItem colorTokenItem;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: currentTheme.spaceScheme(context).rowGapSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color swatch (diagonal overlay only for #FF0000).
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colorTokenItem.value,
                  border: Border.all(color: currentTheme.colorScheme(context).borderEmphasized),
                ),
              ),
              // Diagonal line overlay.
              if (colorTokenItem.colorToHex(colorTokenItem.value!) == "#FF0000")
                Positioned.fill(
                  child: CustomPaint(
                    painter: DiagonalBarUnspecifiedColor(
                      color: currentTheme.colorScheme(context).borderStatusNegative,
                      thickness: 1,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: currentTheme.spaceScheme(context).paddingInlineTwoExtraLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  colorTokenItem.name,
                  style: TextStyle(
                    fontSize: currentTheme.fontTokens.sizeBodyLargeMobile,
                    fontWeight: FontWeight.bold,
                    letterSpacing: currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    color: currentTheme.colorScheme(context).contentDefault,
                  ),
                ),
                SizedBox(height: currentTheme.spaceScheme(context).rowGapNone),
                Text(colorTokenItem.colorToHex(colorTokenItem.value!),
                    style: currentTheme.typographyTokens.typeBodyDefaultMedium(context).copyWith(color: currentTheme.colorScheme(context).contentMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorTokenItem {
  const ColorTokenItem({required this.name, required this.value});

  final String name;
  final Color? value;

  String colorToHex(Color color) {
    // Convert the individual RGBA components (Red, Green, Blue) from double to int
    String hex = '#${(color.r * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Red
        '${(color.g * 255).toInt().toRadixString(16).padLeft(2, '0')}' // Green
        '${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}'; // Blue
    return hex.toUpperCase();
  }
}

/// Custom painter that draws a diagonal line from top-right to bottom-left.
///
/// Used to overlay a visual indicator (e.g., "Unspecified" ) on color swatches.
///
/// Parameters:
/// - [color]: The color of the diagonal line.
/// - [thickness]: The stroke width of the line (default: 1.0).
///
/// Example usage:
/// ```dart
/// CustomPaint(
///   painter: DiagonalBarUnspecifiedColor(
///     color: themeController.currentTheme.colorScheme(context).borderStatusNegative,
///     thickness: 2.0,
///   ),
/// )
/// ```
class DiagonalBarUnspecifiedColor extends CustomPainter {
  final Color color;
  final double thickness;

  DiagonalBarUnspecifiedColor({required this.color, this.thickness = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;

    final p1 = Offset(size.width, 0); // top-right
    final p2 = Offset(0, size.height); // bottom-left
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant DiagonalBarUnspecifiedColor old) => old.color != color || old.thickness != thickness;
}
