import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

import '../ouds_tag.dart';

class OudsTagSizeModifier {
  final BuildContext context;

  OudsTagSizeModifier(this.context);

  /// Retrieves the min width and min height (double) for the tag based on the provided size enum.
  Map<String,double> getWidthAndHeight(OudsTagSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if(size == OudsTagSize.small) {
      return {'width' : theme.sizeMinWidthSmall, 'height' : theme.sizeMinHeightSmall};
    }else{
      return {'width' : theme.sizeMinWidthDefault, 'height' : theme.sizeMinHeightDefault};
    }
  }

  /// Retrieves the padding (EdgeInsetsDirectional) for the tag based on the provided size enum.
  EdgeInsetsDirectional getPadding(OudsTagSize? size, bool isIcon) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if(!isIcon){
      if(size == OudsTagSize.small) {
        return EdgeInsetsDirectional.symmetric(
          vertical: theme.spacePaddingBlockSmall,
          horizontal:  theme.spacePaddingInlineSmall,
        );
      }else {
        return EdgeInsetsDirectional.symmetric(
          vertical: theme.spacePaddingBlockDefault,
          horizontal:  theme.spacePaddingInlineDefault,
        );
      }

    } else{
      if(size == OudsTagSize.small) {
        return EdgeInsetsDirectional.only(
            top : theme.spacePaddingBlockSmall,
            start: theme.spacePaddingInlineSmallAsset,
            bottom: theme.spacePaddingBlockSmall,
            end: theme.spacePaddingInlineSmall
        );
      }else{
        return EdgeInsetsDirectional.only(
            top : theme.spacePaddingBlockDefault,
            start: theme.spacePaddingInlineDefaultAsset,
            bottom: theme.spacePaddingBlockDefault,
            end: theme.spacePaddingInlineDefault
        );
      }

    }
  }
}
