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

///
/// The [OudsInteractionStateController] class is a controller that manages the interaction states
/// of UI components in a Flutter application. It uses the GetX package for state management.
///
/// This controller is designed to allow a parent item to communicate interaction states to its child components.
/// It holds two observable properties:
/// - [isPressed]: Indicates whether a UI component is currently pressed.
/// - [isHovered]: Indicates whether a UI component is currently being hovered over.
///
/// The controller provides methods to update these states:
/// - [setPressed]: Updates the [isPressed] state.
/// - [setHovered]: Updates the [isHovered] state.
///
/// This class is useful for managing user interactions and providing visual feedback
/// in response to user actions, such as button presses or mouse hovers, enabling the parent
/// item to effectively inform its child components about the current interaction state.
class OudsInteractionStateController extends ChangeNotifier {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get isHovered => _isHovered;
  bool get isPressed => _isPressed;

  void setHovered(bool value) {
    if (_isHovered != value) {
      _isHovered = value;
      notifyListeners();
    }
  }

  void setPressed(bool value) {
    if (_isPressed != value) {
      _isPressed = value;
      notifyListeners();
    }
  }
}
