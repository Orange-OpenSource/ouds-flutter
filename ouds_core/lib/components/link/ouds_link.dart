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
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///The [OudsLinkLayout] defines the layout of the link’s content.
///
/// This enum controls whether the link displays text, text and icon, back or next
enum OudsLinkLayout {
  textOnly,
  textAndIcon,
  back,
  next;
}

/// Enum representing the state of the link.
enum OudsLinkStatus {
  enabled,
  hover,
  pressed,
  disabled,
  focus
}

/// The [OudsLinkSize] defines the link's visual size.
enum OudsLinkSize {
  defaultSize,
  small;
}

// TODO: Add documentation URL once it is available
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
/// ## You can use [OudsLink] like this :
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
  });

  static Widget buildIcon(BuildContext context, String? assetName, OudsLinkLayout layoutState, OudsLinkStatus linkStatus, double width, double height) {
    final statusModifier = OudsTagStatusModifier(context);

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName ?? statusModifier.getStatusIcon(controlItemState)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(controlItemState, hierarchy),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  State<OudsLink> createState() => _OudsLinkState();
}

class _OudsLinkState extends State<OudsLink> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Semantics(
      child: Material(
        color: Colors.transparent,
        //child: _buildLink(context, tagStatusModifier, tagSizeModifier, tagStyleModifier),
      ),
    );
  }


 }
