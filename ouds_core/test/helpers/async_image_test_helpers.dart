import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Test-only image providers exercising loading, success and error states,
// shared by the list item and card item test suites.
// ---------------------------------------------------------------------------

/// Builds a tiny opaque [ui.Image] without going through the platform image
/// decoder (which is unavailable in headless test environments).
ui.Image createTestImageSync() {
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawRect(
    const Rect.fromLTWH(0, 0, 8, 8),
    Paint()..color = const Color(0xFFFF00FF),
  );
  return recorder.endRecording().toImageSync(8, 8);
}

class TestImageProvider extends ImageProvider<TestImageProvider> {
  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) =>
      Future.value(this);

  @override
  bool operator ==(Object other) => other.runtimeType == runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class NeverCompletingImageProvider extends TestImageProvider {
  NeverCompletingImageProvider();

  @override
  ImageStreamCompleter loadImage(
    TestImageProvider key,
    ImageDecoderCallback decode,
  ) => MultiFrameImageStreamCompleter(
    codec: Completer<ui.Codec>().future,
    scale: 1.0,
  );
}

class SucceedingImageProvider extends TestImageProvider {
  SucceedingImageProvider(this.image);

  final ui.Image image;

  @override
  ImageStreamCompleter loadImage(
    TestImageProvider key,
    ImageDecoderCallback decode,
  ) => OneFrameImageStreamCompleter(Future.value(ImageInfo(image: image)));
}

class FailingImageProvider extends TestImageProvider {
  FailingImageProvider();

  @override
  ImageStreamCompleter loadImage(
    TestImageProvider key,
    ImageDecoderCallback decode,
  ) => OneFrameImageStreamCompleter(
    Future.error(Exception('image load failed'), StackTrace.empty),
  );
}
