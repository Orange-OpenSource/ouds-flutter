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
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';

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
      final chipState = ChipCustomization.of(context);

      _textController.addListener(() {
        if (!widget.focusNode.hasFocus) return;

        switch (widget.fieldType) {
          case FieldType.label:
            _textController.addListener(() {
              controlItemState?.labelText = _textController.text;
              buttonState?.textValue = _textController.text;
              chipState?.labelText = _textController.text;
            });
            break;
          case FieldType.helper:
            _textController.addListener(() {
              controlItemState?.helperLabelText = _textController.text;
              buttonState?.textValue = _textController.text;
            });
            break;
          case FieldType.additional:
            _textController.addListener(() {
              controlItemState?.additionalLabelText = _textController.text;
              buttonState?.textValue = _textController.text;
            });
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
          SizedBox(height: themeController.currentTheme.spaceScheme(context).scaledShorter),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: themeController.currentTheme.spaceScheme(context).scaledMedium,
                  end: themeController.currentTheme.spaceScheme(context).scaledMedium,
                  top: themeController.currentTheme.spaceScheme(context).scaledShorter,
                  bottom: themeController.currentTheme.spaceScheme(context).scaledNone),
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
                  SizedBox(height: themeController.currentTheme.spaceScheme(context).scaledShorter),
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
