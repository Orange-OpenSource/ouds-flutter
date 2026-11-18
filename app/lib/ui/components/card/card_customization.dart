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

  /// Notifies dependents when the card customization state changes.
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
  double progress = 0.65;

  /// Updates the card's visual style.
  void updateStyle(CardStyleEnum value) {
    setState(() => style = value);
  }

  /// Updates whether the card is enabled.
  void updateEnabled(bool value) {
    setState(() => enabled = value);
  }

  /// Updates whether the card uses a colored background.
  void updateColoredBackground(bool value) {
    setState(() => coloredBackground = value);
  }

  /// Updates whether the filled card displays a divider.
  void updateDivider(bool value) {
    setState(() => divider = value);
  }

  /// Updates whether the card displays skeleton content.
  void updateSkeleton(bool value) {
    setState(() => skeleton = value);
  }

  /// Updates whether the action card displays its loading indicator.
  void updateLoading(bool value) {
    setState(() => loading = value);
  }

  /// Updates the progress value used by the card loader.
  void updateProgress(double value) {
    setState(() => progress = value);
  }

  /// Updates the example content displayed inside the card.
  void updateContent(CardContentEnum value) {
    setState(() => content = value);
  }

  /// Provides the customization state to descendant widgets.
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

  /// Returns the card styles available for selection.
  List<CardStyleEnum> get list => _style;

  /// Replaces the available card styles and notifies the owning state.
  set list(List<CardStyleEnum> newList) {
    _setStyle(() {
      _style = newList;
    });
  }

  /// Returns the currently selected card style.
  CardStyleEnum get selected => _selectedType;

  /// Updates the selected card style and notifies the owning state.
  set selected(CardStyleEnum newValue) {
    _setStyle(() {
      _selectedType = newValue;
    });
  }
}