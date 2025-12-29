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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/navigation_bars/cupertino_navigation_bar/ouds_cupertino_navigation_bar.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

class ActionWidgetButton extends StatefulWidget {
  final String? label;
  final OudsCupertinoNavigationBarActionType actionType;
  final Function? onActionPressed;
  final String? customIcon;
  final bool rtlMode;

  const ActionWidgetButton(
      {super.key,
        this.onActionPressed,
        this.label,
        this.customIcon,
        this.actionType = OudsCupertinoNavigationBarActionType.back,
        this.rtlMode = false
      });

  @override
  _ActionWidgetButtonState createState() => _ActionWidgetButtonState();
}

class _ActionWidgetButtonState extends State<ActionWidgetButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    final color = _isPressed
        ? theme.componentsTokens(context).button.colorBgMinimalPressed
        : Colors.transparent;

    return Container(
      color: color,
      child: InkWell(
        onTap: (){
          widget.onActionPressed;
        },
        onHighlightChanged: (pressed) {
          setState(() {
            _isPressed = pressed;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildActionWidgets(theme),
        ),
      ),
    );
  }

  List<Widget> buildActionWidgets(OudsThemeContract theme) {
    List<Widget> widgets = [];

    if (widget.actionType == OudsCupertinoNavigationBarActionType.back) {
      widgets.add(
        SvgPicture.asset(
          widget.rtlMode
              ? AppAssets.icons.componentLinkNext
              : AppAssets.icons.componentLinkPrevious,
          package: theme.packageName,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            theme.componentsTokens(context).link.colorChevronPressed,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    if (widget.actionType == OudsCupertinoNavigationBarActionType.icon) {
      widgets.add(
        SvgPicture.asset(
          widget.customIcon ?? "",
          package: theme.packageName,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            theme.componentsTokens(context).link.colorChevronPressed,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    if (widget.actionType == OudsCupertinoNavigationBarActionType.back ||
        widget.actionType == OudsCupertinoNavigationBarActionType.text) {
      widgets.add(
        Padding(
            padding: EdgeInsetsGeometry.only(left: 5, right: 5),
            child: InkWell(
              onTap: (){
                widget.onActionPressed?.call();
              },
              child: Text(
                widget.label ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: theme.colorScheme(context).actionSelected),
              ),
            ),
        ),
      );
    }

    return widgets;
  }
}
