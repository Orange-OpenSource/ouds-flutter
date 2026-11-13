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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/card/ouds_action_card.dart';
import 'package:ouds_core/components/card/ouds_card.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_customization.dart';
import 'package:ouds_flutter_demo/ui/utilities/code.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_chips.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_section.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_switch.dart';
import 'package:ouds_flutter_demo/ui/utilities/detail_screen_header.dart';
import 'package:ouds_flutter_demo/ui/utilities/dismiss_keyboard.dart';
import 'package:ouds_flutter_demo/ui/utilities/light_dark_box.dart';
import 'package:ouds_flutter_demo/ui/utilities/reference_design_version_component.dart';
import 'package:ouds_flutter_demo/ui/utilities/sheets_bottom/customize_bottom_sheet.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Demo and customization screen for either card variant.
class CardDemoScreen extends StatelessWidget {
  const CardDemoScreen({
    super.key,
    required this.actionCard,
    this.previousPageTitle,
  });

  final bool actionCard;
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final title = actionCard
        ? context.l10n.app_components_card_actionCard_tech
        : context.l10n.app_components_card_contentCard_tech;

    return DismissKeyboard(
      child: CardCustomization(
        child: CustomizeBottomSheet(
          topBar: MainAppBar(
            title: title,
            previousPageTitle: previousPageTitle,
            showBackButton: true,
          ),
          title: context.l10n.app_common_customize_label,
          customizationContent: _CustomizationContent(actionCard: actionCard),
          body: _Body(actionCard: actionCard),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.actionCard});

  final bool actionCard;

  @override
  Widget build(BuildContext context) {
    return DetailScreenDescription(
      description: actionCard
          ? context.l10n.app_components_card_actionCard_description_text
          : context.l10n.app_components_card_contentCard_description_text,
      widget: Column(
        children: [
          _CardDemo(actionCard: actionCard),
          SizedBox(
            height: OudsTheme.of(context).spaceScheme(context).fixedMedium,
          ),
          Code(
            code: CardCodeGenerator.updateCode(context, actionCard: actionCard),
          ),
          const ReferenceDesignVersionComponent(version: '1.0.0'),
        ],
      ),
    );
  }
}

class _CardDemo extends StatelessWidget {
  const _CardDemo({required this.actionCard});

  final bool actionCard;

  @override
  Widget build(BuildContext context) {
    final state = CardCustomization.of(context)!;
    final backgroundColor =
        state.coloredBackground && state.style != OudsCardStyle.outlined
        ? true
        : false;

    return LightDarkBox(
      hasConstrainedMaxWidthOption: true,
      child: actionCard
          ? OudsActionCard(
              semanticsLabel:
                  context.l10n.app_components_card_actionCard_semantics_a11y,
              onPressed: () => {},
              style: state.style,
              enabled: state.enabled,
              backgroundColor: backgroundColor,
              divider: state.divider,
              loader: state.loading
                  ? OudsCardLoader(
                      progress: state.determinate ? state.progress : null,
                    )
                  : null,
              skeleton: state.skeleton ? OudsSkeleton() : null,
              child: _CardContent(),
            )
          : OudsCard(
              style: state.style,
              enabled: state.enabled,
              backgroundColor: backgroundColor,
              divider: state.divider,
              skeleton: state.skeleton ? OudsSkeleton() : null,
              child: _CardContent(),
            ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent();

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    return Container(
      width: 360,
      padding: EdgeInsetsDirectional.all(
        theme.spaceScheme(context).fixedMedium,
      ),
      child: _cardContent(context),
    );
  }

  Widget _cardContent(BuildContext context) {
    final theme = OudsTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OudsHeadingText(
          text: context.l10n.app_components_card_Title_text,
          size: OudsHeadingTextSize.xLarge,
        ),
        SizedBox(height: theme.spaceScheme(context).fixedMedium),
        OudsBodyText(
          text: context.l10n.app_components_card_planDescription_text,
          size: OudsBodyTextSize.large,
        ),
        SizedBox(height: theme.spaceScheme(context).fixedMedium),
        OudsListItem(label: context.l10n.app_components_card_checkDevice_text,
            onTap: () {}),
        OudsListItem(label: context.l10n.app_components_card_learnHow_button,
          onTap: () {},),
        SizedBox(height: theme.spaceScheme(context).fixedMedium),
        OudsButton(
          label: context.l10n.app_components_card_activate_button,
          appearance: OudsButtonAppearance.strong,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _CustomizationContent extends StatefulWidget {
  const _CustomizationContent({required this.actionCard});

  final bool actionCard;

  @override
  State<_CustomizationContent> createState() => _CustomizationContentState();
}

class _CustomizationContentState extends State<_CustomizationContent> {
  @override
  Widget build(BuildContext context) {
    final state = CardCustomization.of(context)!;
    return CustomizableSection(
      children: [
        CustomizableChips<OudsCardStyle>(
          title: context.l10n.app_components_common_style_label,
          options: OudsCardStyle.values,
          selectedOption: state.style,
          getText: (style) => switch (style) {
            OudsCardStyle.filled =>
              context.l10n.app_components_card_style_filled_tech,
            OudsCardStyle.outlined =>
              context.l10n.app_components_card_style_outlined_tech,
            OudsCardStyle.elevated =>
              context.l10n.app_components_card_style_elevated_tech,
          },
          onSelected: state.updateStyle,
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: state.enabled,
          onChanged: state.updateEnabled,
        ),
        if (state.style != OudsCardStyle.outlined)
          CustomizableSwitch(
            title: context.l10n.app_components_card_backgroundColor_tech,
            value: state.coloredBackground,
            onChanged: state.enabled ? state.updateColoredBackground : null,
          ),
        if (state.style == OudsCardStyle.filled)
          CustomizableSwitch(
            title: context.l10n.app_components_divider_label,
            value: state.divider,
            onChanged: state.updateDivider,
          ),
        CustomizableSwitch(
          title: context.l10n.app_components_common_skeleton_tech,
          value: state.skeleton,
          onChanged: state.updateSkeleton,
        ),
        if (widget.actionCard) ...[
          CustomizableSwitch(
            title: context.l10n.app_components_card_loading_tech,
            value: state.loading,
            onChanged: state.updateLoading,
          ),
          if (state.loading) ...[
            CustomizableChips<bool>(
              title: context.l10n.app_components_card_progressMode_tech,
              options: const [true, false],
              selectedOption: state.determinate,
              getText: (determinate) => determinate
                  ? context.l10n.app_components_card_determinate_label
                  : context.l10n.app_components_card_indeterminate_label,
              onSelected: state.updateDeterminate,
            ),
            if (state.determinate)
              _ProgressSlider(
                value: state.progress,
                onChanged: state.updateProgress,
              ),
          ],
        ],
      ],
    );
  }
}

class _ProgressSlider extends StatelessWidget {
  const _ProgressSlider({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final space = OudsTheme.of(context).spaceScheme(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: space.fixedMedium,
        vertical: space.fixedExtraSmall,
      ),
      child: Semantics(
        label: context.l10n.app_components_card_progress_tech,
        child: Slider(value: value, onChanged: onChanged),
      ),
    );
  }
}
