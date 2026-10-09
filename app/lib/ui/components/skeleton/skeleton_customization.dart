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
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _SkeletonCustomization extends InheritedWidget {
  const _SkeletonCustomization({required super.child, required this.data});

  final SkeletonCustomizationState data;

  @override
  bool updateShouldNotify(_SkeletonCustomization oldWidget) => true;
}

/// Main Widget class for skeleton customization
class SkeletonCustomization extends StatefulWidget {
  const SkeletonCustomization({super.key, required this.child});

  final Widget child;

  @override
  SkeletonCustomizationState createState() => SkeletonCustomizationState();

  static SkeletonCustomizationState? of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_SkeletonCustomization>())
        ?.data;
  }
}

/// Skeleton customization state management
class SkeletonCustomizationState
    extends CustomizationWidgetState<SkeletonCustomization> {
  late final SkeletonAnimatedState animatedState;
  late final SkeletonSecurityMarginState hasSecurityMarginState;

  @override
  void initState() {
    super.initState();
    animatedState = SkeletonAnimatedState(setState);
    hasSecurityMarginState = SkeletonSecurityMarginState(setState);
  }

  bool get hasAnimated => animatedState.value;
  set hasAnimated(bool value) => animatedState.value = value;

  bool get hasSecurityMargin => hasSecurityMarginState.value;
  set hasSecurityMargin(bool value) => hasSecurityMarginState.value = value;

  @override
  Widget build(BuildContext context) {
    return _SkeletonCustomization(data: this, child: widget.child);
  }
}

/// Animated State Management
class SkeletonAnimatedState {
  SkeletonAnimatedState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasAnimated = true;

  bool get value => _hasAnimated;
  set value(bool newValue) {
    _setState(() {
      _hasAnimated = newValue;
    });
  }
}

/// Security margin State Management
class SkeletonSecurityMarginState {
  SkeletonSecurityMarginState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasSecurityMargin = false;

  bool get value => _hasSecurityMargin;
  set value(bool newValue) {
    _setState(() {
      _hasSecurityMargin = newValue;
    });
  }
}
