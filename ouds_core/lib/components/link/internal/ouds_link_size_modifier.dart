import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_core/components/link/ouds_link.dart';

/// Enum representing the state of the Link control.
enum OudsLinkDimensions {
  width,
  height,
}

class OudsLinkSizeModifier {
  final BuildContext context;

  OudsLinkSizeModifier(this.context);

  /// Retrieves the min width and min height (double) for the Link based on the provided size enum.
  Map<String,double?> getMinWidthAndHeight(OudsLinkSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).link;

    if(size == OudsLinkSize.small) {
      return {OudsLinkDimensions.width.name : theme.sizeMinWidthSmall, OudsLinkDimensions.height.name : theme.sizeMinHeightSmall};
    }else{
      return {OudsLinkDimensions.width.name : theme.sizeMinWidthDefault, OudsLinkDimensions.height.name : theme.sizeMinHeightDefault};
    }
  }

  /// Retrieves the width and height of icon/ chevron (double) for the Link based on the provided size enum.
  Map<String,double?> getIconSize(OudsLinkSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).link;

    if(size == OudsLinkSize.small) {
      return {OudsLinkDimensions.width.name : theme.sizeIconSmall, OudsLinkDimensions.height.name : theme.sizeIconSmall};
    }else{
      return {OudsLinkDimensions.width.name : theme.sizeIconDefault, OudsLinkDimensions.height.name : theme.sizeIconDefault};
    }
  }

  /// Retrieves the spaceColumnGap (double) for the Link based on the provided size enum.
  double? getSizeColumnGap(OudsLinkSize? size, OudsLinkLayout layout) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;

    switch(layout){
      case OudsLinkLayout.textAndIcon :
        return size == OudsLinkSize.small
            ? linkToken.spaceColumnGapIconSmall
            : linkToken.spaceColumnGapIconDefault;
      case OudsLinkLayout.textOnly:
        throw UnimplementedError("Error status for textOnly ColumnGap is not relevant");
      case OudsLinkLayout.back:
      case OudsLinkLayout.next:
        return size == OudsLinkSize.small
            ? linkToken.spaceColumnGapChevronSmall
            : linkToken.spaceColumnGapChevronDefault;
    }
  }
}

