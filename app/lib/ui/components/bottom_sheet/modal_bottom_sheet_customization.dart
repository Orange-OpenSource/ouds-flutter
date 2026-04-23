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
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree.
class _ModalBottomSheetCustomization extends InheritedWidget {
  const _ModalBottomSheetCustomization({
    required super.child,
    required this.data,
  });

  final ModalBottomSheetCustomizationState data;

  @override
  bool updateShouldNotify(_ModalBottomSheetCustomization old) => true;
}

/// Main widget for modal bottom sheet customization.
///
/// Mirrors `ModalBottomSheetDemoState` from the Android app.
class ModalBottomSheetCustomization extends StatefulWidget {
  const ModalBottomSheetCustomization({super.key, required this.child});

  final Widget child;

  @override
  ModalBottomSheetCustomizationState createState() =>
      ModalBottomSheetCustomizationState();

  static ModalBottomSheetCustomizationState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ModalBottomSheetCustomization>()
        ?.data;
  }
}

/// Customization state for the modal bottom sheet demo.
class ModalBottomSheetCustomizationState
    extends CustomizationWidgetState<ModalBottomSheetCustomization> {
  late final _DragHandleState _dragHandleState;
  late final _SheetGesturesEnabledState _sheetGesturesEnabledState;

  @override
  void initState() {
    super.initState();
    _dragHandleState = _DragHandleState(setState);
    _sheetGesturesEnabledState = _SheetGesturesEnabledState(setState);
  }

  /// Whether the drag-handle pill is shown. Corresponds to Android `dragHandle`.
  bool get hasDragHandle => _dragHandleState.value;
  set hasDragHandle(bool value) => _dragHandleState.value = value;

  /// Whether sheet gestures (swipe-to-dismiss) are enabled.
  /// Corresponds to Android `sheetGesturesEnabled`.
  bool get hasSheetGesturesEnabled => _sheetGesturesEnabledState.value;
  set hasSheetGesturesEnabled(bool value) =>
      _sheetGesturesEnabledState.value = value;

  @override
  Widget build(BuildContext context) {
    return _ModalBottomSheetCustomization(data: this, child: widget.child);
  }
}

class _DragHandleState {
  _DragHandleState(this._setState);
  final void Function(void Function()) _setState;
  bool _value = true;
  bool get value => _value;
  set value(bool v) => _setState(() => _value = v);
}

class _SheetGesturesEnabledState {
  _SheetGesturesEnabledState(this._setState);
  final void Function(void Function()) _setState;
  bool _value = true;
  bool get value => _value;
  set value(bool v) => _setState(() => _value = v);
}
