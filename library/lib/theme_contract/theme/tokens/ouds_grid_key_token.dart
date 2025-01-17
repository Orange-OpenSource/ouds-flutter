import 'package:ouds_flutter/theme_contract/theme/tokens/ouds_key_tokens.dart';

class OudsGridKeyToken extends OudsKeyToken {
  final String _name;
  final double _value;

  OudsGridKeyToken({required String name, required double value})
      : _name = name,
        _value = value;

  @override
  String get name => _name;

  @override
  double get value => _value;
}
