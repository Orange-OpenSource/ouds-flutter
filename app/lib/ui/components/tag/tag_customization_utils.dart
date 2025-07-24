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

import 'package:ouds_core/components/tag/internal/ouds_tag_status_modifier.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';

/// Utility class to map tag customization options to corresponding OudsTag attributes.
///
/// This class provides static methods to convert customization enums into the appropriate
/// [OudsTag] properties. It includes methods for determining the tag layout based on the input enum values.
/// These methods help in translating
/// user-selected options into code that is used for tag customization and rendering.

class TagCustomizationUtils {

  /// Maps the layout enum to `OudsTagLayout`.
  static OudsTagLayout getLayout(Object layout) {
    switch (layout) {
      case TagEnumLayout.iconAndText:
        return OudsTagLayout.textAndIcon;
      case TagEnumLayout.bulletAndText:
        return OudsTagLayout.textAndBullet;
      case TagEnumLayout.loaderAndText:
        return OudsTagLayout.textAndLoader;
      default:
        return OudsTagLayout.textOnly;
    }
  }

  static bool isBullet(TagEnumLayout layout){
    if(layout == TagEnumLayout.bulletAndText){
      return true;
    }else {
      return false;
    }
  }

  static bool isLoader(TagEnumLayout layout){
    if(layout == TagEnumLayout.loaderAndText){
      return true;
    }else{
      return false;
    }
  }

  /// Determines the icon to display based on the selected layout.
  static String? getIcon(TagCustomizationState? customizationState) {
    if (customizationState?.selectedLayout == TagEnumLayout.iconAndText
        && (customizationState?.selectedStatus == TagEnumStatus.accent
            || customizationState?.selectedStatus == TagEnumStatus.neutral
            || customizationState?.selectedStatus == TagEnumStatus.disabled)) {
      return AppAssets.icons.icHeartTag;
    }
    return null;
  }

  /// Determines the text to display based on the selected layout.
  static String getText(TagCustomizationState customizationState) {

      return customizationState.labelText;

  }

  /// Maps the hierarchy enum to `OudsTagHierarchy`.
  static OudsTagHierarchy getHierarchy(Object hierarchy) {
    switch (hierarchy) {
      case TagEnumHierarchy.muted:
        return OudsTagHierarchy.muted;
      default:
        return OudsTagHierarchy.emphasized;
    }
  }

  /// Maps the hierarchy enum to `OudsTagStatus`.
  static OudsTagStatus getStatus(Object status) {
    switch (status) {
      case TagEnumStatus.accent:
        return OudsTagStatus.accent;
      case TagEnumStatus.disabled:
        return OudsTagStatus.disabled;
      case TagEnumStatus.info:
        return OudsTagStatus.info;
      case TagEnumStatus.negative:
        return OudsTagStatus.negative;
      case TagEnumStatus.positive:
        return OudsTagStatus.positive;
      case TagEnumStatus.warning:
        return OudsTagStatus.warning;
      default:
        return OudsTagStatus.neutral;
    }
  }

  static OudsTagSize getSize(Object size) {
    switch (size) {
      case TagEnumSize.small:
        return OudsTagSize.small;
    default:
      return OudsTagSize.defaultSize;
    }
  }

  static OudsTagShape getShape(Object size) {
    switch (size) {
      case TagEnumShape.squared:
        return OudsTagShape.squared;
      default:
        return OudsTagShape.rounded;
    }
  }

}
