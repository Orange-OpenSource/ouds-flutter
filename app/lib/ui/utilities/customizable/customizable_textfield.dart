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
import 'package:ouds_flutter_demo/ui/components/alert/alert_customization.dart';
import 'package:ouds_flutter_demo/ui/components/badge/badge_customization.dart';
import 'package:ouds_flutter_demo/ui/components/bottom_sheet/standard_bottom_sheet_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/chip/chip_customization.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_customization.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_customization.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_customization.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/top_bar/top_bar_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:provider/provider.dart';

enum FieldType {
  title,
  label,
  helper,
  extra,
  prefix,
  suffix,
  placeholder,
  description,
  error,
  helperLink,
  monogram, // The monogram is a single character that will be displayed inside the avatar.
  customHeight, // Specify maximum height of component
  bulletOne, // The first bullet of alert message
  bulletTwo, // The second bullet of alert message
  bulletThree, // The third bullet of alert message
}

class CustomizableTextField extends StatefulWidget {
  final String title;
  final String text;
  final FocusNode focusNode;
  final FieldType fieldType;
  final TextInputType keyboardType;
  final bool fieldEnable;
  final String? helperText;
  final String? suffixText;
  final String? errorText;

  const CustomizableTextField({
    super.key,
    required this.title,
    required this.text,
    required this.focusNode,
    required this.fieldType,
    this.keyboardType = TextInputType.text,
    this.fieldEnable = true,
    this.helperText,
    this.suffixText,
    this.errorText,
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

    // Only one listener is needed.
    // We do NOT add listeners inside an addPostFrameCallback here
    // as this would create multiple subscriptions on each rebuild.
    _textController.addListener(_propagateTextToDependents);
  }

  @override
  void didUpdateWidget(CustomizableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.text != _textController.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _textController.text = widget.text;
        }
      });
    }
  }

  void _propagateTextToDependents() {
    if (!mounted) return;

    final controlItemState = ControlItemCustomization.of(context);
    final buttonState = ButtonCustomization.of(context);
    final badgeState = BadgeCustomization.of(context);
    final chipState = ChipCustomization.of(context);
    final tagState = TagCustomization.of(context);
    final textInputState = FormFieldsCustomization.of(context);
    final topBarState = TopBarCustomization.of(context);
    final pinCodeInputState = PinCodeInputCustomization.of(context);
    final linkState = LinkCustomization.of(context);
    final bottomSheetState = StandardBottomSheetCustomization.of(context);
    final alertMessageState = AlertCustomization.of(context);

    final value = _textController.text;

    switch (widget.fieldType) {
      case FieldType.title:
        topBarState?.titleText = value;
        break;
      case FieldType.label:
        controlItemState?.labelText = value;
        buttonState?.textValue = value;
        badgeState?.countText = value;
        chipState?.labelText = value;
        tagState?.labelText = value;
        textInputState?.labelText = value;
        topBarState?.previousPageTitleText = value;
        linkState?.labelText = value;
        alertMessageState?.label = value;
        break;
      case FieldType.helper:
        textInputState?.helperText = value;
        pinCodeInputState?.pinCodeHelperText = value;
        break;
      case FieldType.extra:
        controlItemState?.extraLabelText = value;
        break;
      case FieldType.prefix:
        textInputState?.prefixText = value;
        break;
      case FieldType.suffix:
        textInputState?.suffixText = value;
        break;
      case FieldType.placeholder:
        textInputState?.placeholderText = value;
        pinCodeInputState?.pinCodePlaceholderText = value;
        break;
      case FieldType.description:
        controlItemState?.descriptionLabel = value;
        alertMessageState?.description = value;
        break;
      case FieldType.error:
        controlItemState?.errorMessageLabel = value;
        pinCodeInputState?.pinCodeErrorText = value;
        break;
      case FieldType.helperLink:
        textInputState?.helperLinkText = value;
        alertMessageState?.actionLink = value;
        break;
      case FieldType.monogram:
        topBarState?.actionAvatarMonogramText = value;
        break;
      case FieldType.customHeight:
        topBarState?.expandedHeightText = value;
        bottomSheetState?.sheetPeekHeightText = value;
        break;
      case FieldType.bulletOne:
        alertMessageState?.bulletTextOne = value;
        break;
      case FieldType.bulletTwo:
        alertMessageState?.bulletTextTwo = value;
        break;
      case FieldType.bulletThree:
        alertMessageState?.bulletTextThree = value;
        break;
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_propagateTextToDependents);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.all(
          themeController.currentTheme.spaceScheme(context).paddingInlineLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: themeController.currentTheme
                  .spaceScheme(context)
                  .scaledExtraSmall,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: themeController
                          .currentTheme
                          .fontTokens
                          .sizeBodyLargeMobile,
                      fontWeight: themeController
                          .currentTheme
                          .fontTokens
                          .weightLabelStrong,
                      letterSpacing: themeController
                          .currentTheme
                          .fontTokens
                          .letterSpacingBodyLargeMobile,
                    ),
                  ),
                  SizedBox(
                    height: themeController.currentTheme
                        .spaceScheme(context)
                        .scaledExtraSmall,
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _textController,
                    builder: (context, value, _) {
                      return OudsTextField(
                        enabled: widget.fieldEnable,
                        controller: _textController,
                        focusNode: widget.focusNode,
                        decoration: OudsInputDecoration(
                          hintText: '',
                          labelText: widget.title,
                          suffixIcon: AppAssets.icons.functionalActionsDelete(
                            themeController,
                          ),
                          suffix: widget.suffixText,
                          helperText: widget.helperText,
                          errorText: widget.errorText,
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
