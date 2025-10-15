import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_action_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_always_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_border_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_content_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_wireframe/semantic/wireframe_color_surface_semantic_tokens.dart';

class WireframeColorSemanticTokens extends OudsColorSemanticTokens {
  const WireframeColorSemanticTokens({
    WireframeColorActionSemanticTokens actionColorTokens = const WireframeColorActionSemanticTokens(),
    WireframeColorAlwaysSemanticTokens alwaysColorTokens = const WireframeColorAlwaysSemanticTokens(),
    WireframeColorBgSemanticTokens backgroundColorTokens = const WireframeColorBgSemanticTokens(),
    WireframeColorBorderSemanticTokens borderColorTokens = const WireframeColorBorderSemanticTokens(),
    WireframeColorContentSemanticTokens contentColorTokens = const WireframeColorContentSemanticTokens(),
    //WireframeColorDecorativeSemanticTokens decorativeColorTokens = const WireframeColorDecorativeSemanticTokens(),
    WireframeColorOpacitySemanticTokens opacityColorTokens = const WireframeColorOpacitySemanticTokens(),
    WireframeColorOverlaySemanticTokens overlayColorTokens = const WireframeColorOverlaySemanticTokens(),
    WireframeColorSurfaceSemanticTokens surfaceColorTokens = const WireframeColorSurfaceSemanticTokens(),
    WireframeColorRepositorySemanticTokens repositoryColorTokens = const WireframeColorRepositorySemanticTokens(),
  }) : super(
          actionColorTokens: actionColorTokens,
          alwaysColorTokens: alwaysColorTokens,
          backgroundColorTokens: backgroundColorTokens,
          borderColorTokens: borderColorTokens,
          contentColorTokens: contentColorTokens,
          //decorativeColorTokens: decorativeColorTokens,
          opacityColorTokens: opacityColorTokens,
          overlayColorTokens: overlayColorTokens,
          surfaceColorTokens: surfaceColorTokens,
          repositoryColorTokens: repositoryColorTokens,
        );
}
