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
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_typography.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_customization.dart';
import 'package:ouds_flutter_demo/ui/components/typography/typography_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_textfield.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/ouds_sheets_bottom.dart';
import 'package:ouds_theme_contract/ouds_component_version.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

/// This screen displays a typography demo for a given [TypographyVariant] and allows customizing
/// its size and sample text.
class TypographyDemoScreen extends StatefulWidget {
  final TypographyVariant variant;
  final String? previousPageTitle;

  const TypographyDemoScreen({
    super.key,
    required this.variant,
    this.previousPageTitle,
  });

  @override
  State<TypographyDemoScreen> createState() => _TypographyDemoScreenState();
}

String _title(BuildContext context, TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return context.l10n.app_components_typography_display_tech;
    case TypographyVariant.heading:
      return context.l10n.app_components_typography_heading_tech;
    case TypographyVariant.body:
      return context.l10n.app_components_typography_body_tech;
    case TypographyVariant.label:
      return context.l10n.app_components_typography_label_tech;
    // case TypographyVariant.code:return context.l10n.app_components_typography_code_tech;
  }
}

String _description(BuildContext context, TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return context.l10n.app_components_typography_display_description_text;
    case TypographyVariant.heading:
      return context.l10n.app_components_typography_heading_description_text;
    case TypographyVariant.body:
      return context.l10n.app_components_typography_body_description_text;
    case TypographyVariant.label:
      return context.l10n.app_components_typography_label_description_text;
    // case TypographyVariant.code:return context.l10n.app_components_typography_code_description_text;
  }
}

class _TypographyDemoScreenState extends State<TypographyDemoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBottomSheetExpanded = true;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isBottomSheetExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TypographyCustomization(
      variant: widget.variant,
      initialText: "Label",
      child: Padding(
        padding: EdgeInsets.only(
          bottom: defaultTargetPlatform == TargetPlatform.android
              ? MediaQuery.of(context).viewPadding.bottom
              : OudsTheme.of(context).spaceScheme(context).paddingBlockNone,
        ),
        child: Scaffold(
          bottomSheet: OudsSheetsBottom(
            onExpansionChanged: _onExpansionChanged,
            sheetContent: _CustomizationContent(variant: widget.variant),
            title: context.l10n.app_common_customize_label,
          ),
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: MainAppBar(
            title: _title(context, widget.variant),
            previousPageTitle: widget.previousPageTitle,
            showBackButton: true,
          ),
          // SafeArea is intentionally not used to allow the TopAppBar blur effect
          // in body content added top padding so the content is not hidden behind the top app bar
          body: ExcludeSemantics(
            excluding: !_isBottomSheetExpanded,
            child: _Body(variant: widget.variant),
          ),
        ),
      ),
    );
  }
}

/// This widget represents the customization content section that appears in the bottom sheet
class _CustomizationContent extends StatefulWidget {
  final TypographyVariant variant;

  const _CustomizationContent({required this.variant});

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

class _CustomizationContentState extends State<_CustomizationContent> {
  late final FocusNode labelFocus;

  @override
  void initState() {
    super.initState();
    labelFocus = FocusNode();
  }

  @override
  void dispose() {
    labelFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = TypographyCustomization.of(context)!;
    final sizes = customizationState.sizeState.list;
    final isHeadingLarge =
        widget.variant == TypographyVariant.heading &&
        customizationState.selectedSize == OudsHeadingTextSize.large;
    // The marker is only supported by themes exposing `headingLargeMarker` (Orange, Orange
    // Compact, Wireframe); the rich/annotated text example is only relevant for themes that
    // don't support it (e.g. Sosh), see [OudsHeadingText.rich].
    final supportsHeadingMarker = OudsTheme.of(
      context,
    ).componentsTokens(context).typography.headingLargeMarker;
    final canUseAnnotatedText = isHeadingLarge && !supportsHeadingMarker;

    return CustomizableSection(
      children: [
        CustomizableChips<Object>(
          title: context.l10n.app_components_common_size_label,
          options: sizes,
          selectedOption: customizationState.selectedSize,
          getText: (size) => (size as Enum).formattedName,
          onSelected: (size) {
            setState(() {
              customizationState.selectedSize = size;
            });
          },
        ),
        if (hasWeightFor(widget.variant))
          CustomizableChips<OudsTextWeight>(
            title: context.l10n.app_components_typography_weight_tech,
            options: OudsTextWeight.values,
            selectedOption: customizationState.selectedWeight,
            getText: (weight) => weight.formattedName,
            onSelected: (weight) {
              setState(() {
                customizationState.selectedWeight = weight;
              });
            },
          ),
        if (widget.variant == TypographyVariant.heading &&
            supportsHeadingMarker)
          CustomizableSwitch(
            title: context.l10n.app_components_typography_heading_marker_tech,
            value: customizationState.hasMarker,
            onChanged: isHeadingLarge
                ? (value) {
                    setState(() {
                      customizationState.hasMarker = value;
                    });
                  }
                : null,
          ),
        if (widget.variant == TypographyVariant.heading &&
            !supportsHeadingMarker)
          CustomizableSwitch(
            title: context
                .l10n
                .app_components_typography_annotatedTextExample_tech,
            value: customizationState.hasAnnotatedText,
            onChanged: canUseAnnotatedText
                ? (value) {
                    setState(() {
                      customizationState.hasAnnotatedText = value;
                    });
                  }
                : null,
          ),
        CustomizableTextField(
          title: context.l10n.app_components_common_label_label,
          text: customizationState.labelText,
          focusNode: labelFocus,
          fieldType: FieldType.label,
        ),
      ],
    );
  }
}

/// This widget represents the body of the screen where the typography demo and code will be
/// displayed
class _Body extends StatefulWidget {
  final TypographyVariant variant;

