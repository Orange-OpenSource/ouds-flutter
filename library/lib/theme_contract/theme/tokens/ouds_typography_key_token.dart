import 'package:flutter/material.dart';
import 'package:ouds_flutter/theme_contract/theme/tokens/ouds_key_tokens.dart';

class OudsTypographyKeyToken extends OudsKeyToken {
  final String _name;
  final TextStyle _value;

  OudsTypographyKeyToken({required String name, required TextStyle value})
      : _name = name,
        _value = value;

  @override
  String get name => _name;

  @override
  TextStyle get value => _value;
}
