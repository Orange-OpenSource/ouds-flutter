import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';

class OudsListItemLeadingWidget extends StatelessWidget {
  final OudsListItemLeading leading;

  const OudsListItemLeadingWidget({super.key, required this.leading});

  @override
  Widget build(BuildContext context) {
    return leading.toWidget(context);
  }
}
