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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_code_generator.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_customization.dart';
import 'package:ouds_flutter_demo/ui/components/card/card_enum.dart';
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
        state.coloredBackground && state.style != CardStyleEnum.outlined
        ? true
        : false;
    final card = actionCard
        ? _buildActionCard(context, state, backgroundColor)
        : _buildContentCard(context, state, backgroundColor);

    return LightDarkBox(hasConstrainedMaxWidthOption: true, child: card);
  }

  /// Builds the selected action-card variant.
  Widget _buildActionCard(
    BuildContext context,
    CardCustomizationState state,
    bool backgroundColor,
  ) {
    final semanticsLabel =
        context.l10n.app_components_card_actionCard_semantics_a11y;
    final loader = state.loading
        ? OudsCardLoader()
        : null;
    final skeleton = state.skeleton ? OudsSkeleton() : null;
    return switch (state.style) {
      CardStyleEnum.filled => OudsActionCard.filled(
        semanticsLabel: semanticsLabel,
        onPressed: () {},
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        loader: loader,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
      CardStyleEnum.outlined => OudsActionCard.outlined(
        semanticsLabel: semanticsLabel,
        onPressed: () {},
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        loader: loader,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
      CardStyleEnum.elevated => OudsActionCard.elevated(
        semanticsLabel: semanticsLabel,
        onPressed: () {},
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        loader: loader,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
    };
  }

  /// Builds the selected content-card variant.
  Widget _buildContentCard(
    BuildContext context,
    CardCustomizationState state,
    bool backgroundColor,
  ) {
    final skeleton = state.skeleton ? OudsSkeleton() : null;
    return switch (state.style) {
      CardStyleEnum.filled => OudsCard.filled(
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
      CardStyleEnum.outlined => OudsCard.outlined(
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
      CardStyleEnum.elevated => OudsCard.elevated(
        enabled: state.enabled,
        backgroundColor: backgroundColor,
        divider: state.divider,
        skeleton: skeleton,
        child: _CardContent(state),
      ),
    };
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(this.state);

  final CardCustomizationState state;

  /// Sizes and displays the card's selected example content.
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 360, child: _cardContent(context));
  }

  /// Chooses between the use-case example and the simple content placeholder.
  Widget _cardContent(BuildContext context) {
    if(state.content == CardContentEnum.useCase) {
      return _content(context);
    }else{
      final theme = OudsTheme.of(context);
      return SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsetsDirectional.all(
            theme.spaceScheme(context).fixedFiveExtraLarge,
          ),
          alignment: Alignment.center,
          color: theme.colorScheme(context).surfaceStatusInfoMuted,
          child: OudsLabelText(text: context.l10n.app_components_common_content_tech, weight: OudsTextWeight.moderate,),
        ),
      );
    }
  }

  /// Builds the product example shown inside the card.
  Widget _content(BuildContext context){
    final theme = OudsTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OudsTag.text(label: "New", status: Warning(), roundedCorners: false),
        Padding(
          padding: EdgeInsetsDirectional.all(
            theme.spaceScheme(context).fixedMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OudsHeadingText(
                text: "Samsung",
                size: OudsHeadingTextSize.medium,
              ),
              OudsLabelText(
                text: "Galaxy S26 FE EE",
                weight: OudsTextWeight.moderate,
                size: OudsLabelTextSize.xLarge,
              ),
              SizedBox(height: theme.spaceScheme(context).fixedMedium),
              OudsButton(
                label: context.l10n.app_components_card_button,
                appearance: OudsButtonAppearance.strong,
                isFullWidth: true,
                onPressed: () {},
              ),
            ],
          ),
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
        CustomizableChips<CardStyleEnum>(
          title: CardStyleEnum.enumName(context),
          options: CardStyleEnum.values,
          selectedOption: state.style,
          getText: (option) => option.stringValue(context),
          onSelected: state.updateStyle,
        ),
        CustomizableSwitch(
          title: context.l10n.app_common_enabled_label,
          value: state.enabled,
          onChanged: state.updateEnabled,
        ),
        if (state.style != CardStyleEnum.outlined)
          CustomizableSwitch(
            title: context.l10n.app_components_card_backgroundColor_tech,
            value: state.coloredBackground,
            onChanged: state.enabled ? state.updateColoredBackground : null,
          ),
        if (state.style == CardStyleEnum.filled)
          CustomizableSwitch(
            title: context.l10n.app_components_divider_label,
            value: state.divider,
            onChanged: state.updateDivider,
          ),
        CustomizableChips<CardContentEnum>(
          title: CardContentEnum.enumName(context),
          options: CardContentEnum.values,
          selectedOption: state.content,
          getText: (option) => option.stringValue(context),
          onSelected: state.updateContent,
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
        ],
      ],
    );
  }
}
