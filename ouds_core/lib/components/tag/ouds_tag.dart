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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_size_modifier.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

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
}

/// Enum representing the state of the tag control.
enum OudsTagStatus {
  neutral,
  accent,
  positive,
  info,
  warning,
  negative,
}

/// The [OudsTagSize] defines the tag's visual size.
enum OudsTagSize {
  defaultSize,
  small;
}

/// The [OudsTagAppearance] enum defines the visual importance of the tag within the UI.
enum OudsTagAppearance {
  emphasized,
  muted;
}

///
/// [OUDS Tag Design Guidelines](https://r.orange.fr/r/S-ouds-doc-tag)
///
/// **Reference design version : 1.4.0**
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
/// - [appearance]: The Tag appearance based on its [OudsTagAppearance].
/// - [layout]: Defines the layout to be used for the tag [OudsTagLayout].
/// - [loading]: A circular progress indicator displayed in the input or tag area to indicate that tags are being loaded or processed.
///
///
/// Styling details :
/// - The background color is determined by the [status], using [OudsTagStatus].
/// - The size and margins are adjusted according to the badge [size] via [OudsTagSize].
///
/// ### You can use [OudsTag] component in your project, customizing parameters as needed :
///
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
  final bool enabled;
  final OudsTagStatus status;
  final OudsTagSize? size;
  final OudsTagAppearance appearance;
  final String? icon;
  final OudsTagLayout layout;
  final bool loading;

  const OudsTag(
      {super.key,
      required this.label,
      this.enabled = true,
      this.status = OudsTagStatus.neutral,
      this.appearance = OudsTagAppearance.emphasized,
      this.size = OudsTagSize.defaultSize,
      this.icon,
      this.layout = OudsTagLayout.textOnly,
      this.loading = false});

  static Widget buildIcon(BuildContext context, String? assetName, OudsTagStatus controlItemState, OudsTagAppearance hierarchy, double width, double height, bool isEnabled) {
    final statusModifier = OudsTagStatusModifier(context);

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName ?? statusModifier.getStatusIcon(controlItemState)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(controlItemState, hierarchy, isEnabled),
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
    final l10n = OudsLocalizations.of(context);

    return Semantics(
      label: widget.loading ? "${l10n?.core_common_loading_a11y}, ${widget.label}" : widget.label,
      enabled: widget.enabled,
      child: Material(
        color: Colors.transparent,
        child: ExcludeSemantics(child: _buildTag(context, tagStatusModifier, tagSizeModifier, tagStyleModifier)),
      ),
    );
  }

  Widget _buildTag(BuildContext context, OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier, tagStyleModifier) {
    switch (widget.layout) {
      case OudsTagLayout.textOnly:
        if (widget.loading) {
          return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        } else {
          return _buildTagTextOnly(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        }
      case OudsTagLayout.textAndBullet:
        if (widget.loading) {
          return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        } else {
          return _buildTagTextAndBullet(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        }
      case OudsTagLayout.textAndIcon:
        if (widget.loading) {
          return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        } else {
          return _buildTagTextAndIcon(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
        }
    }
  }

  Widget _buildTagTextAndLoader(
    BuildContext context,
    OudsTagStatusModifier tagStatusModifier,
    OudsTagSizeModifier tagSizeModifier,
    OudsTagStyleModifier tagStyleModifier,
  ) {
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!, minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!),
            color: OudsTheme.of(context).colorScheme(context).surfaceSecondary,
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: widthAndHeightAssetsContainer[OudsTagDimensions.width.name],
                  height: widthAndHeightAssetsContainer[OudsTagDimensions.height.name],
                  child: Semantics(
                    child: CircularProgressIndicator(
                      padding: tagSizeModifier.getLoadingAssetsPadding(widget.size),
                      color: OudsTheme.of(context).colorScheme(context).contentDefault,
                      strokeWidth: OudsTheme.of(context).spaceScheme(context).scaledThreeExtraSmall,
                    ),
                  ),
                ),
                SizedBox(width: tagSizeModifier.getSizeColumnGap(widget.size)),
                Flexible(
                  child:
                      Text(widget.label, textAlign: TextAlign.center, style: tagStyleModifier.buildTagTextStyle(context, appearance: widget.appearance, status: widget.status, size: widget.size!, isLoading: widget.loading, isEnabled: widget.enabled)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextAndIcon(BuildContext context, OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier, OudsTagStyleModifier tagStyleModifier) {
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!, minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!),
            color: tagStatusModifier.getStatusColor(widget.status, widget.appearance, widget.enabled),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: tagSizeModifier.getAssetsPadding(widget.size, OudsTagLayout.textAndIcon),
                  child: OudsTag.buildIcon(context, widget.icon, widget.status, widget.appearance, widthAndHeightAssetsContainer[OudsTagDimensions.width.name]!, widthAndHeightAssetsContainer[OudsTagDimensions.height.name]!, widget.enabled),
                ),
                SizedBox(
                  width: tagSizeModifier.getSizeColumnGap(widget.size),
                ),
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: tagStyleModifier.buildTagTextStyle(context, appearance: widget.appearance, status: widget.status, size: widget.size!, isEnabled: widget.enabled),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextAndBullet(BuildContext context, OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier, OudsTagStyleModifier tagStyleModifier) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    final widthAndHeightAssetsContainer = tagSizeModifier.getAssetsSize(widget.size);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
          child: Container(
            constraints: BoxConstraints(minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!, minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!),
            color: tagStatusModifier.getStatusColor(widget.status, widget.appearance, widget.enabled),
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
                    colorFilter: ColorFilter.mode(tagStatusModifier.getStatusIconColor(widget.status, widget.appearance, widget.enabled), BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  width: widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(widget.label, textAlign: TextAlign.center, style: tagStyleModifier.buildTagTextStyle(context, appearance: widget.appearance, status: widget.status, size: widget.size!, isEnabled: widget.enabled)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagTextOnly(BuildContext context, OudsTagStatusModifier tagStatusModifier, OudsTagSizeModifier tagSizeModifier, OudsTagStyleModifier tagStyleModifier) {
    final minWidthAndHeight = tagSizeModifier.getMinWidthAndHeight(widget.size);
    return Semantics(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: OudsTagControlBorderModifier.getBorderRadius(context),
            child: Container(
              constraints: BoxConstraints(minHeight: minWidthAndHeight[OudsTagDimensions.height.name]!, minWidth: minWidthAndHeight[OudsTagDimensions.width.name]!),
              color: tagStatusModifier.getStatusColor(widget.status, widget.appearance, widget.enabled),
              padding: tagSizeModifier.getPadding(widget.size, false),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: tagStyleModifier.buildTagTextStyle(context, appearance: widget.appearance, status: widget.status, size: widget.size!, isEnabled: widget.enabled),
                    ),
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
