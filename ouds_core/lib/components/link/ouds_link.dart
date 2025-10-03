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
import 'package:ouds_core/components/link/internal/ouds_link_control_state.dart';
import 'package:ouds_core/components/link/internal/ouds_link_size_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/link/internal/ouds_link_status_modifier.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/link/internal/ouds_link_text_style_modifier.dart';

///The [OudsLinkLayout] defines the layout of the link’s content.
/// This enum controls whether the link displays text, text and icon, back or next
enum OudsLinkLayout {
  textOnly,
  textAndIcon,
  back,
  next;
}

/// The [OudsLinkSize] defines the link's visual size.
enum OudsLinkSize {
  defaultSize,
  small;
}

/// [OUDS Button design guidelines](https://unified-design-system.orange.com/472794e18/p/31c33b-link)
///
/// A link is a user interface element that allows navigation from one location to another,
/// either within the same page, across different pages of a site (or application), or to an external resource.
/// Typically rendered as underlined or styled text,
/// a link communicates its interactive nature visually and semantically.
/// It should always lead to a valid destination and be clearly labeled to describe the target or purpose.
/// Unlike a button, which triggers an action, a link’s primary function is navigation.
///
///
/// parameters :
/// - [size] : The size of the link, [OudsLinkSize] such as small or default, to fit various visual needs.
/// - [label] : A text to display in link component.
/// - [icon] : An optional SVG asset name to display an icon within the link.
/// - [layout]: Defines the layout to be used for the link [OudsLinkLayout].
/// - [onPressed]: Callback invoked when the link is clicked.
///
///
/// ## You can use [OudsLink] like this :
///
/// ### Small Text only link :
/// This is the default layout of the component.
/// ```dart
/// OudsLink(
///       label: 'Label',
///       size: OudsLinkSize.small,
///       onPressed: () {}
///     );
/// ```
///
/// ### Small Next link :
/// This is the default layout of the component.
/// ```dart
/// OudsLink(
///       label: 'Label',
///       size: OudsLinkSize.small,
///       layout : OudsLinkayout.next
///       onPressed: () {}
///     );
/// ```
///
/// ### Default link with Icon :
/// This is the default layout of the component.
/// ```dart
/// OudsLink(
///       label: 'Label',
///       layout : OudsLinkayout.textAndIcon
///       icon : 'assets/ic_heart.svg'
///       onPressed: () {}
///     );
/// ```
///
///
class OudsLink extends StatefulWidget {
  final String label;
  final String? icon;
  final OudsLinkLayout layout;
  final OudsLinkSize? size;
  final VoidCallback? onPressed;

  const OudsLink({
    super.key,
    required this.label,
    this.icon,
    this.layout = OudsLinkLayout.textOnly,
    this.size = OudsLinkSize.defaultSize,
    this.onPressed,
  }) :  assert(
    layout != OudsLinkLayout.textAndIcon || icon != null,
    'icon is required when layout is textAndIcon',
  );

  static Widget buildIcon(BuildContext context, String? assetName, OudsLinkControlState controlItemState, OudsLinkLayout layout, OudsLinkSize size) {
    final statusModifier = OudsLinkStatusModifier(context);
    final sizeModifier = OudsLinkSizeModifier(context);
    final iconSize = sizeModifier.getIconSize(size);
    final isIcon = layout == OudsLinkLayout.textAndIcon;
    //If the language is RTL, inverse the next and back arrow icon
    final rtlMode =  Directionality.of(context) == TextDirection.rtl;

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName ?? statusModifier.getStatusIcon(layout,rtlMode)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: iconSize[OudsLinkDimensions.width.name],
      height: iconSize[OudsLinkDimensions.height.name],
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        !isIcon ? statusModifier.getArrowColor(controlItemState) : statusModifier.getTextAndIconColor(controlItemState),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsLink> createState() => _OudsLinkState();
}

class _OudsLinkState extends State<OudsLink> {

  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

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

    final linkStateDeterminer = OudsLinkControlStateDeterminer(enabled: !isDisabled, isPressed: _isPressed || isPressed, isHovered: isHovered || _isHovered, isFocused: _isFocused);

    final linkControlState = linkStateDeterminer.determineControlState();
    final linkStatusColorModifier = OudsLinkStatusModifier(context);
    final linkSizeModifier = OudsLinkSizeModifier(context);
    final linkTextStyleModifier =  OudsLinkTextStyleModifier(context);

    switch (widget.layout) {
      case OudsLinkLayout.textOnly:
        return _buildLinkTextOnly(context, linkControlState, linkStatusColorModifier, linkSizeModifier, linkTextStyleModifier,isDisabled);
      case OudsLinkLayout.next:
        return _buildLinkNext(context, linkControlState, linkStatusColorModifier, linkSizeModifier,linkTextStyleModifier,isDisabled);
      case OudsLinkLayout.back:
      case OudsLinkLayout.textAndIcon:
        return _buildLinkBackAndIcon(context, linkControlState, linkStatusColorModifier, linkSizeModifier,linkTextStyleModifier,isDisabled);
    }
  }


  Widget _buildLinkTextOnly(BuildContext context,
      OudsLinkControlState linkControlState,
      OudsLinkStatusModifier linkStatusModifier,
      OudsLinkSizeModifier linkSizeModifier,
      OudsLinkTextStyleModifier linkTextStyleModifier,
      bool isDisabled) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;
    final minHeightAndWidth = linkSizeModifier.getMinWidthAndHeight(widget.size);

