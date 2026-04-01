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
/// @nodoc
// deprecation remove : this enum is added only to support the deprecated enum and will be removed after deprecation
extension OudsTagStatusConverter on OudsTagStatus {
  /// Converts this simple status enum to the corresponding [OudsIconStatus] class instance.
  ///
  /// Note: For `Neutral` and `Accent`, this conversion does not carry over any
  /// custom icon information, as the base enum does not store it.
  OudsIconStatus toIconStatus() {
    return switch (this) {
      OudsTagStatus.neutral => Neutral(),
      OudsTagStatus.accent => Accent(),
      OudsTagStatus.positive => Positive(),
      OudsTagStatus.warning => Warning(),
      OudsTagStatus.negative => Negative(),
      OudsTagStatus.info => Info(),
    };
  }
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
/// This widget provides three distinct types of tags, each created using a
/// specific named constructor:
///
/// *   `OudsTag.text`: A simple tag displaying only text.
/// *   `OudsTag.bullet`: A tag that includes a bullet point next to the text.
/// *   `OudsTag.icon`: A tag that displays an icon next to the text.
///
/// This API replaces the previous generic constructor and deprecated status model.
///
/// ---
/// ### Migrating from the Deprecated API
///
/// The generic `OudsTag()` constructor, the [status] parameter of type [OudsTagStatus],
/// and the [icon] parameter are now deprecated and will be removed in a future
/// version. Please migrate to the new named constructors and the [status]
/// parameter of type [OudsIconStatus] for a more robust and consolidated API.
///
/// ---
/// ## Migration overview
///
/// ### 1) Use named constructors
///  Replace the generic `OudsTag()`
///     constructor with `OudsTag.text()`, `OudsTag.icon()`, or `OudsTag.bullet()`
///     based on your needs.
///
/// ### 2) Replace `OudsTagStatus` with `OudsIconStatus`
///  Replace the old `OudsTagStatus` enum
///     with the new `OudsIconStatus` classes (e.g., `OudsTagStatus.positive`
///     becomes `Positive()`).
///
/// ### 3) Remove `icon` parameter
/// The `icon` parameter is deprecated and will be removed.
/// Icon selection must now be driven by `status` (`OudsIconStatus`):
/// - Functional statuses (`Positive`, `Info`, `Warning`, `Negative`) provide fixed icons.
/// - Contextual statuses (`Neutral`, `Accent`) can carry a custom icon asset.
///
/// ---
/// ## Status model
///
/// New `status` type:
/// - [Neutral] (optional custom icon)
/// - [Accent] (optional custom icon)
/// - [Positive] (fixed functional icon)
/// - [Info] (fixed functional icon)
/// - [Warning] (fixed functional icon)
/// - [Negative] (fixed functional icon)
///
/// This unifies:
/// - background color
/// - icon choice
/// - icon/text foreground color
///
/// ---
/// ## Parameters
///
/// - [status] : The recommended way to control the tag's appearance.
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
/// ### Usage Example
///
/// **Migration Example:**
///
/// **Before (Deprecated API):**
/// ```dart
/// // Simple tag
/// OudsTag(
///   label: 'Old Tag',
///   status: OudsTagStatus.accent,
///   size: OudsTagSize.small,
/// );
///
/// // Tag with a custom icon
/// OudsTag(
///   label: 'Custom',
///   layout: OudsTagLayout.textAndIcon,
///   status: OudsTagStatus.neutral,
///   icon: 'assets/custom_icon.svg',
/// );
/// ```
///
/// **After (Modern API):**
/// ```dart
/// // Simple tag
/// OudsTag.text(
///   label: 'New Tag',
///   status: Accent(),
///   size: OudsTagSize.small,
/// );
///
/// // Tag with a custom icon
/// OudsTag.icon(
///   label: 'Custom',
///   status: Neutral(icon: 'assets/custom_icon.svg'),
/// );
///
/// // A Tag with "bullet" type.
/// OudsTag.bullet(
///   label: 'Information',
///   status: Info(),
/// );
/// ```
class OudsTag extends StatefulWidget {
  final String label;
  final bool enabled;
  @Deprecated('Use status of type OudsIconStatus instead. This parameter will be removed in a future version.')
  final OudsTagStatus? _deprecatedStatus;
  final OudsTagSize? size;
  final OudsTagAppearance appearance;
  @Deprecated('icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
  final String? icon;
  final OudsTagLayout layout;
  final bool loading;
  final OudsIconStatus? status;

  /// ⚠️ **DEPRECATED:** Use [OudsTag.text], [OudsTag.icon], or [OudsTag.bullet] constructors instead.
  @Deprecated('Use named constructors for clarity: OudsTag.text() for text only type, OudsTag.icon() for text and icon type, or OudsTag.bullet() for text and bullet type.'
      ' This constructor will be removed in a future version.')
  const OudsTag(
      {super.key,
        required this.label,
        this.enabled = true,
        @Deprecated('Use iconStatus instead. This parameter will be removed in a future version.')
        final OudsTagStatus? status,
        this.appearance = OudsTagAppearance.emphasized,
        this.size = OudsTagSize.defaultSize,
        @Deprecated('icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
        this.icon,
        this.layout = OudsTagLayout.textOnly,
        this.loading = false,
      }) : _deprecatedStatus = status,
        status = null;

  const OudsTag.text(
      {super.key,
        required this.label,
        this.enabled = true,
        required this.status,
        this.appearance = OudsTagAppearance.emphasized,
        this.size = OudsTagSize.defaultSize,
        this.layout = OudsTagLayout.textOnly,
        this.loading = false,
      }) : icon = null,
        _deprecatedStatus = null;

  const OudsTag.bullet(
      {super.key,
        required this.label,
        this.enabled = true,
        required this.status,
        this.appearance = OudsTagAppearance.emphasized,
        this.size = OudsTagSize.defaultSize,
        this.layout = OudsTagLayout.textAndBullet,
        this.loading = false,
      }) :  icon = null,
        _deprecatedStatus = null;

  const OudsTag.icon(
      {super.key,
        required this.label,
        this.enabled = true,
        required this.status,
        this.appearance = OudsTagAppearance.emphasized,
        this.size = OudsTagSize.defaultSize,
        this.layout = OudsTagLayout.textAndIcon,
        this.loading = false,
      }) :  icon = null,
        _deprecatedStatus = null;

  //deprecation remove: The param state will be removed after deprecation
  static Widget buildIcon(
      BuildContext context,
      String? assetName,
      OudsTagStatus? state,
      OudsIconStatus? status,
      OudsTagAppearance hierarchy,
      double width, double height, bool isEnabled) {
    final statusModifier = OudsTagStatusModifier(context);

    //get the asset name from status for neutral and accent status (icon defined by user)
    final assetIconName = statusModifier.getAssetsName(status);
    final icon = statusModifier.getStatusIcon(state, status);

    return SvgPicture.asset(
      excludeFromSemantics: true,
      icon ?? assetName ?? assetIconName ?? "",
      package: icon != null ? OudsTheme.of(context).packageName : null,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(state,status, hierarchy, isEnabled),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsTag> createState() => _OudsTagState();
}

class _OudsTagState extends State<OudsTag> {

  OudsIconStatus? get _effectiveStatus =>
      widget.status ?? widget._deprecatedStatus?.toIconStatus();

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
                              state: widget._deprecatedStatus,
                              status: _effectiveStatus,
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
            color: tagStatusModifier.getStatusColor(widget._deprecatedStatus,_effectiveStatus, widget.appearance, widget.enabled),
            padding: tagSizeModifier.getPadding(widget.size, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: tagSizeModifier.getAssetsPadding(widget.size, OudsTagLayout.textAndIcon),
                  child: OudsTag.buildIcon(
                      context, widget.icon, widget._deprecatedStatus,_effectiveStatus,
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
                        appearance: widget.appearance, state: widget._deprecatedStatus,
                        status: _effectiveStatus, size: widget.size!, isEnabled: widget.enabled),
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
            color: tagStatusModifier.getStatusColor(widget._deprecatedStatus, _effectiveStatus, widget.appearance, widget.enabled),
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
                        widget._deprecatedStatus, _effectiveStatus,
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
                          appearance: widget.appearance, state: widget._deprecatedStatus,
                          status: _effectiveStatus, size: widget.size!,
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
              color:  tagStatusModifier.getStatusColor(widget._deprecatedStatus,
                  _effectiveStatus, widget.appearance, widget.enabled),
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
                          appearance: widget.appearance, state: widget._deprecatedStatus,
                          status: _effectiveStatus, size: widget.size!, isEnabled: widget.enabled),
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
