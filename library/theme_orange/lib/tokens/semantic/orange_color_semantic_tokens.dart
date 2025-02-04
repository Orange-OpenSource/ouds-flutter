import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_color_action_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_color_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/tokens/semantic/orange_color_content_semantic_tokens.dart';

class OrangeColorSemanticTokens extends OudsColorSemanticTokens {
  final OrangeColorActionSemanticTokens actionColorTokens;
  final OrangeColorBgSemanticTokens backgroundColorTokens;
  final OrangeColorContentSemanticTokens contentColorTokens;
  final OrangeColorBorderSemanticTokens borderColorTokens;

  const OrangeColorSemanticTokens({
    this.actionColorTokens = const OrangeColorActionSemanticTokens(),
    this.backgroundColorTokens = const OrangeColorBgSemanticTokens(),
    this.contentColorTokens = const OrangeColorContentSemanticTokens(),
    this.borderColorTokens = const OrangeColorBorderSemanticTokens(),
  }) : super(
          actionColorTokens: actionColorTokens,
          backgroundColorTokens: backgroundColorTokens,
          contentColorTokens: contentColorTokens,
          borderColorTokens: borderColorTokens,
        );
}
