import 'package:flutter/widgets.dart';
import 'package:ouds_flutter_demo/l10n/gen/ouds_flutter_app_localizations.dart';

export 'package:ouds_flutter_demo/l10n/gen/ouds_flutter_app_localizations.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
