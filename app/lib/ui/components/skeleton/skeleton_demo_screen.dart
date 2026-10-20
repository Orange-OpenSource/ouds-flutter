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
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/skeleton/skeleton_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/skeleton/skeleton_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/customize_bottom_sheet.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:provider/provider.dart';

class SkeletonDemoScreen extends StatefulWidget {
  final String? previousPageTitle;
  const SkeletonDemoScreen({super.key, this.previousPageTitle});

  @override
  State<StatefulWidget> createState() => _SkeletonDemoScreenState();
}

class _SkeletonDemoScreenState extends State<SkeletonDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: SkeletonCustomization(
        child: CustomizeBottomSheet(
          topBar: MainAppBar(
            showBackButton: true,
            title: context.l10n.app_components_skeleton_label,
            previousPageTitle: widget.previousPageTitle,
          ),
          title: context.l10n.app_common_customize_label,
          customizationContent: const _CustomizationContent(),
          body: const _Body(),
        ),
      ),
    );
  }
}

/// This widget represents the body of the screen where the skeleton demo and code will be displayed
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
      description: context.l10n.app_components_skeleton_description_text,
      widget: Column(
        children: [
          const _SkeletonDemo(),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(code: SkeletonCodeGenerator.updateCode(context)),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.skeleton,
          ),
        ],
      ),
    );
  }
}

/// Component [_SkeletonDemo] demonstrates the behavior and functionality of a skeleton.
class _SkeletonDemo extends StatefulWidget {
  const _SkeletonDemo();

  @override
  State<_SkeletonDemo> createState() => _SkeletonDemoState();
}

class _SkeletonDemoState extends State<_SkeletonDemo> {
  @override
  Widget build(BuildContext context) {
    final customizationState = SkeletonCustomization.of(context)!;

    return LightDarkBox(
      child: OudsSkeleton(
        animated: customizationState.hasAnimated,
        hasSecurityMargin: customizationState.hasSecurityMargin,
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

/// This state class handles the customization options for the skeleton
class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode widthFocus;
  late final FocusNode heightFocus;

  @override
  void initState() {
    super.initState();
    widthFocus = FocusNode();
    heightFocus = FocusNode();
  }

  @override
  void dispose() {
    widthFocus.dispose();
    heightFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SkeletonCustomizationState? customizationState =
        SkeletonCustomization.of(context);

    return CustomizableSection(
      children: [
        CustomizableSwitch(
          title: context.l10n.app_components_skeleton_hasSecurityMargin_tech,
          value: customizationState!.hasSecurityMargin,
          onChanged: (value) {
            setState(() {
              customizationState.hasSecurityMargin = value;
            });
          },
        ),
        CustomizableSwitch(
          title: context.l10n.app_components_skeleton_animated_tech,
          value: customizationState.hasAnimated,
          onChanged: (value) {
            setState(() {
              customizationState.hasAnimated = value;
            });
          },
        ),
      ],
    );
  }
}
