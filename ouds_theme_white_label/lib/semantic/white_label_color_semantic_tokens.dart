import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_action_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_border_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_content_semantic_tokens.dart';

class WhiteLabelColorSemanticTokens extends OudsColorSemanticTokens {
  final WhiteLabelColorActionSemanticTokens actionColorTokens;
  final WhiteLabelColorBgSemanticTokens backgroundColorTokens;
  final WhiteLabelColorContentSemanticTokens contentColorTokens;
  final WhiteLabelColorBorderSemanticTokens borderColorTokens;

  const WhiteLabelColorSemanticTokens({
    this.actionColorTokens = const WhiteLabelColorActionSemanticTokens(),
    this.backgroundColorTokens = const WhiteLabelColorBgSemanticTokens(),
    this.contentColorTokens = const WhiteLabelColorContentSemanticTokens(),
    this.borderColorTokens = const WhiteLabelColorBorderSemanticTokens(),
  }) : super(
          actionColorTokens: actionColorTokens,
          backgroundColorTokens: backgroundColorTokens,
          contentColorTokens: contentColorTokens,
          borderColorTokens: borderColorTokens,
        );
}