  const _Body({required this.variant});

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
      description: _description(context, widget.variant),
      widget: Column(
        children: [
          _TypographyDemo(variant: widget.variant),
          SizedBox(
            height: themeController.currentTheme
                .spaceScheme(context)
                .fixedMedium,
          ),
          Code(
            code: TypographyCodeGenerator.updateCode(context, widget.variant),
          ),
          ReferenceDesignVersionComponent(
            version: OudsComponentVersion.typography,
          ),
        ],
      ),
    );
  }
}

/// This widget demonstrates the behavior and functionality of the selected typography variant.
class _TypographyDemo extends StatefulWidget {
  final TypographyVariant variant;

  const _TypographyDemo({required this.variant});

  @override
  State<_TypographyDemo> createState() => _TypographyDemoState();
}

class _TypographyDemoState extends State<_TypographyDemo> {
  @override
  Widget build(BuildContext context) {
    final customizationState = TypographyCustomization.of(context)!;
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    // Adding post-frame callback to update theme based on customization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeController.setOnColoredSurface(customizationState.hasOnColoredBox);
    });

    // The rich/annotated text example is only relevant for themes that don't support the heading
    // large marker (e.g. Sosh), and only for the large size, see [OudsHeadingText.rich].
    final supportsHeadingMarker = OudsTheme.of(
      context,
    ).componentsTokens(context).typography.headingLargeMarker;
    final canUseAnnotatedText =
        widget.variant == TypographyVariant.heading &&
        customizationState.selectedSize == OudsHeadingTextSize.large &&
        !supportsHeadingMarker;

    if (canUseAnnotatedText && customizationState.hasAnnotatedText) {
      final color = OudsTheme.of(
        context,
      ).colorScheme(context).contentBrandPrimary;
      return LightDarkBox(
        child: OudsHeadingText.rich(
          size: customizationState.selectedSize as OudsHeadingTextSize,
          marker: customizationState.hasMarker,
          text: buildOudsAnnotatedHeadingText((builder) {
            builder.append('Heading with ');
            builder.withColor(color, () => builder.append('colored text'));
          }),
        ),
      );
    }

    return LightDarkBox(
      child: buildOudsTypography(
        widget.variant,
        customizationState.selectedSize,
        customizationState.labelText,
        marker: customizationState.hasMarker,
        weight: customizationState.selectedWeight,
      ),
    );
  }

  /// Builds the [OudsTypography] widget matching [variant], casting [size] to the enum type expected
  /// by that variant's widget.
  Widget buildOudsTypography(
    TypographyVariant variant,
    Object size,
    String text, {
    bool marker = true,
    OudsTextWeight weight = OudsTextWeight.defaultWeight,
  }) {
    switch (variant) {
      case TypographyVariant.display:
        return OudsDisplayText(text: text, size: size as OudsDisplayTextSize);
      case TypographyVariant.heading:
        return OudsHeadingText(
          text: text,
          size: size as OudsHeadingTextSize,
          marker: marker,
        );
      case TypographyVariant.body:
        return OudsBodyText(
          text: text,
          size: size as OudsBodyTextSize,
          weight: weight,
        );
      case TypographyVariant.label:
        return OudsLabelText(
          text: text,
          size: size as OudsLabelTextSize,
          weight: weight,
        );
      //  case TypographyVariant.code:return OudsCodeText(text: text, size: size as OudsCodeTextSize);
    }
  }
}
