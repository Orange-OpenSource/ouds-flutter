/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// {@category List item}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading_widget.dart';
import 'package:ouds_core/components/list_item/ouds_list_item_data.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing_widget.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsStaticListItem extends StatelessWidget {
  final OudsListItemData data;
  final Widget? slot;
  final OudsListItemLeading? leading;
  final OudsListItemTrailing? trailing;
  final bool divider;

  const OudsStaticListItem({
    super.key,
    this.slot,
    required this.data,
    this.leading,
    this.trailing,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    final oudsTheme = OudsTheme.of(context);
    final typographyTokens = oudsTheme.typographyTokens;
    final colorTokens = oudsTheme.colorScheme(context);
    final controlItemTokens = oudsTheme.componentsTokens(context).controlItem;
    final sizeToken = oudsTheme.sizeScheme(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: controlItemTokens.spacePaddingInline,
            vertical: controlItemTokens.spacePaddingBlockDefault,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading
              if (leading != null) ...[
                OudsListItemLeadingWidget(leading: leading!),
                SizedBox(width: controlItemTokens.spaceColumnGap),
              ],
              // Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.overline != null) ...[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: sizeToken.maxWidthLabelSmall,
                        ),
                        child: Text(
                          data.overline!,
                          style: typographyTokens
                              .typeLabelModerateSmall(context)
                              .copyWith(color: colorTokens.contentMuted),
                        ),
                      ),
                    ],
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: sizeToken.maxWidthLabelLarge,
                      ),
                      child: Text(
                        data.label!,
                        style: typographyTokens
                            .typeLabelDefaultLarge(context)
                            .copyWith(color: colorTokens.contentDefault),
                      ),
                    ),
                    if (data.extraLabel != null) ...[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: sizeToken.maxWidthLabelMedium,
                        ),
                        child: Text(
                          data.extraLabel!,
                          style: typographyTokens
                              .typeLabelStrongMedium(context)
                              .copyWith(color: colorTokens.contentDefault),
                        ),
                      ),
                    ],
                    if (data.description != null) ...[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: sizeToken.maxWidthLabelMedium,
                        ),
                        child: Text(
                          data.description!,
                          style: typographyTokens
                              .typeLabelDefaultMedium(context)
                              .copyWith(color: colorTokens.contentMuted),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Trailing
              if (trailing != null) ...[
                SizedBox(width: controlItemTokens.spaceColumnGap),
                OudsListItemTrailingWidget(trailing: trailing!),
              ],
            ],
          ),
        ),
        if (divider == true) ...[OudsDivider.horizontal()],
      ],
    );
  }
}
