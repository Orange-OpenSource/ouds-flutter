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
import 'package:ouds_core/components/control/internal/controller/ouds_interaction_state_controller.dart';

enum InteractionAspect { hover, pressed, enabled }

/// A model for sharing interaction states between parent and child widgets
/// in the OUDS (Orange Unified Design System) framework.
///
/// This class extends [InheritedModel] to provide access to the interaction
/// states (hover and pressed) managed by the [OudsInteractionStateController].
///
/// ## Usage
///
/// To use this model, wrap your widget tree with [OudsInheritedInteractionModel]
/// and provide an instance of [OudsInteractionStateController]. Child widgets can
/// then access the interaction states using the static `of` method.
///
/// Example:
/// ```dart
/// OudsInheritedInteractionModel(
///   state: InteractionStateController(),
///   child: YourWidget(),
/// )
/// ```
///
/// Child widgets can access the interaction states as follows:
/// ```dart
/// final interactionModel = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
/// if (interactionModel != null) {
///   // Access the hover state
///   bool isHovered = interactionModel.state.isHovered;
/// }
/// ```
///
/// ## Parameters
/// - `state`: An instance of [OudsInteractionStateController] that holds the current
///   interaction states.
/// - `child`: The child widget that will have access to the interaction states.
///
/// ## Methods
/// - `of(BuildContext context, InteractionAspect aspect)`: A static method to
///   retrieve the nearest [OudsInheritedInteractionModel] instance in the widget
///   tree for the specified interaction aspect.
///
/// ## Update Notifications
/// The model will notify its dependents when the interaction states change,
/// allowing for responsive UI updates based on user interactions.
class OudsInheritedInteractionModel extends InheritedModel<InteractionAspect> {
  final OudsInteractionStateController state;

  const OudsInheritedInteractionModel({
    super.key,
    required this.state,
    required super.child,
  });

  static OudsInheritedInteractionModel? of(BuildContext context, InteractionAspect aspect) {
    return InheritedModel.inheritFrom<OudsInheritedInteractionModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(OudsInheritedInteractionModel oldWidget) {
    return state != oldWidget.state;
  }

  @override
  bool updateShouldNotifyDependent(OudsInheritedInteractionModel oldWidget, Set<InteractionAspect> aspects) {
    if (aspects.contains(InteractionAspect.hover) && state.isHovered && state.isEnabled != oldWidget.state.isHovered) {
      return true;
    }
    if (aspects.contains(InteractionAspect.pressed) && state.isPressed && state.isEnabled != oldWidget.state.isPressed) {
      return true;
    }
    return false;
  }
}
