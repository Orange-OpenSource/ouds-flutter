//
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
import 'package:ouds_core/components/typography/ouds_typography.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _TypographyCustomization extends InheritedWidget {
  const _TypographyCustomization({required super.child, required this.data});

  final TypographyCustomizationState data;

  @override
  bool updateShouldNotify(_TypographyCustomization oldWidget) => true;
}

/// Main Widget class for typography customization.
///
/// [variant] determines which size enum is exposed through [TypographyCustomizationState.sizeState].
class TypographyCustomization extends StatefulWidget {
  const TypographyCustomization({
    super.key,
    required this.child,
    required this.variant,
    required this.initialText,
  });

  final Widget child;
  final TypographyVariant variant;
  final String initialText;

  @override
  TypographyCustomizationState createState() => TypographyCustomizationState();

  static TypographyCustomizationState? of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_TypographyCustomization>())
        ?.data;
  }
}

/// Typography customization state management
class TypographyCustomizationState
    extends CustomizationWidgetState<TypographyCustomization> {
  late final SizeState sizeState;
  late final LabelTextState labelTextState;
  late final MarkerState markerState;
  late final ColorState colorState;
  late final WeightState weightState;
  late final AnnotatedTextState annotatedTextState;

  @override
  void initState() {
    super.initState();
    sizeState = SizeState(
      setState,
      sizesFor(widget.variant),
      defaultSizeFor(widget.variant),
    );
    labelTextState = LabelTextState(setState, widget.initialText);
    markerState = MarkerState(setState);
    colorState = ColorState(setState);
    weightState = WeightState(setState);
    annotatedTextState = AnnotatedTextState(setState);
  }

  // Proxy getters and setters to expose state values directly
  Object get selectedSize => sizeState.selected;
  set selectedSize(Object value) => sizeState.selected = value;

  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  bool get hasMarker => markerState.value;
  set hasMarker(bool value) => markerState.value = value;

  OudsTextWeight get selectedWeight => weightState.selected;
  set selectedWeight(OudsTextWeight value) => weightState.selected = value;

  /// Whether the demo should showcase the `.rich` constructor with
  /// [buildOudsAnnotatedText] to color part of the sample text. Available for every variant.
  bool get hasAnnotatedText => annotatedTextState.value;
  set hasAnnotatedText(bool value) => annotatedTextState.value = value;

  @override
  Widget build(BuildContext context) {
    return _TypographyCustomization(data: this, child: widget.child);
  }
}

/// Size State Management
class SizeState {
  SizeState(this._setState, this.list, Object initialSize)
    : _selected = initialSize;

  final void Function(void Function()) _setState;
  final List<Object> list;
  Object _selected;

  Object get selected => _selected;
  set selected(Object newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// LabelText State Management
class LabelTextState {
  LabelTextState(this._setState, String initialValue)
    : _labelTextValue = initialValue;

  final void Function(void Function()) _setState;
  String _labelTextValue;

  String get value => _labelTextValue;
  set value(String newValue) {
    _setState(() {
      _labelTextValue = newValue;
    });
  }
}

/// Marker State Management, used by [TypographyVariant.heading] to toggle the marker displayed
/// under the text when [OudsHeadingTextSize.large] is selected.
class MarkerState {
  MarkerState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasMarker = true;

  bool get value => _hasMarker;
  set value(bool newValue) {
    _setState(() {
      _hasMarker = newValue;
    });
  }
}

/// Color State Management
class ColorState {
  ColorState(this._setState);

  final void Function(void Function()) _setState;
  TypographyEnumColor _selected = TypographyEnumColor.defaultColor;

  TypographyEnumColor get selected => _selected;
  set selected(TypographyEnumColor newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// Weight State Management, used by [TypographyVariant.body] and [TypographyVariant.label] to
/// select the default/moderate/strong emphasis level.
class WeightState {
  WeightState(this._setState);

  final void Function(void Function()) _setState;
  OudsTextWeight _selected = OudsTextWeight.defaultWeight;

  OudsTextWeight get selected => _selected;
  set selected(OudsTextWeight newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}

/// Annotated text example State Management, used to toggle a preview built with a variant's
/// `.rich` constructor and [buildOudsAnnotatedText].
class AnnotatedTextState {
  AnnotatedTextState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasAnnotatedText = false;

  bool get value => _hasAnnotatedText;
  set value(bool newValue) {
    _setState(() {
      _hasAnnotatedText = newValue;
    });
  }
}
