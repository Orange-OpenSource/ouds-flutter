import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class ReferenceDesignVersionComponent extends StatelessWidget {
  final String version;

  const ReferenceDesignVersionComponent({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    ThemeController? themeController = Provider.of<ThemeController>(context, listen: false);
    return Text(
      '${context.l10n.app_components_common_version} $version',
      style: themeController.currentTheme.typographyTokens.typeLabelDefaultSmall(context),
    );
  }
}
