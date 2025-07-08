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
import 'package:ouds_core/components/chip/internal/chip_border_modifier.dart';
import 'package:ouds_core/components/chip/internal/chip_icon_style_modifier.dart';
import 'package:ouds_core/components/chip/internal/chip_text_style_modifier.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import 'internal/chip_background_modifier.dart';

///The [OudsChipLayout] defines the layout of the chip’s content.
///
/// This enum controls whether the chip displays text, an icon, or both.
enum OudsChipLayout {
  textOnly,
  iconAndText,
  iconOnly;
}

/// The [OudsChipStyle] defines the chip's visual behavior and feedback.
enum OudsChipStyle {
  defaultStyle,
  selected,
}

/// [OUDS Chip design guidelines](https://unified-design-system.orange.com/472794e18/p/73c701-components)
///
/// A chip is a compact UI element used to present recommended or predictive options based on user input or context.
/// Often found in search bars, forms, or messaging interfaces, suggestion chips help users quickly select from relevant suggestions.
/// They are typically non-selected by default and can be tapped or clicked to apply the suggestion, streamlining user input and enhancing usability.
///
/// This version of the chip uses the *text only* layout which is the most used layout.
/// Other layouts are available for this component: *text + icon* and *icon only*.
///
/// Parameters:
/// - [label]: Label displayed in the suggestion chip which describes the chip option.
/// - [avatar]: Icon displayed in the suggestion chip. Works well with universally recognized symbols, such as a heart for favorites or a checkmark for selection.

/// ## You can use [OudsChip] like this :
///
/// ### Text only chip :
/// This is the default layout of the component.
///
///
/// ```dart
/// OudsChip(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
///
class OudsChip extends StatefulWidget {
  final String? label;
  final String? avatar;
  final VoidCallback? onPressed;

  const OudsChip({
    super.key,
    this.label,
    this.avatar,
    this.onPressed,
  });

