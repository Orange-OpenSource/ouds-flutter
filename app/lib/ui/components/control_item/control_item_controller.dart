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

import 'package:get/get.dart';
import 'package:ouds_flutter_demo/ui/components/control_item/control_item_enum.dart';

/// A GetX controller that stores and provides access to a [ControlItemType].
///
/// This controller is typically registered in the widget tree using [Get.put]
/// and allows other components or state classes (e.g., InvertedState) to retrieve
/// the current control item type without explicitly passing it around.
///
/// Example:
/// ```dart
/// Get.put(ControlItemController(controlItemType: ControlItemType.checkbox));
/// ```
///
/// Then later:
/// ```dart
/// final controlItemType = Get.find<ControlItemController>().controlItemType;
/// ```
class ControlItemController extends GetxController {
  final ControlItemType controlItemType;

  ControlItemController({required this.controlItemType});
}