    return Semantics(
      enabled: !isDisabled,
      link: true,
      label: "Link",
      child: Container(
          constraints: BoxConstraints(
              minHeight: minHeightAndWidth[OudsLinkDimensions.height.name]!,
              minWidth: minHeightAndWidth[OudsLinkDimensions.width.name]!,
          ),
        decoration: BoxDecoration(
          border: Border.all(
            width:  OudsTheme.of(context).borderTokens.widthFocusInset,
            color:  _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset: Colors.transparent,
          ),
        ),
          child: InkWell(
            onTap: () {},
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
              children: [
                // Border exterior
                if (_isFocused)
                  Positioned(
                    top: -OudsTheme.of(context).borderTokens.widthFocus ,
                    bottom: -OudsTheme.of(context).borderTokens.widthFocus,
                    left: -OudsTheme.of(context).borderTokens.widthFocus ,
                    right: -OudsTheme.of(context).borderTokens.widthFocus ,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: OudsTheme.of(context).colorScheme(context).borderFocus,
                          width: OudsTheme.of(context).borderTokens.widthFocus,
                        ),
                      ),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: linkToken.spacePaddingInline,
                    vertical: linkToken.spacePaddingBlock
                  ),

                    child: Text(
                      widget.label,
                      textAlign: TextAlign.left,
                      style:   linkTextStyleModifier.buildLinkTextStyle(context,size: widget.size!).copyWith(
                        color: linkStatusModifier.getTextAndIconColor(linkControlState),
                        decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
                        decorationColor : linkStatusModifier.getTextAndIconColor(linkControlState),
                      ),
                    )
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildLinkNext(BuildContext context,
      OudsLinkControlState linkControlState,
      OudsLinkStatusModifier linkStatusModifier,
      OudsLinkSizeModifier linkSizeModifier,
      OudsLinkTextStyleModifier linkTextStyleModifier,
      bool isDisabled) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;
    final minHeightAndWidth = linkSizeModifier.getMinWidthAndHeight(widget.size);

    return Semantics(
      enabled: !isDisabled,
      link: true,
      label: "link next",
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeightAndWidth[OudsLinkDimensions.height.name]!,
          minWidth: minHeightAndWidth[OudsLinkDimensions.width.name]!,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width:  OudsTheme.of(context).borderTokens.widthFocusInset,
            color:  _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset: Colors.transparent,
          ),
        ),
        child: InkWell(
          onTap: () {},
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
                _isPressed = highlighted;
              }
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Border exterior
              if (_isFocused)
                Positioned(
                  top: -OudsTheme.of(context).borderTokens.widthFocus ,
                  bottom: -OudsTheme.of(context).borderTokens.widthFocus,
                  left: -OudsTheme.of(context).borderTokens.widthFocus ,
                  right: -OudsTheme.of(context).borderTokens.widthFocus ,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: OudsTheme.of(context).colorScheme(context).borderFocus,
                        width: OudsTheme.of(context).borderTokens.widthFocus,
                      ),
                    ),
                  ),
                ),
              // Border interior + content
               Container(
                 padding: EdgeInsets.symmetric(
                      horizontal: linkToken.spacePaddingInline,
                      vertical: linkToken.spacePaddingBlock
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    spacing: linkSizeModifier.getSizeColumnGap(widget.size, widget.layout)!,
                    children: [
                      Flexible(
                        child: Text(
                         widget.label,
                          textAlign: TextAlign.left,
                          style:  linkTextStyleModifier.buildLinkTextStyle(context,size: widget.size!).copyWith(
                            color: linkStatusModifier.getTextAndIconColor(linkControlState),
                            decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
                            decorationColor: linkStatusModifier.getTextAndIconColor(linkControlState),
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                     OudsLink.buildIcon(context, widget.icon, linkControlState, widget.layout, widget.size!),
                    ],
                  )
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkBackAndIcon(BuildContext context,
      OudsLinkControlState linkControlState,
      OudsLinkStatusModifier linkStatusModifier,
      OudsLinkSizeModifier linkSizeModifier,
      OudsLinkTextStyleModifier linkTextStyleModifier,
      bool isDisabled) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;
    final minHeightAndWidth = linkSizeModifier.getMinWidthAndHeight(widget.size);

    return Semantics(
      enabled: !isDisabled,
      link: true,
      label: widget.layout == OudsLinkLayout.back ? "link Back" : "link with icon",
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeightAndWidth[OudsLinkDimensions.height.name]!,
          minWidth: minHeightAndWidth[OudsLinkDimensions.width.name]!,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width:  OudsTheme.of(context).borderTokens.widthFocusInset,
            color:  _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset: Colors.transparent,
          ),
        ),
        child: InkWell(
          onTap: () {},
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
                _isPressed = highlighted;
              }
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            //alignment: Alignment.center,
            children: [
              // Border exterior
              if (_isFocused)
                Positioned(
                  top: -OudsTheme.of(context).borderTokens.widthFocus ,
                  bottom: -OudsTheme.of(context).borderTokens.widthFocus,
                  left: -OudsTheme.of(context).borderTokens.widthFocus ,
                  right: -OudsTheme.of(context).borderTokens.widthFocus ,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: OudsTheme.of(context).colorScheme(context).borderFocus,
                        width: OudsTheme.of(context).borderTokens.widthFocus,
                      ),
                    ),
                  ),
                ),

              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: linkToken.spacePaddingInline,
                      vertical: linkToken.spacePaddingBlock
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: linkSizeModifier.getSizeColumnGap(widget.size, widget.layout)!,
                    children: [
                      OudsLink.buildIcon(context, widget.icon, linkControlState, widget.layout, widget.size!),
                      Flexible(
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.left,
                          style:  linkTextStyleModifier.buildLinkTextStyle(context,size: widget.size!).copyWith(
                              color: linkStatusModifier.getTextAndIconColor(linkControlState),
                              decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
                            decorationColor: linkStatusModifier.getTextAndIconColor(linkControlState)
                          ),
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
 }
