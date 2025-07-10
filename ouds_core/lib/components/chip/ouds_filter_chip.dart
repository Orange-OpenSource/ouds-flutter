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
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/chip/internal/chip_border_modifier.dart';
import 'package:ouds_core/components/chip/internal/chip_icon_style_modifier.dart';
import 'package:ouds_core/components/chip/internal/chip_text_style_modifier.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/control/internal/ouds_chip_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import '../utilities/app_assets.dart';
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

//// [OUDS Filter Chip design guidelines](https://unified-design-system.orange.com/472794e18/p/73c701-components)
/// OUDS Filter Chip design guidelines will be available soon
///
/// A filter chip is a compact UI element used in a design system to represent a filter option that can be selected or deselected by the user.
/// Filter chips allow users to refine content or data by applying one or more filters in a visually accessible and interactive way.
/// Purpose: Allows users to filter content by selecting or deselecting specific categories or attributes.
/// Behavior: Can be toggled on/off to refine displayed results. Selected chips remain visually distinct to indicate active filters.
///
/// This version of the filter chip uses the *text only* layout which is the most used layout.
/// Other layouts are available for this component: *text + icon* and *icon only*.
///
/// Parameters:
/// - [label]: Label displayed in the suggestion chip which describes the chip option.
/// - [avatar]: Icon displayed in the suggestion chip. Works well with universally recognized symbols, such as a heart for favorites or a checkmark for selection.

/// ## You can use [OudsFilterChip] like this :
///
/// ### Text only chip :
/// This is the default layout of the component.
///
///
/// ```dart
/// OudsFilterChip(
///       label: 'Label',
///       selected: true,
///       onSelected: () {},
///     );
/// ```
///
///
class OudsFilterChip extends StatefulWidget {
  final String? label;
  final String? avatar;
  final bool? selected;
  final ValueChanged<bool>? onSelected;

  const OudsFilterChip({super.key, this.label, this.avatar, this.selected, this.onSelected});

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
  State<OudsFilterChip> createState() => _OudsFilterChipState();

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

class _OudsFilterChipState extends State<OudsFilterChip> {
  String packageName = 'ouds_core';

  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  bool _isSelected = false;

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
    if (widget.onSelected == null) _isFocused = false; // Ignore focus changes if disabled
    setState(() => _isFocused = focus);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onSelected == null;
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final chipStateDeterminer = OudsChipControlStateDeterminer(enabled: !isDisabled, isPressed: _isPressed || isPressed, isHovered: isHovered || _isHovered, isFocused: _isFocused, isSelected: widget.selected!);

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
      enabled: widget.onSelected != null,
      selected: widget.selected == true,
      child: Material(
        //color: chipBgColorModifier.getBackgroundColor(chipState),
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            minHeight: chipToken.sizeMinHeightInteractiveArea,
          ),
          child: InkWell(
            focusNode: _focusNode,
            canRequestFocus: !isDisabled,
            onTap: () {
              updateSelectedData();
            },
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
                  _isSelected = highlighted;
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

  Widget _buildIconOnly(
      BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;
    final theme = OudsTheme.of(context);

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
            width: !widget.selected! ? chipToken.sizeMinWidth : null,
            color: chipBgColorModifier.getBackgroundColor(chipState),
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
              spacing: widget.selected! ? chipToken.spaceColumnGapIcon : theme.spaceScheme(context).fixedNone,
              children: [
                Visibility(
                  visible: widget.selected!,
                  child: SvgPicture.asset(
                    AppAssets.symbols.symbolsFilterChipSelected,
                    package: packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      chipIconColorModifier.getTickColor(chipState),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                OudsFilterChip.buildIcon(context, widget.avatar!, chipState),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconAndText(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlIconColorModifier chipIconColorModifier,
      OudsChipControlBackgroundColorModifier chipBgColorModifier, OudsChipControlState chipState, bool isDisabled) {
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
              start: widget.selected == true ? chipToken.spacePaddingInlineIcon : chipToken.spacePaddingInlineIconNone,
              end: chipToken.spacePaddingInlineIcon,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.selected!) ...[
                  SvgPicture.asset(
                    AppAssets.symbols.symbolsFilterChipSelected,
                    package: packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      chipIconColorModifier.getTickColor(chipState),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: chipToken.spaceColumnGapIcon),
                ],
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
                SizedBox(width: chipToken.spaceColumnGapIcon),
                OudsFilterChip.buildIcon(context, widget.avatar!, chipState),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextOnly(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier,
      OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlState chipState, bool isDisabled) {
    final chipToken = OudsTheme.of(context).componentsTokens(context).chip;

    return Stack(
      children: [
        // Draws the border behind the content without affecting layout size.
        // This allows the border (e.g. thickness or color) to change dynamically
        // without causing layout shifts or visual "jumps" in the UI.
        // Positioned.fill ensures the border exactly wraps the content's area
        Positioned.fill(
          child: Container(
            //color: Colors.red,
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
              start: widget.selected == true ? chipToken.spacePaddingInlineIcon : chipToken.spacePaddingInlineIconNone,
              end: chipToken.spacePaddingInlineIconNone,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.selected!) ...[
                  SvgPicture.asset(
                    AppAssets.symbols.symbolsFilterChipSelected,
                    package: packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      chipIconColorModifier.getTickColor(chipState),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: chipToken.spaceColumnGapIcon),
                ],
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

  Widget _buildLayout(BuildContext context, OudsChipControlBorderModifier chipBorderModifier, OudsChipControlIconColorModifier chipIconColorModifier, OudsChipControlBackgroundColorModifier chipBgColorModifier,
      OudsChipControlTextColorModifier chipTextColorModifier, OudsChipControlState chipState, bool isDisabled) {
    switch (widget.layout) {
      case OudsChipLayout.iconOnly:
        return _buildIconOnly(context, chipBorderModifier, chipIconColorModifier, chipBgColorModifier, chipState, isDisabled);
      case OudsChipLayout.iconAndText:
        return _buildIconAndText(context, chipBorderModifier, chipTextColorModifier, chipIconColorModifier, chipBgColorModifier, chipState, isDisabled);
      case OudsChipLayout.textOnly:
        return _buildTextOnly(context, chipBorderModifier, chipTextColorModifier, chipBgColorModifier, chipIconColorModifier, chipState, isDisabled);
    }
  }

  void updateSelectedData() {
    _isSelected = !_isSelected;
    // Added to improve visual rendering fluidity by allowing Flutter
    // to complete the current frame before executing the state change logic.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bool? newValue;
      newValue = !widget.selected!;
      widget.onSelected!(newValue);
      widget.selected! == newValue;
    });
  }
}
