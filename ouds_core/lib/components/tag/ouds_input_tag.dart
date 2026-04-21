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

/// {@category Tag}
library;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/tag/internal/ouds_input_tag_background_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_input_tag_border_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_input_tag_icon_style_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_text_style_modifier.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import 'internal/ouds_tag_control_state.dart';

///
/// [OUDS Input Tag Design Guidelines](https://r.orange.fr/r/S-ouds-doc-input-tag)
///
/// **Reference design version : 1.4.0**
///
/// Input tag is a UI element that allows to enter multiple values, each represented as a tag.
/// As users type and submit values (usually by pressing enter, comma, or tab),
/// each value is transformed into a tag. Input tag is often used for adding labels, categories, or participants.
///
/// Each tag displays a remove (close) icon. Users can remove a tag by clicking or tapping the remove icon.
/// Tags can also be removed using the keyboard: when a tag is focused, pressing Backspace or Delete removes it.
///
/// Parameters:
/// - [label]: Label displayed in the tag input which describes the tag option.
/// - [onPressed]: Callback invoked when the tag input is clicked to delete it.

/// ### You can use [OudsInputTag] like this :
///
///
/// ```dart
/// OudsInputTag(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
///
class OudsInputTag extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;

  const OudsInputTag({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  State<OudsInputTag> createState() => _OudsInputTagState();
}

class _OudsInputTagState extends State<OudsInputTag> {
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
    final tagBorderModifier = OudsInputTagControlBorderModifier(context);
    final tagTextColorModifier = OudsTagStyleModifier(context);
    final tagBackgroundColorModifier = OudsInputTagControlBackgroundColorModifier(context);

    return Visibility(visible: isVisible, child: _buildInputTag(context, tagBorderModifier, tagTextColorModifier, tagBackgroundColorModifier, tagState, isDisabled));
  }

  Widget _buildInputTag(BuildContext context, OudsInputTagControlBorderModifier tagBorderModifier, OudsTagStyleModifier tagTextColorModifier,
      OudsInputTagControlBackgroundColorModifier tagBgColorModifier, OudsTagControlState tagState, bool isDisabled) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    final inputTagToken = OudsTheme.of(context).componentsTokens(context).inputTag;
    final borderTokens = OudsTheme.of(context).borderTokens;
    final l10n = OudsLocalizations.of(context);

    return Semantics(
      enabled: !isDisabled,
      label: l10n?.core_tag_tag_input_role_a11y,
      container: true,
      button: true,
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
                SemanticsService.announce(l10n?.core_tag_tag_input_removed_a11y(widget.label) ?? '', TextDirection.ltr);
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
                if (_isFocused)
                  Positioned(
                    top: borderTokens.widthFocus / 2,
                    bottom: borderTokens.widthFocus / 2,
                    left: -borderTokens.widthFocus / 2,

                    /// to be changed to enhancement the focus.
                    right: -borderTokens.widthFocus / 2,

                    /// to be changed to enhancement the focus.
                    child: Container(
                      decoration: BoxDecoration(
                        border: OudsBorder().borderAll(
                          color: OudsTheme.of(context).colorScheme(context).borderFocus,
                          width: borderTokens.widthFocus,
                        ),
                        borderRadius: BorderRadius.circular(
                          tagToken.borderRadius + borderTokens.widthFocus,
                        ),
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    border: OudsBorder().borderAll(
                      color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset : Colors.transparent,
                      width: inputTagToken.borderWidthDefaultInteraction,
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

  Widget _buildLayout(BuildContext context, OudsInputTagControlBorderModifier tagBorderModifier, OudsTagStyleModifier tagTextColorModifier,
      OudsInputTagControlBackgroundColorModifier tagBgColorModifier, OudsTagControlState tagState, bool isDisabled) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    final typographyTokens = OudsTheme.of(context).typographyTokens;

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
              start: tagToken.spacePaddingInlineDefault,
              end: tagToken.spacePaddingInlineAssetDefault,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(widget.label,
                      textAlign: TextAlign.center,
                      style: typographyTokens.typeLabelStrongMedium(context).copyWith(
                            color: tagTextColorModifier.getTextColor(tagState),
                          )),
                ),
                SizedBox(width: tagToken.spaceColumnGapDefault),
                Semantics(
                  container: true,
                  label: OudsLocalizations.of(context)?.core_inputTag_delete_a11y,
                  button: true,
                  child: SvgPicture.asset(
                    excludeFromSemantics: true,
                    width: tagToken.sizeAssetDefault,
                    height: tagToken.sizeAssetDefault,
                    AppAssets.icons.componentTagClose,
                    package: OudsTheme.of(context).packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      OudsInputTagControlIconColorModifier(context).getIconColor(tagState)!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
