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

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_enum.dart';

class _CardCustomization extends InheritedWidget {
  const _CardCustomization({required super.child, required this.data});

  final CardCustomizationState data;

  @override
  bool updateShouldNotify(_CardCustomization oldWidget) => true;
}

class CardCustomization extends StatefulWidget {
  const CardCustomization({super.key, required this.child});

  final Widget child;

  @override
  CardCustomizationState createState() => CardCustomizationState();

  static CardCustomizationState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CardCustomization>()
        ?.data;
  }
}

class CardCustomizationState extends State<CardCustomization> {
  CardStyleEnum style = CardStyleEnum.filled;
  CardContentEnum content = CardContentEnum.useCase;
  bool enabled = true;
  bool coloredBackground = true;
  bool divider = false;
  bool skeleton = false;
  bool loading = false;
  bool determinate = true;
  bool showVisualAction = true;
  double progress = 0.65;

  void updateStyle(CardStyleEnum value) {
    setState(() => style = value);
  }

  void updateEnabled(bool value) {
    setState(() => enabled = value);
  }

  void updateColoredBackground(bool value) {
    setState(() => coloredBackground = value);
  }

  void updateDivider(bool value) {
    setState(() => divider = value);
  }

  void updateSkeleton(bool value) {
    setState(() => skeleton = value);
  }

  void updateLoading(bool value) {
    setState(() => loading = value);
  }

  void updateDeterminate(bool value) {
    setState(() => determinate = value);
  }

  void updateProgress(double value) {
    setState(() => progress = value);
  }

  void updateContent(CardContentEnum value) {
    setState(() => content = value);
  }

  @override
  Widget build(BuildContext context) {
    return _CardCustomization(data: this, child: widget.child);
  }
}

///  card style state Management
class CardStyleState {
  CardStyleState(this._setStyle);

  final void Function(void Function()) _setStyle;

  List<CardStyleEnum> _style = [
    CardStyleEnum.filled,
    CardStyleEnum.outlined,
    CardStyleEnum.elevated,
  ];
  CardStyleEnum _selectedType = CardStyleEnum.filled;

  List<CardStyleEnum> get list => _style;
  set list(List<CardStyleEnum> newList) {
    _setStyle(() {
      _style = newList;
    });
  }

  CardStyleEnum get selected => _selectedType;
  set selected(CardStyleEnum newValue) {
    _setStyle(() {
      _selectedType = newValue;
    });
  }
}