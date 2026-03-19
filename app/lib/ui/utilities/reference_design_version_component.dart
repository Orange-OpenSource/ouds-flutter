import 'package:flutter/material.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/tag/ouds_tag_icon_status.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class ReferenceDesignVersionComponent extends StatelessWidget {
  final String version;

  const ReferenceDesignVersionComponent({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return Padding(
        padding: EdgeInsetsDirectional.all(
          themeController.currentTheme.spaceScheme(context).paddingBlockLarge,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.app_components_common_version_label,
              style: themeController.currentTheme.typographyTokens.typeLabelStrongLarge(context),
            ),
            Spacer(),
            OudsTag(label: version, tagIconStatus: Info(), appearance: OudsTagAppearance.muted, size: OudsTagSize.small)
          ],
        )
    );
  }
}
