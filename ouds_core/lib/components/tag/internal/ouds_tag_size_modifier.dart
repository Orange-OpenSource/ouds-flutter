import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';

class OudsTagSizeModifier {
  final BuildContext context;

  OudsTagSizeModifier(this.context);

  /// Retrieves the min width and min height (double) for the tag based on the provided size enum.
  Map<String,double?> getMinWidthAndHeight(OudsTagSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if(size == OudsTagSize.small) {
      return {'width' : theme.sizeMinWidthSmall, 'height' : theme.sizeMinHeightSmall};
    }else{
      return {'width' : theme.sizeMinWidthDefault, 'height' : theme.sizeMinHeightDefault};
    }
  }

  /// Retrieves the width and height (double) for the tag based on the provided size enum.
  Map<String,double?> getWidthAndHeightAssetsContainer(OudsTagSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if(size == OudsTagSize.small) {
      return {'width' : theme.sizeAssetSmall, 'height' : theme.sizeAssetSmall};
    }else{
      return {'width' : theme.sizeAssetDefault, 'height' : theme.sizeAssetDefault};
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
            start: theme.spacePaddingInlineAssetSmall,
            bottom: theme.spacePaddingBlockSmall,
            end: theme.spacePaddingInlineSmall
        );
      }else{
        return EdgeInsetsDirectional.only(
            top : theme.spacePaddingBlockDefault,
            start: theme.spacePaddingInlineAssetDefault,
            bottom: theme.spacePaddingBlockDefault,
            end: theme.spacePaddingInlineDefault
        );
      }

    }
  }

  /// Retrieves the spaceColumnGap (double) for the tag based on the provided size enum.
  double? getSizeColumnGap(OudsTagSize? size) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault;
  }

/// Retrieves the padding (EdgeInsetsGeometry) for the assets based on the provided size enum.
  EdgeInsetsGeometry getAssetsPadding(OudsTagSize? size, OudsTagLayout layout){
   final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

   switch (layout){
     case OudsTagLayout.textAndIcon:
       return EdgeInsetsGeometry.all(
           size != null && size == OudsTagSize.small
               ? tagToken.spaceInsetIconSmall
               : tagToken.spaceInsetIconDefault);
     case OudsTagLayout.textAndBullet:
     return EdgeInsetsGeometry.all(
         size != null && size == OudsTagSize.small
             ? tagToken.spaceInsetBulletSmall
             : tagToken.spaceInsetBulletDefault);
     case OudsTagLayout.textAndLoader:
       return EdgeInsetsGeometry.all(
           size != null && size == OudsTagSize.small
               ? tagToken.spaceInsetLoaderSmall
               : tagToken.spaceInsetLoaderDefault);
     case OudsTagLayout.textOnly:
       return EdgeInsetsGeometry.all(0);
   }
 }
}
