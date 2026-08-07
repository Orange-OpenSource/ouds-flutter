import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/link/link_enum.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _CircularProgressIndicatorCustomization extends InheritedWidget {
  const _CircularProgressIndicatorCustomization({
    required super.child,
    required this.data,
  });

  final ProgressIndicatorCustomizationState data;

  @override
  bool updateShouldNotify(_CircularProgressIndicatorCustomization oldWidget) =>
      true;
}

/// Main Widget class for circular progress indicator customization
class ProgressIndicatorCustomization extends StatefulWidget {
  const ProgressIndicatorCustomization({super.key, required this.child});

  final Widget child;

  @override
  ProgressIndicatorCustomizationState createState() =>
      ProgressIndicatorCustomizationState();

  static ProgressIndicatorCustomizationState? of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<
              _CircularProgressIndicatorCustomization
            >())
        ?.data;
  }
}

/// tag customization state management
class ProgressIndicatorCustomizationState
    extends CustomizationWidgetState<ProgressIndicatorCustomization> {
  late final ProgressState progressState;
  late final SizeState sizeState;
  late final StatusState statusState;
  late final TrackState trackState;
  late final AnimatedState animatedState;
  late final TypeState typeState;
  late final GapSizeState gapSizeState;
  late final StopIndicatorState stopIndicatorState;
  late final HelperTextState helperTextState;
  late final AlignmentState alignmentState;
  late final PercentageState percentageState;
  late final SpaceBeforeState spaceBeforeState;

  @override
  void initState() {
    super.initState();
    progressState = ProgressState(setState);
    sizeState = SizeState(setState);
    statusState = StatusState(setState);
    trackState = TrackState(setState);
    animatedState = AnimatedState(setState);
    typeState = TypeState(setState);
    gapSizeState = GapSizeState(setState);
    stopIndicatorState = StopIndicatorState(setState);
    helperTextState = HelperTextState(setState);
    alignmentState = AlignmentState(setState);
    percentageState = PercentageState(setState);
    spaceBeforeState = SpaceBeforeState(setState);
  }

  String get progress => progressState.value;
  set progress(String value) => progressState.value = value;

  LinkEnumSize get selectedSize => sizeState.selected;
  set selectedSize(LinkEnumSize value) => sizeState.selected = value;

  // Proxy getters and setters to expose state values directly
  StatusEnum get selectedStatus => statusState.selectedStatus;
  set selectedStatus(StatusEnum value) => statusState.selectedStatus = value;

  int get selectedIndex => statusState.index;
  set selectedIndex(int value) => statusState.index = value;

  bool get hasTrack => trackState.value;
  set hasTrack(bool value) => trackState.value = value;

  bool get hasAnimation => animatedState.value;
  set hasAnimation(bool value) => animatedState.value = value;

  ProgressIndicatorEnumType get selectedType => typeState.selected;
  set selectedType(ProgressIndicatorEnumType value) =>
      typeState.selected = value;

  ProgressIndicatorGapSizeEnum get selectedGapSize => gapSizeState.selected;
  set selectedGapSize(ProgressIndicatorGapSizeEnum value) =>
      gapSizeState.selected = value;

  //needed for linser progress indicator

  bool get hasStopIndicator => stopIndicatorState.value;
  set hasStopIndicator(bool value) => stopIndicatorState.value = value;

  String get helperText => helperTextState.value;
  set helperText(String value) => helperTextState.value = value;

  bool get hasHelperText => helperTextState.hasValue;
  set hasHelperText(bool value) => helperTextState.hasValue = value;

  ProgressIndicatorHelperTextAlignmentEnum get selectedAlignment =>
      alignmentState.selected;
  set selectedAlignment(ProgressIndicatorHelperTextAlignmentEnum value) =>
      alignmentState.selected = value;

  bool get hasPercentage => percentageState.value;
  set hasPercentage(bool value) => percentageState.value = value;

  bool get hasSpaceBefore => spaceBeforeState.value;
  set hasSpaceBefore(bool value) => spaceBeforeState.value = value;

  @override
  Widget build(BuildContext context) {
    return _CircularProgressIndicatorCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// progress value State Management
class ProgressState {
  ProgressState(this._setState);

  final void Function(void Function()) _setState;
  String _progressValue = "0.75";

  String get value => _progressValue;
  set value(String newValue) {
    _setState(() {
      _progressValue = newValue;
    });
  }
}

/// Status State Management
class StatusState {
  StatusState(this._setState);

  final void Function(void Function()) _setState;

  List<StatusEnum> _status = [
    StatusEnum.accent,
    StatusEnum.info,
    StatusEnum.negative,
    StatusEnum.neutral,
    StatusEnum.positive,
    StatusEnum.warning,
  ];

  StatusEnum _selectedStatus = StatusEnum.neutral;
  int _selectedIndex = 3;

  List<StatusEnum> get list => _status;
  set list(List<StatusEnum> newList) {
    _setState(() {
      _status = newList;
    });
  }

  StatusEnum get selectedStatus => _selectedStatus;
  set selectedStatus(StatusEnum newValue) {
    _setState(() {
      _selectedStatus = newValue;
    });
  }

  int get index => _selectedIndex;
  set index(int newValue) {
    _setState(() {
      _selectedIndex = newValue;
    });
  }
}

/// Track State Management
class TrackState {
  TrackState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasTrackState = true;

  bool get value => _hasTrackState;
  set value(bool newValue) {
    _setState(() {
      _hasTrackState = newValue;
    });
  }
}

/// Animated State Management
class AnimatedState {
  AnimatedState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasAnimatedState = true;

  bool get value => _hasAnimatedState;
  set value(bool newValue) {
    _setState(() {
      _hasAnimatedState = newValue;
    });
  }
}

/// Size State Management
class SizeState {
  SizeState(this._setState);

  final void Function(void Function()) _setState;

  List<LinkEnumSize> _sizeList = [LinkEnumSize.defaultSize, LinkEnumSize.small];
  LinkEnumSize _selectedSize = LinkEnumSize.defaultSize;

  List<LinkEnumSize> get list => _sizeList;
  set list(List<LinkEnumSize> newList) {
    _setState(() {
      _sizeList = newList;
    });
  }

  LinkEnumSize get selected => _selectedSize;
  set selected(LinkEnumSize newValue) {
    _setState(() {
      _selectedSize = newValue;
    });
  }
}

/// Type State Management
class TypeState {
  TypeState(this._setState);

  final void Function(void Function()) _setState;

  List<ProgressIndicatorEnumType> _typeList = [
    ProgressIndicatorEnumType.determinate,
    ProgressIndicatorEnumType.indeterminate,
  ];
  ProgressIndicatorEnumType _selectedType =
      ProgressIndicatorEnumType.determinate;

  List<ProgressIndicatorEnumType> get list => _typeList;
  set list(List<ProgressIndicatorEnumType> newList) {
    _setState(() {
      _typeList = newList;
    });
  }

  ProgressIndicatorEnumType get selected => _selectedType;
  set selected(ProgressIndicatorEnumType newValue) {
    _setState(() {
      _selectedType = newValue;
    });
  }
}

/// Gap size State Management
class GapSizeState {
  GapSizeState(this._setState);

  final void Function(void Function()) _setState;

  List<ProgressIndicatorGapSizeEnum> _gapSizeList = [
    ProgressIndicatorGapSizeEnum.defaultSize,
    ProgressIndicatorGapSizeEnum.small,
  ];
  ProgressIndicatorGapSizeEnum _selectedGapSize =
      ProgressIndicatorGapSizeEnum.defaultSize;

  List<ProgressIndicatorGapSizeEnum> get list => _gapSizeList;
  set list(List<ProgressIndicatorGapSizeEnum> newList) {
    _setState(() {
      _gapSizeList = newList;
    });
  }

  ProgressIndicatorGapSizeEnum get selected => _selectedGapSize;
  set selected(ProgressIndicatorGapSizeEnum newValue) {
    _setState(() {
      _selectedGapSize = newValue;
    });
  }
}

/// Stop indicator State Management
class StopIndicatorState {
  StopIndicatorState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasStopIndicatorState = false;

  bool get value => _hasStopIndicatorState;
  set value(bool newValue) {
    _setState(() {
      _hasStopIndicatorState = newValue;
    });
  }
}

/// Percentage State Management
class PercentageState {
  PercentageState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasPercentageState = true;

  bool get value => _hasPercentageState;
  set value(bool newValue) {
    _setState(() {
      _hasPercentageState = newValue;
    });
  }
}

/// Percentage State Management
class SpaceBeforeState {
  SpaceBeforeState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasSpaceBeforeState = true;

  bool get value => _hasSpaceBeforeState;
  set value(bool newValue) {
    _setState(() {
      _hasSpaceBeforeState = newValue;
    });
  }
}

/// Helper text State Management
class HelperTextState {
  HelperTextState(this._setState);

  final void Function(void Function()) _setState;
  String _helperTextValue = "Helper text";

  String get value => _helperTextValue;
  set value(String newValue) {
    _setState(() {
      _helperTextValue = newValue;
    });
  }

  bool _hasHelperTextState = true;

  bool get hasValue => _hasHelperTextState;
  set hasValue(bool newValue) {
    _setState(() {
      _hasHelperTextState = newValue;
    });
  }
}

/// Type State Management
class AlignmentState {
  AlignmentState(this._setState);

  final void Function(void Function()) _setState;

  List<ProgressIndicatorHelperTextAlignmentEnum> _alignmentList = [
    ProgressIndicatorHelperTextAlignmentEnum.left,
    ProgressIndicatorHelperTextAlignmentEnum.center,
    ProgressIndicatorHelperTextAlignmentEnum.right,
  ];
  ProgressIndicatorHelperTextAlignmentEnum _selectedAlignment =
      ProgressIndicatorHelperTextAlignmentEnum.center;

  List<ProgressIndicatorHelperTextAlignmentEnum> get list => _alignmentList;
  set list(List<ProgressIndicatorHelperTextAlignmentEnum> newList) {
    _setState(() {
      _alignmentList = newList;
    });
  }

  ProgressIndicatorHelperTextAlignmentEnum get selected => _selectedAlignment;
  set selected(ProgressIndicatorHelperTextAlignmentEnum newValue) {
    _setState(() {
      _selectedAlignment = newValue;
    });
  }
}
