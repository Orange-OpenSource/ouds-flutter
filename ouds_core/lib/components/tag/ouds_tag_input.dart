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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_input_background_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_text_style_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_border_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_input_icon_style_modifier.dart';

import 'internal/ouds_tag_control_state.dart';


// TODO: Add documentation URL once it is available
///
/// A Tag Input is a component that allows users to enter multiple values, each represented as a tag input.
/// As users type and submit values (usually by pressing enter, comma, or tab), each value is transformed into a Tag.
/// Tag Inputs are often used for adding labels, categories, or participants.
/// They typically support editing, removing, and validating individual tags.
///
/// Each tag displays a remove (close) icon. Users can remove a tag by clicking or tapping the remove icon.
/// Tags can also be removed using the keyboard: when a tag is focused, pressing Backspace or Delete removes it.
///
/// Parameters:
/// - [label]: Label displayed in the tag input which describes the tag option.
/// - [onPressed]: Callback invoked when the tag input is clicked to delete it.

/// ## You can use [OudsTagInput] like this :
///
/// ### Tag input :
///
/// ```dart
/// OudsInputTag(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
///
class OudsTagInput extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;

  const OudsTagInput({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  State<OudsTagInput> createState() => _OudsTagInputState();

}

class _OudsTagInputState extends State<OudsTagInput> {
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _handleFocusChange(_focusNode.hasFocus);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool focus) {
    if (widget.onPressed == null) _isFocused = false; // Ignore focus changes if disabled
    setState(() => _isFocused = focus);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;
    final tagStateDeterminer = OudsTagControlStateDeterminer(enabled: !isDisabled, isPressed: isPressed || _isPressed, isHovered: isHovered || _isHovered, isFocused: _isFocused);
    final tagState = tagStateDeterminer.determineControlState();
    final tagBorderModifier = OudsTagInputControlBorderModifier(context);
    final tagTextColorModifier = OudsTagStyleModifier(context);
    final tagBackgroundColorModifier = OudsTagInputControlBackgroundColorModifier(context);

    return Visibility(
      visible: isVisible,
        child: _buildInputTag(context, tagBorderModifier, tagTextColorModifier, tagBackgroundColorModifier, tagState, isDisabled)
    );
  }

  Widget _buildInputTag(BuildContext context,
      OudsTagInputControlBorderModifier tagBorderModifier,
      OudsTagStyleModifier tagTextColorModifier,
      OudsTagInputControlBackgroundColorModifier tagBgColorModifier,
      OudsTagControlState tagState, bool isDisabled)
  {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    return Semantics(
      enabled: isDisabled,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            minHeight: tagToken.sizeMinHeightInteractiveArea,
          ),
          child: InkWell(
            onTap: () {
              if (widget.onPressed != null) {
                widget.onPressed!.call();
              }
            },
            focusNode: _focusNode,
            canRequestFocus: !isDisabled,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onHover: (hovering) {
              setState(() {
                if (!isDisabled) {
                  _isHovered = hovering;
                }
              });
            },
            onHighlightChanged: (highlighted) {
              setState(() {
                if (!isDisabled) {
                  _isPressed = highlighted;
                }
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Border exterior
                if (_isFocused)
                  Positioned(
                    top: OudsTheme.of(context).borderTokens.widthFocus / 2,
                    bottom: OudsTheme.of(context).borderTokens.widthFocus / 2,
                    left: -OudsTheme.of(context).borderTokens.widthFocus / 2,

                    /// to be changed to enhancement the focus.
                    right: -OudsTheme.of(context).borderTokens.widthFocus / 2,

                    /// to be changed to enhancement the focus.
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: OudsTheme.of(context).colorScheme(context).borderFocus, //ouds/💠_indicator/tag-input/color/border/focus
                          width: OudsTheme.of(context).borderTokens.widthFocus,
                        ),
                        borderRadius: BorderRadius.circular(
                          tagToken.borderRadius + OudsTheme.of(context).borderTokens.widthFocus,
                        ),
                      ),
                    ),
                  ),
                // Border interior + content
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset : Colors.transparent,
                      width: OudsTheme.of(context).borderTokens.widthFocusInset,
                    ),
                    borderRadius: BorderRadius.circular(
                      tagToken.borderRadius,
                    ),
                  ),
                  child: _buildLayout(
                    context,
                    tagBorderModifier,
                    tagTextColorModifier,
                    tagBgColorModifier,
                    tagState,
                    isDisabled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, OudsTagInputControlBorderModifier tagBorderModifier,
      OudsTagStyleModifier tagTextColorModifier,
      OudsTagInputControlBackgroundColorModifier tagBgColorModifier, OudsTagControlState tagState, bool isDisabled) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: tagBorderModifier.getBorder(tagState),
              borderRadius: BorderRadius.circular(
                tagToken.borderRadius,
              ),
            ),
          ),
        ),

        // Content (e.g., Row with icon and label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            tagToken.borderRadius,
          ),
          child: Container(
            color: tagBgColorModifier.getBackgroundColor(tagState),
            padding: EdgeInsetsDirectional.only(
              top: tagToken.spacePaddingBlockDefault,
              bottom: tagToken.spacePaddingBlockDefault,
              start:  tagToken.spacePaddingInlineDefault,
              end: tagToken.spacePaddingInlineAssetDefault,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                      color: tagTextColorModifier.getTextColor(tagState),
                    )
                  ),
                ),
                SizedBox(width: tagToken.spaceColumnGapDefault),
                SvgPicture.asset(
                  width: tagToken.sizeAssetDefault,
                  height: tagToken.sizeAssetDefault,
                  AppAssets.icons.delete,
                  package:  OudsTheme.of(context).packageName,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    OudsTagInputControlIconColorModifier(context).getIconColor(tagState)!,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
