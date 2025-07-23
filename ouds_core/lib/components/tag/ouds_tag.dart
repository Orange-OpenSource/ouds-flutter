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
import '../utilities/app_assets.dart';
import 'internal/ouds_tag_status_modifier.dart';


///The [OudsTagLayout] defines the layout of the tag’s content.
///
/// This enum controls whether the chip displays text, an icon, or both.
enum OudsTagLayout {
  textOnly,
  textAndBullet,
  textAndIcon,
  textAndLoader;
}

/// The [OudsTagSize] defines the tag's visual size.
enum OudsTagSize {
  defaultSize,
  small;
}

/// The [OudsTagSize] defines the tag's shape.
enum OudsTagShape {
  rounded,
  squared;
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
/// - [status] : The badge's status, influencing its color and style (e.g., negative, positive, warning).
/// - [size] : The size of the badge, such as medium, large, etc., to fit various visual needs.
/// - [label] : An optional text to display inside the badge, often used for numbers or status texts.
/// - [icon] : An optional SVG asset name to display an icon within the badge, complementing or replacing the label.
///
///
/// Styling details :
/// - The background color is determined by the [status], using [OudsTagStatus].
/// - The size and margins are adjusted according to the badge [size] via [OudsTagSize].
///
/// ## You can use [OudsTag] like this :
///
/// ### Text only tag :
/// This is the default layout of the component.
///
///
///
///
class OudsTag extends StatefulWidget {
  final String label;
  final OudsTagStatus status;
  final OudsTagSize? size;
  final OudsTagHierarchy hierarchy;
  final OudsTagShape shape;
  final String? icon;
  final bool? bullet;
  final bool? loader;
  final bool? isIcon;

  const OudsTag({
    super.key,
    required this.label,
    this.status = OudsTagStatus.neutral,
    this.hierarchy = OudsTagHierarchy.emphasized,
    this.shape = OudsTagShape.rounded,
    this.size = OudsTagSize.defaultSize,
    this.icon,
    this.bullet = false,
    this.loader = false,
    this.isIcon = false
  });

