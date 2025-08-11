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
import 'package:ouds_core/components/tag/internal/ouds_tag_size_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'internal/ouds_tag_border_modifier.dart';
import 'internal/ouds_tag_status_modifier.dart';
import 'internal/ouds_tag_text_style_modifier.dart';


///The [OudsTagLayout] defines the layout of the tag’s content.
///
/// This enum controls whether the tag displays text, an icon, a bullet or loader
enum OudsTagLayout {
  textOnly,
  textAndBullet,
  textAndIcon,
  textAndLoader;
}

/// Enum representing the state of the tag control.
enum OudsTagStatus {
  neutral,
  accent,
  positive,
  info,
  warning,
  negative,
  disabled,
}

/// The [OudsTagSize] defines the tag's visual size.
enum OudsTagSize {
  defaultSize,
  small;
}

/// The [OudsTagHierarchy] enum defines the visual importance of the tag within the UI.
enum OudsTagHierarchy {
  emphasized,
  muted;
}


// TODO: Add documentation URL once it is available
///
/// A tag is a small element that shows short info like a label, keyword, or category.
/// It helps users quickly find, group, or understand content.
/// Tags can stay in place or be removed, and can include icons or actions like close or edit.
///
/// This version of the tag uses the *text only* layout which is the most used layout.
/// Other layouts are available for this component: *text + icon*, *text + bullet* and *text + loader*.
///
/// parameters :
/// - [status] : The tag's status, [OudsTagStatus] influencing its color and style (e.g., negative, positive, warning).
/// - [size] : The size of the tag, [OudsTagSize] such as small or default, to fit various visual needs.
/// - [label] : A text to display inside the tag.
/// - [icon] : An optional SVG asset name to display an icon within the tag.
/// - [hierarchy]: The Tag appearance based on its [OudsTagHierarchy].
/// - [layout]: Defines the layout to be used for the tag [OudsTagLayout].

///
/// Styling details :
/// - The background color is determined by the [status], using [OudsTagStatus].
/// - The size and margins are adjusted according to the badge [size] via [OudsTagSize].
///
/// ## You can use [OudsTag] like this :
///
/// ### Text only tag :
/// This is the default layout of the component.
/// ```dart
/// OudsTag(
///       label: 'Label',
///       status: OudsTagStatus.accent,
///       size: OudsTagSize.small,
///       layout : OudsTagLayout.textAndBullet
///     );
/// ```
///
///
///
class OudsTag extends StatefulWidget {
  final String label;
  final OudsTagStatus status;
  final OudsTagSize? size;
  final OudsTagHierarchy hierarchy;
  final String? icon;
  final OudsTagLayout layout;

  const OudsTag({
    super.key,
    required this.label,
    this.status = OudsTagStatus.neutral,
    this.hierarchy = OudsTagHierarchy.emphasized,
    this.size = OudsTagSize.defaultSize,
    this.icon,
    this.layout = OudsTagLayout.textOnly,
  });

  static Widget buildIcon(
      BuildContext context,
      String? assetName,
      OudsTagStatus controlItemState,
      OudsTagHierarchy hierarchy,
      double width,
      double height
      ) {
    final statusModifier = OudsTagStatusModifier(context);

    return SvgPicture.asset(
      assetName?? statusModifier.getStatusIcon(controlItemState)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(controlItemState,hierarchy),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsTag> createState() => _OudsTagState();
}

class _OudsTagState extends State<OudsTag> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tagStatusModifier = OudsTagStatusModifier(context);
    final tagSizeModifier = OudsTagSizeModifier(context);
    final tagStyleModifier = OudsTagStyleModifier(context);

    return Semantics(
      child: Material(
        color: Colors.transparent,
        child:  _buildTag(context, tagStatusModifier, tagSizeModifier,tagStyleModifier),

      ),
    );
  }
  Widget _buildTag(BuildContext context,OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier,tagStyleModifier) {

    switch (widget.layout) {
      case OudsTagLayout.textOnly:
        return _buildTagTextOnly(context, tagStatusModifier, tagSizeModifier,tagStyleModifier);
      case OudsTagLayout.textAndBullet:
        return _buildTagTextAndBullet(context, tagStatusModifier, tagSizeModifier,tagStyleModifier);
      case OudsTagLayout.textAndIcon:
        return _buildTagTextAndIcon(context, tagStatusModifier, tagSizeModifier,tagStyleModifier);
      case OudsTagLayout.textAndLoader:
        return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
    }
  }

  Widget _buildTagTextAndLoader(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier,
      OudsTagStyleModifier tagStyleModifier,
      ) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(
          minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!,
          minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!
          ),
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: widthAndHeightAssetsContainer[OudsTagDimensions.width.name],
                  height: widthAndHeightAssetsContainer[OudsTagDimensions.height.name],
                  child: CircularProgressIndicator(
                    padding: tagSizeModifier.getAssetsPadding(widget.size,OudsTagLayout.textAndLoader),
                    color: tagStatusModifier.getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    strokeWidth: OudsTheme.of(context).spaceScheme(context).scaledThreeExtraSmall,
                  ),
                ),
                SizedBox(
                  width: tagSizeModifier.getSizeColumnGap(widget.size)
                ),
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: tagStyleModifier.buildTagTextStyle(
                        context, hierarchy: widget.hierarchy, status: widget.status, size: widget.size!)

                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextAndIcon(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier,
      OudsTagStyleModifier tagStyleModifier
      ) {
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(
                minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!,
                minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!
            ),
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: tagSizeModifier.getAssetsPadding(widget.size,OudsTagLayout.textAndIcon),
                  child:  OudsTag.buildIcon(context, widget.icon, widget.status, widget.hierarchy, widthAndHeightAssetsContainer[OudsTagDimensions.width.name]!, widthAndHeightAssetsContainer[OudsTagDimensions.height.name]!),
                ),
                SizedBox(
                  width: tagSizeModifier.getSizeColumnGap(widget.size),
                ),
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: tagStyleModifier.buildTagTextStyle(context, hierarchy: widget.hierarchy, status: widget.status, size: widget.size!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextAndBullet(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier,
      OudsTagStyleModifier tagStyleModifier
      )
  {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(
                minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!,
                minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!
            ),
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: widthAndHeightAssetsContainer[OudsTagDimensions.width.name],
                  height: widthAndHeightAssetsContainer[OudsTagDimensions.height.name],
                  child: SvgPicture.asset(
                    AppAssets.icons.roundedBullet,
                    package: OudsTheme.of(context).packageName,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      tagStatusModifier.getStatusIconColor(widget.status,widget.hierarchy),
                      BlendMode.srcIn
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                      style: tagStyleModifier.buildTagTextStyle(context, hierarchy: widget.hierarchy, status: widget.status, size: widget.size!)
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextOnly(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier,
      OudsTagStyleModifier tagStyleModifier
      ) {
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(
                minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!,
                minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!
            ),
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size,false),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: tagStyleModifier.buildTagTextStyle(context, hierarchy: widget.hierarchy, status: widget.status, size: widget.size!),
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