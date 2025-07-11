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

import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_action_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_always_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_border_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_content_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_decorative_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_surface_semantic_tokens.dart';

class SoshColorSemanticTokens extends OudsColorSemanticTokens {
  const SoshColorSemanticTokens({
    SoshColorActionSemanticTokens actionColorTokens = const SoshColorActionSemanticTokens(),
    SoshColorAlwaysSemanticTokens alwaysColorTokens = const SoshColorAlwaysSemanticTokens(),
    SoshColorBgSemanticTokens backgroundColorTokens = const SoshColorBgSemanticTokens(),
    SoshColorBorderSemanticTokens borderColorTokens = const SoshColorBorderSemanticTokens(),
    SoshColorContentSemanticTokens contentColorTokens = const SoshColorContentSemanticTokens(),
    SoshColorDecorativeSemanticTokens decorativeColorTokens = const SoshColorDecorativeSemanticTokens(),
    SoshColorOpacitySemanticTokens opacityColorTokens = const SoshColorOpacitySemanticTokens(),
    SoshColorOverlaySemanticTokens overlayColorTokens = const SoshColorOverlaySemanticTokens(),
    SoshColorSurfaceSemanticTokens surfaceColorTokens = const SoshColorSurfaceSemanticTokens(),
    SoshColorRepositorySemanticTokens repositoryColorTokens = const SoshColorRepositorySemanticTokens(),
  }) : super(
          actionColorTokens: actionColorTokens,
          alwaysColorTokens: alwaysColorTokens,
          backgroundColorTokens: backgroundColorTokens,
          borderColorTokens: borderColorTokens,
          contentColorTokens: contentColorTokens,
          decorativeColorTokens: decorativeColorTokens,
          opacityColorTokens: opacityColorTokens,
          overlayColorTokens: overlayColorTokens,
          surfaceColorTokens: surfaceColorTokens,
          repositoryColorTokens: repositoryColorTokens,
        );

  // Utilisation de getters pour ne pas redéfinir les champs hérités

  @override
  SoshColorActionSemanticTokens get actionColorTokens => const SoshColorActionSemanticTokens();

  @override
  SoshColorAlwaysSemanticTokens get alwaysColorTokens => const SoshColorAlwaysSemanticTokens();

  @override
  SoshColorBgSemanticTokens get backgroundColorTokens => const SoshColorBgSemanticTokens();

  @override
  SoshColorBorderSemanticTokens get borderColorTokens => const SoshColorBorderSemanticTokens();

  @override
  SoshColorContentSemanticTokens get contentColorTokens => const SoshColorContentSemanticTokens();

  @override
  SoshColorDecorativeSemanticTokens get decorativeColorTokens => const SoshColorDecorativeSemanticTokens();

  @override
  SoshColorOpacitySemanticTokens get opacityColorTokens => const SoshColorOpacitySemanticTokens();

  @override
  SoshColorOverlaySemanticTokens get overlayColorTokens => const SoshColorOverlaySemanticTokens();

  @override
  SoshColorSurfaceSemanticTokens get surfaceColorTokens => const SoshColorSurfaceSemanticTokens();

  @override
  SoshColorRepositorySemanticTokens get repositoryColorTokens => const SoshColorRepositorySemanticTokens();
}