  static Widget buildIcon(
      BuildContext context,
      String? assetName,
      OudsTagStatus controlItemState,
      OudsTagHierarchy hierarchy,
      OudsTagSize? size
      ) {
    final statusModifier = OudsTagStatusModifier(context);

    return SvgPicture.asset(
      assetName?? statusModifier.getStatusIcon(controlItemState),
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      fit: BoxFit.contain,
      width: size != null && size == OudsTagSize.small ? OudsTheme.of(context).sizeScheme(context).iconWithLabelSmallSizeSmall : OudsTheme.of(context).sizeScheme(context).iconWithLabelMediumSizeSmall , // ouds/size/icon/with-label/small/size-small
      height: size != null && size == OudsTagSize.small ? OudsTheme.of(context).sizeScheme(context).iconWithLabelSmallSizeSmall : OudsTheme.of(context).sizeScheme(context).iconWithLabelMediumSizeSmall , // ouds/size/icon/with-label/small/size-small
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(controlItemState,hierarchy),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsTag> createState() => _OudsTagState();

  /// Property that detects and returns the tag layout based on the provided elements
  OudsTagLayout get layout => _detectLayout(icon, isIcon, bullet,loader);

  static OudsTagLayout _detectLayout(String? icon,bool? isIcon, bool? bullet,  bool? loader) {
    if (icon != null || isIcon == true) {
      return OudsTagLayout.textAndIcon;
    } else if (bullet != null && bullet == true) {
      return OudsTagLayout.textAndBullet;
    } else if (loader != null && loader == true) {
      return OudsTagLayout.textAndLoader;
    }
    return OudsTagLayout.textOnly;
  }
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

    final minWidthAndHeight = tagSizeModifier.getWidthAndHeight(widget.size);

    return Semantics(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
              minHeight: minWidthAndHeight['height']!,
              minWidth: minWidthAndHeight['width']!
          ),
          child: _buildTag(context, tagStatusModifier, tagSizeModifier),
        ),
      ),
    );
  }
  Widget _buildTag(BuildContext context,OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier) {


    switch (widget.layout) {
      case OudsTagLayout.textOnly:
        return _buildTagTextOnly(context, tagStatusModifier, tagSizeModifier);
      case OudsTagLayout.textAndBullet:
        return _buildTagTextAndBullet(context, tagStatusModifier, tagSizeModifier);
      case OudsTagLayout.textAndIcon:
        return _buildTagTextAndIcon(context, tagStatusModifier, tagSizeModifier);
      case OudsTagLayout.textAndLoader:
        return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier);

    }


  }

  Widget _buildTagTextAndLoader(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier
      ) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return Stack(
      children: [
        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.shape == OudsTagShape.rounded ? tagToken.borderRadius : 0,
          ),
          child: Container(
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding( padding: EdgeInsetsGeometry.all(
                    widget.size != null && widget.size == OudsTagSize.small
                        ? tagToken.spaceInsetSmallAsset
                        : tagToken.spaceInsetDefaultAsset),
                child: SizedBox(
                  width: widget.size != null && widget.size == OudsTagSize.small
                      ? tagToken.sizeLoaderSmall
                      : tagToken.sizeLoaderDefault,
                  height: widget.size != null && widget.size == OudsTagSize.small
                      ? tagToken.sizeLoaderSmall
                      : tagToken.sizeLoaderDefault,
                  child: CircularProgressIndicator(
                    color: tagStatusModifier.getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    strokeWidth: 3,
                  ),
                )
                ),
                SizedBox(
                  width: widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style:
                    widget.size == OudsTagSize.defaultSize?
                    OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    )
                        : OudsTheme.of(context).typographyTokens.typeLabelStrongSmall(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy) ,
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

  Widget _buildTagTextAndIcon(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier
      ) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return Stack(
      children: [
        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.shape == OudsTagShape.rounded ? tagToken.borderRadius : 0,
          ),
          child: Container(
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(
                      widget.size != null && widget.size == OudsTagSize.small
                          ? tagToken.spaceInsetSmallAsset
                          : tagToken.spaceInsetDefaultAsset), //ouds/💠_indicator/tag/space/inset/icon-default
                child: OudsTag.buildIcon(context, widget.icon, widget.status, widget.hierarchy, widget.size)),
                SizedBox(
                  width: widget.size != null && widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style:
                    widget.size == OudsTagSize.defaultSize?
                    OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    )
                        : OudsTheme.of(context).typographyTokens.typeLabelStrongSmall(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy) ,
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

  Widget _buildTagTextAndBullet(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier
      )
  {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return Stack(
      children: [
        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.shape == OudsTagShape.rounded ? tagToken.borderRadius : 0,
          ),
          child: Container(
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding( padding: EdgeInsetsGeometry.all(
                    widget.size != null && widget.size == OudsTagSize.small
                        ? tagToken.spaceInsetSmallAsset
                        : tagToken.spaceInsetDefaultAsset), //ouds/💠_indicator/tag/space/inset/bullet-default
                    child: SizedBox(
                      width: 10,// ouds/💠_indicator/tag/size/asset-default,
                      height: 10, //ouds/💠_indicator/tag/size/asset-default
                      child: SvgPicture.asset(
                        AppAssets.symbols.symbolsTagBullet,
                        package: OudsTheme.of(context).packageName,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          tagStatusModifier.getStatusIconColor(widget.status,widget.hierarchy),
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                ),
                SizedBox(
                  width: widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style:
                    widget.size == OudsTagSize.defaultSize?
                    OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    )
                        : OudsTheme.of(context).typographyTokens.typeLabelStrongSmall(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy) ,
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


  Widget _buildTagTextOnly(
      BuildContext context,
      OudsTagStatusModifier tagStatusModifier,
      OudsTagSizeModifier tagSizeModifier
      ) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return Stack(
      children: [
        // Content (e.g., Row with label)...
        ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.shape == OudsTagShape.rounded ? tagToken.borderRadius : 0,
          ),
          child: Container(
            color: tagStatusModifier.getStatusColor(widget.status,widget.hierarchy),
            padding: tagSizeModifier.getPadding(widget.size,false),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.label ?? "",
                    textAlign: TextAlign.center,
                    style:
                    widget.size == OudsTagSize.defaultSize?
                    OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy),
                    )
                        : OudsTheme.of(context).typographyTokens.typeLabelStrongSmall(context).copyWith(
                      color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(widget.status, widget.hierarchy) ,
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
