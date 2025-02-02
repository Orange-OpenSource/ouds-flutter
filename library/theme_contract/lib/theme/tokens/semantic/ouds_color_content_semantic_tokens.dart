import 'package:flutter/material.dart';
import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_global_raw_tokens/orange_brand_color_raw_tokens.dart';

class OudsColorContentSemanticTokens {
  final Color contentBrandPrimaryLight;
  final Color contentDefaultLight;
  final Color contentDisabledLight;
  final Color contentBrandPrimaryDark;
  final Color contentDefaultDark;
  final Color contentDisabledDark;

  const OudsColorContentSemanticTokens({
    this.contentBrandPrimaryLight = OrangeBrandColorRawTokens.colorOrange550,
    this.contentDefaultLight = ColorRawTokens.colorFunctionalBlack,
    this.contentDisabledLight = ColorRawTokens.colorFunctionalDarkGray80,
    this.contentBrandPrimaryDark = OrangeBrandColorRawTokens.colorOrange700,
    this.contentDefaultDark = ColorRawTokens.colorFunctionalWhite,
    this.contentDisabledDark = ColorRawTokens.colorFunctionalDarkGray640,
  });
}
