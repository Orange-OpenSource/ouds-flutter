
import 'package:flutter/foundation.dart';

/// Defines static constants used for the customize Sheet Bottom component.
///
/// This class centralizes configuration values such as animation durations,
/// icon sizes, and layout dimensions used by the bottom sheet.
///
/// It also provides platform-specific values, such as different collapsed
/// heights for Android and other platforms.
class ConstantSheetBottom{
  static double chevronTurns = 0.5;
  static int animatedContainerDuration = 11150;
  static int animatedRotationDuration = 300;
  static double sheetRadius = 2.5;
  static double expandIconSize = 31;

  static const double _collapsedHeightAndroid = 80;
  static const double _collapsedHeightDefault = 91;
  static double collapsedHeight = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? _collapsedHeightAndroid
      : _collapsedHeightDefault;

}