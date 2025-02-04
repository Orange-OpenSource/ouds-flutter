import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_content_semantic_tokens.dart';
import 'package:ouds_theme_white_label/tokens/raw/white_label_color_raw_tokens.dart';

class WhiteLabelColorContentSemanticTokens
    extends OudsColorContentSemanticTokens {
  const WhiteLabelColorContentSemanticTokens({
    super.contentBrandPrimaryLight = ColorRawTokens.colorFunctionalDarkGray880,
    super.contentDefaultLight = ColorRawTokens.colorFunctionalWhite,
    super.contentDisabledLight = ColorRawTokens.colorFunctionalBlack,
    super.contentBrandPrimaryDark = WhiteLabelColorRawTokens.colorWarmGray100,
    super.contentDefaultDark = ColorRawTokens.colorFunctionalDarkGray640,
    super.contentDisabledDark = ColorRawTokens.colorFunctionalDarkGray880,
  });
}
