import 'package:flutter/material.dart';
import 'package:ouds_core/ouds_theme.dart';
import 'package:ouds_flutter_demo/ui/components/divider/divider_customization.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_controller.dart';

class CustomizationDropdownMenu<T> extends StatefulWidget {
  final String label;
  final List<String> itemLabels;
  final int selectedItemIndex;
  final Function(T) onSelectionChange;
  final List<Widget Function()>? itemLeadingIcons;
  final T? selectedOption;

  const CustomizationDropdownMenu({
    super.key,
    required this.label,
    required this.itemLabels,
    required this.selectedItemIndex,
    required this.onSelectionChange,
    required this.selectedOption,
    this.itemLeadingIcons,
  });

  @override
  State<CustomizationDropdownMenu> createState() => _CustomizationDropdownMenuState();
}

class _CustomizationDropdownMenuState extends State<CustomizationDropdownMenu> {
  late int selectedIndex;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: themeController.currentTheme.fontTokens.sizeBodyLargeMobile,
              fontWeight: themeController.currentTheme.fontTokens.weightLabelStrong,
              letterSpacing: themeController.currentTheme.fontTokens.letterSpacingBodyLargeMobile,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
          child: DropdownMenu<String>(
            initialSelection: widget.itemLabels[selectedIndex],
            expandedInsets: EdgeInsets.zero,
            inputDecorationTheme: const InputDecorationTheme(isDense: true),
            textStyle: TextStyle(
              fontSize: OudsTheme.of(context).fontTokens.sizeBodyLargeMobile,
              fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
              letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingBodyLargeMobile,
            ),
            onSelected: (value) {
              if (value != null) {
                final index = widget.itemLabels.indexOf(value);
                setState(() {
                  selectedIndex = index;
                  widget.onSelectionChange(value);
                });

              }
            },
            leadingIcon: widget.itemLeadingIcons != null
                ? buildDropdownLeadingIcon(widget.itemLeadingIcons, selectedIndex)
                : null,
            dropdownMenuEntries:
            List.generate
              (widget.itemLabels.length, (index) {

                final label = widget.itemLabels[index];
                final iconBuilder = widget.itemLeadingIcons != null && index < widget.itemLeadingIcons!.length
                    ? widget.itemLeadingIcons![index]
                    : null;
                return DropdownMenuEntry<String>(
                  labelWidget: Text(label,
                    style: TextStyle(
                      fontSize: OudsTheme.of(context).fontTokens.sizeBodyLargeMobile,
                      fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
                      letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingBodyLargeMobile,
                    )
                  ),
                value: label,
                label: label,
                leadingIcon: iconBuilder != null
                    ?  iconBuilder()
                    : null,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget? buildDropdownLeadingIcon(List<Widget Function()>? builders, int index) {
    if (builders != null && index < builders.length) {
      return Padding(padding: EdgeInsetsDirectional.all(
          OudsTheme.of(context).spaceTokens.paddingInlineShort
      ),
      child: builders[index]());
    }
    return null;
  }
}
