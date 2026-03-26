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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_border_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_size_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_status_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_text_style_modifier.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';


///The [OudsTagLayout] defines the layout of the tag’s content.
///
/// This enum controls whether the tag displays text, an icon, a bullet or loader
enum OudsTagLayout {
  textOnly,
  textAndBullet,
  textAndIcon,
}

/// Enum representing the state of the tag control.
@Deprecated('Use OudsIconStatus instead. This enum will be removed in a future version.')
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
/// Tag is a UI element that allows to display short info like a label, keyword, or category. Tag helps users quickly find, group, or understand content.
///
/// Tags are highly configurable and can be styled with different statuses,
/// appearances, and layouts to convey specific meanings and fit various visual
/// contexts.
///
/// This version of the tag uses the *text only* layout which is the most used layout.
/// Other layouts are available for this component: *text + icon*, *text + bullet* and *text + loader*.
///
///
/// ### Main Parameters
///
/// - [iconStatus] : The recommended way to control the tag's appearance.
///     This object defines the status (e.g., `Positive`, `Negative`), the
///     visual `appearance` (`emphasized` or `muted`), and a custom `icon` for
///     `Neutral` and `Accent` statuses.
/// - [size] : The size of the tag, [OudsTagSize] such as small or default, to fit various visual needs.
/// - [label] : A text to display inside the tag.
/// - [appearance]: The Tag appearance based on its [OudsTagAppearance].
/// - [layout]: Defines the layout to be used for the tag [OudsTagLayout].
/// - [enabled]: A boolean indicating whether the tag is enabled or disabled.
/// - [loading]: A circular progress indicator displayed in the input or tag area to indicate that tags are being loaded or processed.
///
/// ### Deprecated Parameters
///
/// The [status] and [icon] parameters are deprecated and will be
/// removed in a future version. Please use the [iconStatus] parameter
/// for a more robust and consolidated API.
///
/// ### Usage Example
///
/// ```dart
/// // A "positive" tag with an emphasized appearance and an icon.
/// OudsTag(
///   label: 'Success',
///   layout: OudsTagLayout.textAndIcon,
///   appearance: OudsTagAppearance.emphasized,
///   iconStatus: Positive(),
/// );
///
/// // A "neutral" tag with a custom icon and a muted appearance.
/// OudsTag(
///   label: 'Custom',
///   layout: OudsTagLayout.textAndIcon,
///   appearance: OudsTagAppearance.muted,
///   iconStatus: Neutral(
///     icon: 'assets/icon.svg',
///   ),
/// );
///
/// // A simple tag using the deprecated API.
/// OudsTag(
///   label: 'Legacy Tag',
///   status: OudsTagStatus.accent,
///   size: OudsTagSize.small,
/// );
/// ```
///
class OudsTag extends StatefulWidget {
  final String label;
  final bool enabled;
  @Deprecated('Use iconStatus instead. This parameter will be removed in a future version.')
  final OudsTagStatus? status;
  final OudsTagSize? size;
  final OudsTagAppearance appearance;
  @Deprecated('icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
  final String? icon;
  final OudsTagLayout layout;
  final bool loading;
  final OudsIconStatus? iconStatus;

  const OudsTag(
      {super.key,
        required this.label,
        this.enabled = true,
        @Deprecated('Use iconStatus instead. This parameter will be removed in a future version.')
        this.status,
        this.iconStatus,
        this.appearance = OudsTagAppearance.emphasized,
        this.size = OudsTagSize.defaultSize,
        @Deprecated('icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
        this.icon,
        this.layout = OudsTagLayout.textOnly,
        this.loading = false,
      }) : assert(status == null || iconStatus == null, 'Cannot provide both status and iconStatus.');

  static Widget buildIcon(
      BuildContext context,
      String? assetName,
      OudsTagStatus? tagState,
      OudsIconStatus? iconStatus,
      OudsTagAppearance hierarchy,
      double width, double height, bool isEnabled) {
    final statusModifier = OudsTagStatusModifier(context);

    //get the asset name from iconStatus for neutral and accent status (icon defined by user)
    final assetIconName = statusModifier.getAssetsName(iconStatus);
    final icon = statusModifier.getStatusIcon(tagState, iconStatus);

    return SvgPicture.asset(
      excludeFromSemantics: true,
      icon ?? assetName ?? assetIconName ?? "",
      package: icon != null ? OudsTheme.of(context).packageName : null,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(tagState,iconStatus, hierarchy, isEnabled),
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
    if (widget.loading) {
      return _buildTagTextAndLoader(context, tagStatusModifier, tagSizeModifier, tagStyleModifier);
    }

    return switch (widget.layout) {
      OudsTagLayout.textOnly => _buildTagTextOnly(context, tagStatusModifier, tagSizeModifier, tagStyleModifier),
      OudsTagLayout.textAndBullet => _buildTagTextAndBullet(context, tagStatusModifier, tagSizeModifier, tagStyleModifier),
      OudsTagLayout.textAndIcon => _buildTagTextAndIcon(context, tagStatusModifier, tagSizeModifier, tagStyleModifier),
    };
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
                      Text(widget.label,
                          textAlign: TextAlign.center,
                          style: tagStyleModifier.buildTagTextStyle(
                              appearance: widget.appearance,
                              status: widget.status,
                              iconStatus: widget.iconStatus,
                              size: widget.size!,
                              isLoading: widget.loading,
                              isEnabled: widget.enabled)),
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
            color: tagStatusModifier.getStatusColor(widget.status,widget.iconStatus, widget.appearance, widget.enabled),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: tagSizeModifier.getAssetsPadding(widget.size, OudsTagLayout.textAndIcon),
                  child: OudsTag.buildIcon(
                      context, widget.icon, widget.status,widget.iconStatus,
                      widget.appearance, widthAndHeightAssetsContainer[OudsTagDimensions.width.name]!,
                      widthAndHeightAssetsContainer[OudsTagDimensions.height.name]!, widget.enabled),
                ),
                SizedBox(
                  width: tagSizeModifier.getSizeColumnGap(widget.size),
                ),
                Flexible(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: tagStyleModifier.buildTagTextStyle(
                        appearance: widget.appearance, status: widget.status,
                        iconStatus: widget.iconStatus, size: widget.size!, isEnabled: widget.enabled),
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
            color: tagStatusModifier.getStatusColor(widget.status, widget.iconStatus, widget.appearance, widget.enabled),
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
                    colorFilter: ColorFilter.mode(tagStatusModifier.getStatusIconColor(
                        widget.status, widget.iconStatus,
                        widget.appearance, widget.enabled), BlendMode.srcIn),
                  ),
                ),
                SizedBox(
                  width: widget.size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault,
                ),
                Flexible(
                  child: Text(
                      widget.label, textAlign: TextAlign.center,
                      style: tagStyleModifier.buildTagTextStyle(
                          appearance: widget.appearance, status: widget.status,
                          iconStatus: widget.iconStatus, size: widget.size!,
                          isEnabled: widget.enabled)),
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
              color:  tagStatusModifier.getStatusColor(widget.status,
                  widget.iconStatus, widget.appearance, widget.enabled),
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
                      style: tagStyleModifier.buildTagTextStyle(
                          appearance: widget.appearance, status: widget.status,
                          iconStatus: widget.iconStatus, size: widget.size!, isEnabled: widget.enabled),
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
