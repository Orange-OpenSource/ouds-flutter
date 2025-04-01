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
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class CustomizableTextField extends StatefulWidget {
  final String title;
  final String text;

  const CustomizableTextField({super.key, required this.title, required this.text});

  @override
  CustomizableTextFieldState createState() => CustomizableTextFieldState();
}

class CustomizableTextFieldState extends State<CustomizableTextField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.text);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final buttonState = ButtonCustomization.of(context);
      if (buttonState != null) {
        _textController.addListener(() {
          buttonState.textValue = _textController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: themeController.currentTheme.spaceTokens.scaledShorterMobile),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(themeController.currentTheme.spaceTokens.scaledMediumMobile),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: themeController.currentTheme.fontTokens.sizeBodyLargeMobile,
                      fontWeight: themeController.currentTheme.fontTokens.weightLabelStrong,
                      letterSpacing: themeController.currentTheme.fontTokens.letterSpacingBodyLargeMobile,
                    ),
                  ),
                  SizedBox(height: themeController.currentTheme.spaceTokens.scaledShorterMobile),
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
