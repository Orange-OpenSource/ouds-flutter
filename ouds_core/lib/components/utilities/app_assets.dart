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

/// Centralized access point for all asset categories used in the OUDS Flutter library.
class AppAssets {
  static final images = _Images();
  static final icons = _Icons();
  static final fonts = _Fonts();
  static final animations = _Animations();
}

class _Images {
  _Images();
}

class _Icons {
  _Icons();

  final String componentAlertTickConfirmationFill =
      'assets/component/alert/tick-confirmation-fill.svg';
  final String componentAlertImportantFill =
      'assets/component/alert/important-fill.svg';
  final String componentAlertInformationFill =
      'assets/component/alert/info-fill.svg';
  final String componentAlertWarning = 'assets/component/alert/warning.svg';
  final String componentAlertWarningExternalShape =
      'assets/component/alert/warning-external-shape.svg';
  final String componentAlertWarningInternalShape =
      'assets/component/alert/warning-internal-shape.svg';
  final String componentCheckboxSelected =
      'assets/component/checkbox/checkbox-selected.svg';
  final String componentCheckboxUndetermined =
      'assets/component/checkbox/checkbox-undetermined.svg';
  final String componentRadioButtonSelected =
      'assets/component/radio-button/radio-button-selected.svg';
  final String componentSwitchChecked =
      'assets/component/switch/selected-switch.svg';
  final String componentChipTick = 'assets/component/chip/tick.svg';
  final String componentLinkNext = 'assets/component/link/next.svg';
  final String componentLinkPrevious = 'assets/component/link/previous.svg';
  final String componentLinkExpandedTrue =
      'assets/component/link/expanded-true.svg';
  final String componentLinkExpandedFalse =
      'assets/component/link/expanded-false.svg';
  final String componentTagClose = 'assets/component/tag/close.svg';
  final String componentButtonPrevious = 'assets/component/button/previous.svg';
  final String componentButtonExpurge = 'assets/component/button/expurge.svg';
  final String componentBulletListBulletLevelZero =
      'assets/component/bullet-list/bullet-level-0.svg';

  final String accessibilityAccessibilityVision =
      'assets/communication/accessibility/accessibility-vision.svg';
  final String communicationSecurityAndSafetyLock =
      'assets/communication/security-and-safety/lock.svg';

  final String settingsAndToolsHide =
      'assets/functional/settings-and-tools/hide.svg';
  final String functionalSocialAndEngagementHeartEmpty =
      'assets/functional/social-and-engagement/heart-empty.svg';
  final String functionalNavigationMenu =
      'assets/functional/navigation/menu.svg';
}

class _Fonts {
  _Fonts();
}

class _Animations {
  _Animations();
}
