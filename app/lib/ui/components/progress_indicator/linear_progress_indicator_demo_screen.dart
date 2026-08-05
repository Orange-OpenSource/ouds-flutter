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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_customization.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_dropdown_menu.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

class LinearProgressIndicatorDemoScreen extends StatefulWidget {
  final String? previousPageTitle;
  const LinearProgressIndicatorDemoScreen({super.key, this.previousPageTitle});

  @override
  State<StatefulWidget> createState() =>
      _LinearProgressIndicatorDemoScreenState();
}

class _LinearProgressIndicatorDemoScreenState
    extends State<LinearProgressIndicatorDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ProgressIndicatorCustomization(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: defaultTargetPlatform == TargetPlatform.android
                ? MediaQuery.of(context).viewPadding.bottom
                : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
          ),
          child: Scaffold(
            bottomSheet: OudsSheetsBottom(
              onExpansionChanged: _onExpansionChanged,
              sheetContent: const _CustomizationContent(),
              title: context.l10n.app_common_customize_label,
            ),
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
              showBackButton: true,
              title: context
                  .l10n
                  .app_components_progressIndicator_linearProgressIndicator_tech,
              previousPageTitle: widget.previousPageTitle,
            ),
            body: ExcludeSemantics(
              excluding: !_isBottomSheetExpanded,
              child: _Body(),
            ),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the linear progress indicator demo and code will be displayed
class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    return DetailScreenDescription(
      description: context
          .l10n
          .app_components_progressIndicator_linearProgressIndicator_description_text,
      widget: Column(
        children: [
          _LinearProgressIndicatorDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(
            code: ProgressIndicatorCodeGenerator.updateCode(
              context,
              widgetType: ProgressIndicatorWidgetType.linear,
            ),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.progressIndicator,
          ),
        ],
      ),
    );
  }
}

/// This widget is now a StatefulWidget for the linear progress indicator demo.
///
/// Component [LinearProgressIndicator] demonstrates the behavior and functionality.
class _LinearProgressIndicatorDemo extends StatefulWidget {
  const _LinearProgressIndicatorDemo();

  @override
  State<_LinearProgressIndicatorDemo> createState() =>
      _LinearProgressIndicatorDemoState();
}

