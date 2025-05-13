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
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

enum FieldType {
  label,
  helper,
  additional,
}

class CustomizableTextField extends StatefulWidget {
  final String title;
  final String text;
  final FocusNode focusNode;
  final FieldType fieldType;

  const CustomizableTextField({
    super.key,
    required this.title,
    required this.text,
    required this.focusNode,
    required this.fieldType,
  });

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
      final controlItemState = ControlItemCustomization.of(context);
      final buttonState = ButtonCustomization.of(context);

      _textController.addListener(() {
        if (!widget.focusNode.hasFocus) return;

        switch (widget.fieldType) {
          case FieldType.label:
            _textController.addListener(() {
              controlItemState?.labelText = _textController.text;
              buttonState?.textValue = _textController.text;
            });
            break;
          case FieldType.helper:
            _textController.addListener(() {
              controlItemState?.helperLabelText = _textController.text;
            });
            break;
          case FieldType.additional:
            // TODO: Handle this case.
            throw UnimplementedError();
        }
      });
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
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: themeController.currentTheme.spaceTokens.scaledMediumMobile,
                  end: themeController.currentTheme.spaceTokens.scaledMediumMobile,
                  top: themeController.currentTheme.spaceTokens.scaledShorterMobile,
                  bottom: themeController.currentTheme.spaceTokens.scaledNoneMobile),
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
                    focusNode: widget.focusNode,
                    decoration: const InputDecoration(filled: true),
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
