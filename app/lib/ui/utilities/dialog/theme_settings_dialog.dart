/*
 * Software Name : OUDS Flutter
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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/dialog/dialog_content.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A dialog that allows users to customize theme settings.
///
/// This dialog lets users enable or disable rounded corners
/// for buttons and text inputs. The selected preferences are
/// applied to the application's theme via the [ThemeController]
/// when the user taps "Apply".
class ThemeSettingsDialog extends StatefulWidget {
  const ThemeSettingsDialog({
    super.key,
    required this.themeController,
  });

  final ThemeController themeController;

  /// Displays the [ThemeSettingsDialog].
  ///
  /// This method opens a dialog that allows users to customize
  /// theme settings such as rounded corners for buttons and text inputs.
  ///
  /// The dialog applies changes only when the user taps "Apply".
  static void show(
      BuildContext context,
      ThemeController themeController,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ThemeSettingsDialog(
          themeController: themeController,
        );
      },
    );
  }

  @override
  State<ThemeSettingsDialog> createState() =>
      _ThemeSettingsDialogState();
}

class _ThemeSettingsDialogState
    extends State<ThemeSettingsDialog> {
  late bool _isButtonRounded;
  late bool _isTextInputRounded;

  @override
  void initState() {
    super.initState();
    _isButtonRounded =
        widget.themeController.onBorderRadiusButtonState;
    _isTextInputRounded =
        widget.themeController.onBorderRadiusTextInputState;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.app_themeSettingsDialog_label,
        style: OudsTheme.of(context)
            .typographyTokens
            .typeHeadingMedium(context),
      ),
      content: DialogContent(
        buttonRoundedConfig: _isButtonRounded,
        textInputRoundedConfig: _isTextInputRounded,
        onButtonRoundedChanged: (value) {
          setState(() {
            _isButtonRounded = value;
          });
        },
        onTextInputRoundedChanged: (value) {
          setState(() {
            _isTextInputRounded = value;
          });
        },
      ),
      actions: <Widget>[
        OudsButton(
          appearance: OudsButtonAppearance.minimal,
          label:
          context.l10n.app_themeSettingsDialog_cancel_label,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OudsButton(
          appearance:
          OudsButtonAppearance.defaultAppearance,
          label:
          context.l10n.app_themeSettingsDialog_apply_label,
          onPressed: () {
              widget.themeController.setOnBorderRadiusButtonState(_isButtonRounded);
              widget.themeController.setOnBorderRadiusTextInputState(_isTextInputRounded);
            Navigator.of(context).pop();
          },
        ),
      ],
      actionsOverflowDirection: VerticalDirection.up,
    );
  }
}