class _LinearProgressIndicatorDemoState
    extends State<_LinearProgressIndicatorDemo> {
  ThemeController? themeController;
  ProgressIndicatorCustomizationState? customizationState;

  @override
  Widget build(BuildContext context) {
    customizationState = ProgressIndicatorCustomization.of(context);
    themeController = Provider.of<ThemeController>(context, listen: true);

    return LightDarkBox(
      child: OudsLinearProgressIndicator(
        progressType: ProgressIndicatorCustomizationUtils.getProgressType(
          customizationState!.selectedType,
        ),
        status: ProgressIndicatorCustomizationUtils.getStatus(
          customizationState!.selectedStatus,
        ),
        progress: ProgressIndicatorCustomizationUtils.getProgressValue(
          customizationState!.progress,
        ),
        track: customizationState!.hasTrack,
        animated: customizationState!.hasAnimation,
        gapSize: ProgressIndicatorCustomizationUtils.getGapSize(
          customizationState!.selectedGapSize,
        ),
        stopIndicator: customizationState!.hasStopIndicator,
        percentage: customizationState!.hasHelperText
            ? customizationState!.hasPercentage
            : false,
        spaceBeforePercentage: customizationState!.hasSpaceBefore,
        helperTextAlignment:
            ProgressIndicatorCustomizationUtils.getHelperTextAlignment(
              customizationState!.selectedAlignment,
            ),
        helperText: customizationState!.hasHelperText
            ? customizationState!.helperText
            : null,
        semanticLabel:
            context.l10n.app_components_progressIndicator_progress_a11y,
      ),
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent();

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

/// This state class handles the customization options for the progress indicator
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode progressFocus;
  late final FocusNode helperFocus;

  @override
  void initState() {
    super.initState();
    progressFocus = FocusNode();
    helperFocus = FocusNode();
  }

  @override
  void dispose() {
    progressFocus.dispose();
    helperFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProgressIndicatorCustomizationState? customizationState =
        ProgressIndicatorCustomization.of(context);
    final theme = OudsTheme.of(context).spaceScheme(context);

    return CustomizableSection(
      children: [
        CustomizableChips<ProgressIndicatorEnumType>(
          title: ProgressIndicatorEnumType.enumName(context),
          options: customizationState!.typeState.list,
          selectedOption: customizationState.selectedType,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedType = selectedOption;
              customizationState.hasPercentage = false;
            });
          },
        ),
        CustomizableTextField(
          title: context.l10n.app_components_progressIndicator_progress_tech,
          text: customizationState.progress.toString(),
          focusNode: progressFocus,
          fieldType: FieldType.label,
          fieldEnable:
              customizationState.selectedType ==
              ProgressIndicatorEnumType.determinate,
          keyboardType: TextInputType.number,
        ),
        CustomizationDropdownMenu<StatusEnum>(
          label: StatusEnum.enumName(context),
          options: customizationState.statusState.list,
          selectedItemIndex: customizationState.selectedIndex,
          selectedOption: customizationState.selectedStatus,
          getText: (option) => option.stringValue(context),
          onSelectionChange: (value, index) {
            setState(() {
              customizationState.selectedStatus = value;
              customizationState.selectedIndex = index;
            });
          },
          itemLeadingIcons: customizationState.statusState.list.map((status) {
            return () => Container(
              width: theme.paddingBlockMedium,
              height: theme.paddingBlockMedium,
              decoration: BoxDecoration(
                color:
                    ProgressIndicatorCustomizationUtils.getProgressIndicatorStatusColor(
                      context,
                      status,
                    ),
                shape: BoxShape.rectangle,
              ),
            );
          }).toList(),
        ),
        CustomizableChips<ProgressIndicatorGapSizeEnum>(
          title: ProgressIndicatorGapSizeEnum.enumName(context),
          options: customizationState.gapSizeState.list,
          selectedOption: customizationState.selectedGapSize,
          getText: (option) => option.stringValue(context),
          onSelected: (selectedOption) {
            setState(() {
              customizationState.selectedGapSize = selectedOption;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_progressIndicator_animated_tech,
          value: customizationState.hasAnimation,
          onChanged:
              customizationState.selectedType ==
                  ProgressIndicatorEnumType.determinate
              ? (value) {
                  customizationState.hasAnimation = value;
                }
              : null,
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_progressIndicator_track_tech,
          value: customizationState.hasTrack,
          onChanged: (value) {
            setState(() {
              customizationState.hasTrack = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context
              .l10n
              .app_components_progressIndicator_linearProgressIndicator_stopIndicator_tech,
          value: customizationState.hasStopIndicator,
          onChanged:
              customizationState.selectedType ==
                  ProgressIndicatorEnumType.determinate
              ? (value) {
                  customizationState.hasStopIndicator = value;
                }
              : null,
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_helperText_label,
          value: customizationState.hasHelperText,
          onChanged: (value) {
            customizationState.hasHelperText = value;
          },
        ),
        Visibility(
          visible: customizationState.hasHelperText,
          child: CustomizableSwitch(
            title: context
                .l10n
                .app_components_progressIndicator_helperTextPercentage_tech,
            value: customizationState.hasPercentage,
            onChanged:
                customizationState.selectedType ==
                    ProgressIndicatorEnumType.determinate
                ? (value) {
                    customizationState.hasPercentage = value;
                  }
                : null,
          ),
        ),
        Visibility(
          visible: customizationState.hasHelperText,
          child: CustomizableChips<ProgressIndicatorHelperTextAlignmentEnum>(
            title: ProgressIndicatorHelperTextAlignmentEnum.enumName(context),
            options: customizationState.alignmentState.list,
            selectedOption: customizationState.selectedAlignment,
            getText: (option) => option.stringValue(context),
            onSelected: customizationState.hasPercentage
                ? (selectedOption) {
                    setState(() {
                      customizationState.selectedAlignment = selectedOption;
                    });
                  }
                : null,
          ),
        ),
        Visibility(
          visible: customizationState.hasHelperText,
          child: CustomizableSwitch(
            title: context
                .l10n
                .app_components_progressIndicator_helperTextSpaceBefore_tech,
            value: customizationState.hasSpaceBefore,
            onChanged: customizationState.hasPercentage
                ? (value) {
                    customizationState.hasSpaceBefore = value;
                  }
                : null,
          ),
        ),
        Visibility(
          visible: customizationState.hasHelperText,
          child: CustomizableTextField(
            title: context.l10n.app_components_common_helperText_label,
            text: customizationState.helperText,
            focusNode: helperFocus,
            fieldType: FieldType.helper,
            fieldEnable: !customizationState.hasPercentage,
          ),
        ),
      ],
    );
  }
}
