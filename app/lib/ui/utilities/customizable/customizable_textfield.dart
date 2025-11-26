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
import 'package:ouds_core/components/form_input/internal/ouds_form_input_decoration.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:provider/provider.dart';

enum FieldType {
  label,
  helper,
  extra,
  prefix,
  suffix,
  placeholder,
  description,
  error,
  helperLink,
}

class CustomizableTextField extends StatefulWidget {
  final String title;
  final String text;
  final FocusNode focusNode;
  final FieldType fieldType;
  final TextInputType keyboardType;
  final bool fieldEnable;

  const CustomizableTextField({
    super.key,
    required this.title,
    required this.text,
    required this.focusNode,
    required this.fieldType,
    this.keyboardType = TextInputType.text,
    this.fieldEnable = true,
  });

  @override
  CustomizableTextFieldState createState() => CustomizableTextFieldState();
}

class CustomizableTextFieldState extends State<CustomizableTextField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.text);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlItemState = ControlItemCustomization.of(context);
      final buttonState = ButtonCustomization.of(context);
      final badgeState = BadgeCustomization.of(context);
      final chipState = ChipCustomization.of(context);
      final tagState = TagCustomization.of(context);
      final linkState = LinkCustomization.of(context);
      final textInputState = FormFieldsCustomization.of(context);
      final pinCodeInputState = PinCodeInputCustomization.of(context);

      _textController.addListener(() {
        switch (widget.fieldType) {
          case FieldType.label:
            _textController.addListener(() {
              controlItemState?.labelText = _textController.text;
              buttonState?.textValue = _textController.text;
              badgeState?.countText = _textController.text;
              chipState?.labelText = _textController.text;
              tagState?.labelText = _textController.text;
              textInputState?.labelText = _textController.text;
              linkState?.labelText = _textController.text;
            });
            break;
          case FieldType.helper:
            _textController.addListener(() {
              buttonState?.textValue = _textController.text;
              textInputState?.helperText = _textController.text;
              pinCodeInputState?.pinCodeHelperText = _textController.text;
              pinCodeInputState?.pinCodeErrorText = _textController.text;
            });
            break;
          case FieldType.extra:
            _textController.addListener(() {
              controlItemState?.additionalLabelText = _textController.text;
              buttonState?.textValue = _textController.text;
            });
          case FieldType.prefix:
            textInputState?.prefixText = _textController.text;
          case FieldType.suffix:
            textInputState?.suffixText = _textController.text;
          case FieldType.placeholder:
            textInputState?.placeholderText = _textController.text;
            pinCodeInputState?.pinCodePlaceholderText = _textController.text;
          case FieldType.description:
            _textController.addListener(() {
              controlItemState?.descriptionLabel = _textController.text;
            });
          case FieldType.error:
            _textController.addListener(() {
              controlItemState?.errorMessageLabel = _textController.text;
            });
          case FieldType.helperLink:
            textInputState?.helperLinkText = _textController.text;
        }
      });
    });

    _textController.addListener(_propagateTextToDependents);
  }

  void _propagateTextToDependents() {
    if (!mounted) return;

    final controlItemState = ControlItemCustomization.of(context);
    final buttonState = ButtonCustomization.of(context);
    final badgeState = BadgeCustomization.of(context);
    final chipState = ChipCustomization.of(context);
    final tagState = TagCustomization.of(context);
    final textInputState = FormFieldsCustomization.of(context);

    final value = _textController.text;

    switch (widget.fieldType) {
      case FieldType.label:
        controlItemState?.labelText = value;
        buttonState?.textValue = value;
        badgeState?.countText = value;
        chipState?.labelText = value;
        tagState?.labelText = value;
        textInputState?.labelText = value;
        break;

      case FieldType.helper:
        buttonState?.textValue = value;
        textInputState?.helperText = value;
        break;

      case FieldType.extra:
        controlItemState?.additionalLabelText = value;
        buttonState?.textValue = value;
        break;

      case FieldType.prefix:
        textInputState?.prefixText = value;
        break;

      case FieldType.suffix:
        textInputState?.suffixText = value;
        break;

      case FieldType.placeholder:
        textInputState?.placeholderText = value;
        break;
      case FieldType.description:
        controlItemState?.descriptionLabel = value;
        break;
      case FieldType.error:
        controlItemState?.errorMessageLabel = value;
      case FieldType.helperLink:
        textInputState?.helperLinkText = value;
        break;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _textController.removeListener(_propagateTextToDependents);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.all(themeController.currentTheme.spaceScheme(context).paddingInlineLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: themeController.currentTheme.spaceScheme(context).scaledExtraSmall),
            Align(
              alignment: AlignmentDirectional.centerStart,
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
                  SizedBox(height: themeController.currentTheme.spaceScheme(context).scaledExtraSmall),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _textController,
                    builder: (context, value, _) {
                      return OudsTextField(
                        enabled: widget.fieldEnable,
                        controller: _textController,
                        focusNode: widget.focusNode,
                        decoration: OudsInputDecoration(
                          suffixIcon: AppAssets.icons.functionalActionsDelete(themeController),
                          onSuffixPressed: () {
                            _textController.clear();
                            if (!widget.focusNode.hasFocus) {
                              widget.focusNode.unfocus();
                            }
                            setState(() {});
                          },
                        ),
                        keyboardType: widget.keyboardType,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
