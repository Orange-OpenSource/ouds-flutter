import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_action_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_always_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_border_semantic_tokens.dart';
import 'package:ouds_theme_sosh/semantic/sosh_color_content_semantic_tokens.dart';
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
          opacityColorTokens: opacityColorTokens,
          overlayColorTokens: overlayColorTokens,
          surfaceColorTokens: surfaceColorTokens,
          repositoryColorTokens: repositoryColorTokens,
        );
}