  static Widget buildIcon(
    BuildContext context,
    String assetName,
    OudsChipControlState controlItemState,
  ) {
    final controlIconModifier = OudsChipControlIconColorModifier(context);

    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      width: OudsTheme.of(context).componentsTokens(context).chip.sizeIcon,
      height: OudsTheme.of(context).componentsTokens(context).chip.sizeIcon,
      colorFilter: ColorFilter.mode(
        controlIconModifier.getIconColor(controlItemState),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsChip> createState() => _OudsChipState();

  /// Property that detects and returns the chip layout based on the provided elements (text and/or icon)
  OudsChipLayout get layout => _detectLayout(label, avatar);

  static OudsChipLayout _detectLayout(String? label, String? icon) {
    if (label != null && icon != null) {
      return OudsChipLayout.iconAndText;
    } else if (label != null) {
      return OudsChipLayout.textOnly;
    } else if (icon != null) {
      return OudsChipLayout.iconOnly;
    }
    return OudsChipLayout.textOnly;
  }
}

class _OudsChipState extends State<OudsChip> {
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

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

    final chipStateDeterminer = OudsChipControlStateDeterminer(enabled: !isDisabled, isPressed: isPressed || _isPressed, isHovered: isHovered || _isHovered, isFocused: _isFocused);

    final chipState = chipStateDeterminer.determineControlState();
    final chipBorderModifier = OudsChipControlBorderModifier(context);
    final chipTextColorModifier = OudsChipControlTextColorModifier(context);
    final chipIconColorModifier = OudsChipControlIconColorModifier(context);
    final chipBackgroundColorModifier = OudsChipControlBackgroundColorModifier(context);

    return _buildFilterChip(context, chipBorderModifier, chipTextColorModifier, chipBackgroundColorModifier, chipIconColorModifier, chipState, isDisabled);
  }

  Widget _buildFilterChip(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier,
      OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    return Semantics(
      enabled: isDisabled,
      //selected: widget.selected == true,
      child: Material(
        color: Colors.transparent,
        //color: chipBgColorModifier.getBackgroundColor(chipState),
        child: Container(
          constraints: BoxConstraints(
            minHeight: chipToken.sizeMinHeightInteractiveArea,
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
              alignment: Alignment.center,
              children: [
                // Border exterior

                if (_isFocused)
                  Positioned(
                    top: OudsTheme.of(context).borderTokens.widthFocus / 2,
                    bottom: OudsTheme.of(context).borderTokens.widthFocus / 2,
                    left: -OudsTheme.of(context).borderTokens.widthFocus / 2,
                    right: -OudsTheme.of(context).borderTokens.widthFocus / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: OudsTheme.of(context).colorScheme(context).borderFocus,
                          width: OudsTheme.of(context).borderTokens.widthFocus,
                        ),
                        borderRadius: BorderRadius.circular(
                          OudsTheme.of(context).componentsTokens(context).chip.borderRadius + OudsTheme.of(context).borderTokens.widthFocus,
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
                      OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                    ),
                  ),
                  child: _buildLayout(
                    context,
                    chipBorderModifier,
                    chipIconColorModifier,
                    chipBgColorModifier,
                    chipTextColorModifier,
                    chipState,
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

  Widget _buildLayout(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier,
      OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipBackgroundColorModifier = OudsChipControlBackgroundColorModifier(context);
    switch (widget.layout) {
      case OudsChipLayout.iconOnly:
        return _buildChipIconOnly(context, chipBorderModifier, chipIconColorModifier, chipBgColorModifier, chipState, isDisabled);
      case OudsChipLayout.iconAndText:
        return _buildChipIconAndText(context, chipBorderModifier, chipTextColorModifier, chipIconColorModifier, chipBgColorModifier, chipState, isDisabled);
      case OudsChipLayout.textOnly:
        return _buildChipTextOnly(context, chipBorderModifier, chipTextColorModifier, chipBackgroundColorModifier, chipState, isDisabled);
    }
  }

  Widget _buildChipIconOnly(
      BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    return Stack(
      children: [
        // Draws the border behind the content without affecting layout size.
        // This allows the border (e.g. thickness or color) to change dynamically
        // without causing layout shifts or visual "jumps" in the UI.
        // Positioned.fill ensures the border exactly wraps the content's area
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: chipBorderModifier.getBorder(chipState),
              borderRadius: BorderRadius.circular(
                OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
              ),
            ),
          ),
        ),

        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
          ),
          child: Container(
            //margin: EdgeInsets.all(1),
            color: chipBgColorModifier.getBackgroundColor(chipState),
            width: chipToken.sizeMinWidth,
            padding: EdgeInsetsDirectional.only(
              top: chipToken.spacePaddingBlockIconOnly,
              bottom: chipToken.spacePaddingBlockIconOnly,
              start: chipToken.spacePaddingInlineIcon,
              end: chipToken.spacePaddingInlineIcon,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OudsChip.buildIcon(
                  context,
                  widget.avatar!,
                  chipState,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    /*
    return Container(
      width: chipToken.sizeMinWidth,
      padding: EdgeInsetsGeometry.directional(
        top: chipToken.spacePaddingBlockIconOnly,
        bottom: chipToken.spacePaddingBlockIconOnly,
        start: chipToken.spacePaddingInlineIcon,
        end: chipToken.spacePaddingInlineIcon,
      ),
      decoration: BoxDecoration(
        border: chipBorderModifier.getBorder(chipState),
        borderRadius: BorderRadius.circular(
          OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
        ),
      ),
      child: OudsChip.buildIcon(
        context,
        widget.avatar!,
        chipState,
      ),
    );

     */
    /*
    return Semantics(
      //label: OudsLocalizations.of(context)?.core_chip_icon_only_a11y,
      child: Focus(
        focusNode: _focusNode,
        child: Material(
          color: chipBgColorModifier.getBackgroundColor(chipState),
          child: InkWell(
            canRequestFocus: !isDisabled,
            onTap: () {},
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
            /*
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocus : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocus),
                  borderRadius: BorderRadius.circular(
                    OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                  )),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocusInset),
                    borderRadius: BorderRadius.circular(
                      OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                    )),

             */
            child: Container(
              width: chipToken.sizeMinWidth,
              padding: EdgeInsetsGeometry.directional(
                top: chipToken.spacePaddingBlockIconOnly,
                bottom: chipToken.spacePaddingBlockIconOnly,
                start: chipToken.spacePaddingInlineIcon,
                end: chipToken.spacePaddingInlineIcon,
              ),
              decoration: BoxDecoration(
                border: chipBorderModifier.getBorder(chipState),
                borderRadius: BorderRadius.circular(
                  OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                ),
              ),
              child: OudsChip.buildIcon(
                context,
                widget.avatar!,
                chipState,
              ),
            ),
          ),
          //)),
        ),
      ),
    );

     */
  }

  Widget _buildChipIconAndText(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlIconColorModifier chipIconColorModifier,
      OudsChipControlBackgroundColorModifier chipBgColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    /*
    return Semantics(
        //label: OudsLocalizations.of(context)?.core_chip_text_and_icon_a11y,
        child: Focus(
      focusNode: _focusNode,
      child: Material(
        color: chipBgColorModifier.getBackgroundColor(chipState),
        child: InkWell(
          canRequestFocus: !isDisabled,
          onTap: () {},
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
          /*
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocus : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocus),
                  borderRadius: BorderRadius.circular(
                    OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                  ),),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocusInset),
                    borderRadius: BorderRadius.circular(
                      OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                    )),

             */
          child: Container(
            padding: EdgeInsetsGeometry.directional(
              top: chipToken.spacePaddingBlock,
              bottom: chipToken.spacePaddingBlock,
              start: chipToken.spacePaddingInlineIcon,
              end: chipToken.spacePaddingInlineIconNone,
            ),
            decoration: BoxDecoration(
              border: chipBorderModifier.getBorder(chipState),
              borderRadius: BorderRadius.circular(
                OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: chipToken.spaceColumnGapIcon,
              children: [
                OudsChip.buildIcon(context, widget.avatar!, chipState),
                Flexible(
                    child: Text(
                  widget.label ?? "",
                  style: TextStyle(
                      fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                      fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                      fontFamily: OudsTheme.of(context).fontFamily,
                      color: chipTextColorModifier.getTextColor(chipState)),
                )),
              ],
            ),
          ),
        ),
        //)),
      ),
    ));

     */

    return Stack(
      children: [
        // Draws the border behind the content without affecting layout size.
        // This allows the border (e.g. thickness or color) to change dynamically
        // without causing layout shifts or visual "jumps" in the UI.
        // Positioned.fill ensures the border exactly wraps the content's area

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: chipBorderModifier.getBorder(chipState),
              borderRadius: BorderRadius.circular(
                OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
              ),
            ),
          ),
        ),

        // Content (e.g., Row with icon and label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
          ),
          child: Container(
            //margin: EdgeInsets.all(1),
            color: chipBgColorModifier.getBackgroundColor(chipState),
            padding: EdgeInsetsDirectional.only(
              top: chipToken.spacePaddingBlock,
              bottom: chipToken.spacePaddingBlock,
              start: chipToken.spacePaddingInlineIcon,
              end: chipToken.spacePaddingInlineIconNone,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OudsChip.buildIcon(context, widget.avatar!, chipState),
                SizedBox(width: chipToken.spaceColumnGapIcon),
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                      fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                      fontFamily: OudsTheme.of(context).fontFamily,
                      color: chipTextColorModifier.getTextColor(chipState),
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

  Widget _buildChipTextOnly(
      BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    /*
    return Semantics(
        //label: OudsLocalizations.of(context)?.core_chip_text_only_a11y,
        child: Focus(
      focusNode: _focusNode,
      child: Material(
        color: chipBgColorModifier.getBackgroundColor(chipState),
        child: InkWell(
          canRequestFocus: !isDisabled,
          onTap: () {},
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
          /*
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocus : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocus),
                  borderRadius: BorderRadius.circular(
                    OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                  )),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: _isFocused ? OudsTheme.of(context).colorScheme(context).borderFocusInset : Colors.transparent, width: OudsTheme.of(context).borderTokens.widthFocusInset),
                    borderRadius: BorderRadius.circular(
                      OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
                    )),

             */
          child: Container(
            padding: EdgeInsetsGeometry.directional(
              top: chipToken.spacePaddingBlock,
              bottom: chipToken.spacePaddingBlock,
              start: chipToken.spacePaddingInlineIconNone,
              end: chipToken.spacePaddingInlineIconNone,
            ),
            decoration: BoxDecoration(
              border: chipBorderModifier.getBorder(chipState),
              borderRadius: BorderRadius.circular(
                OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
              ),
            ),
            child: Text(
              widget.label ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                  fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                  letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                  fontFamily: OudsTheme.of(context).fontFamily,
                  color: chipTextColorModifier.getTextColor(chipState)),
            ),
          ),
        ),
        //)),
      ),
    ));

     */

    return Stack(
      children: [
        // Draws the border behind the content without affecting layout size.
        // This allows the border (e.g. thickness or color) to change dynamically
        // without causing layout shifts or visual "jumps" in the UI.
        // Positioned.fill ensures the border exactly wraps the content's area
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: chipBorderModifier.getBorder(chipState),
              borderRadius: BorderRadius.circular(
                OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
              ),
            ),
          ),
        ),

        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            OudsTheme.of(context).componentsTokens(context).chip.borderRadius,
          ),
          child: Container(
            color: chipBgColorModifier.getBackgroundColor(chipState),
            //margin: EdgeInsets.all(1),
            padding: EdgeInsetsDirectional.only(
              top: chipToken.spacePaddingBlock,
              bottom: chipToken.spacePaddingBlock,
              start: chipToken.spacePaddingInlineIconNone,
              end: chipToken.spacePaddingInlineIconNone,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: OudsTheme.of(context).fontTokens.sizeLabelMedium,
                      fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelMedium,
                      fontFamily: OudsTheme.of(context).fontFamily,
                      color: chipTextColorModifier.getTextColor(chipState),
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
