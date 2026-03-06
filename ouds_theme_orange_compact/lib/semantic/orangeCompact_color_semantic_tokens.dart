import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_action_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_always_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_border_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_content_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_orange_compact/semantic/orangeCompact_color_surface_semantic_tokens.dart';

class OrangeCompactColorSemanticTokens extends OudsColorSemanticTokens {
  const OrangeCompactColorSemanticTokens({
    OrangeCompactColorActionSemanticTokens actionColorTokens = const OrangeCompactColorActionSemanticTokens(),
    OrangeCompactColorAlwaysSemanticTokens alwaysColorTokens = const OrangeCompactColorAlwaysSemanticTokens(),
    OrangeCompactColorBgSemanticTokens backgroundColorTokens = const OrangeCompactColorBgSemanticTokens(),
    OrangeCompactColorBorderSemanticTokens borderColorTokens = const OrangeCompactColorBorderSemanticTokens(),
    OrangeCompactColorContentSemanticTokens contentColorTokens = const OrangeCompactColorContentSemanticTokens(),
    OrangeCompactColorOpacitySemanticTokens opacityColorTokens = const OrangeCompactColorOpacitySemanticTokens(),
    OrangeCompactColorOverlaySemanticTokens overlayColorTokens = const OrangeCompactColorOverlaySemanticTokens(),
    OrangeCompactColorSurfaceSemanticTokens surfaceColorTokens = const OrangeCompactColorSurfaceSemanticTokens(),
    OrangeCompactColorRepositorySemanticTokens repositoryColorTokens = const OrangeCompactColorRepositorySemanticTokens(),
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
