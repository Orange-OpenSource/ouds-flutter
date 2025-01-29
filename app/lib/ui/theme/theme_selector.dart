import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:theme_orange/orange_theme.dart';
import 'package:theme_orange_country/orange_country_theme.dart';
import 'package:theme_white_label/white_label_theme.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    final themeMode = themeController.themeMode;

    return Row(
      children: [
        /// Button to change the theme
        PopupMenuButton<String>(
          icon: Image.asset(
            'assets/ic_palette.png',
            width: 25,
            height: 25,
          ),
          onSelected: (String selectedValue) {
            if (selectedValue == OrangeTheme().name) {
              themeController.setTheme(OrangeTheme());
            } else if (selectedValue == WhiteLabelTheme().name) {
              themeController.setTheme(WhiteLabelTheme());
            } else if (selectedValue == OrangeCountryCustomTheme().name) {
              themeController.setTheme(OrangeCountryCustomTheme());
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              /// Menu Orange
              PopupMenuItem<String>(
                value: OrangeTheme().name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == OrangeTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(OrangeTheme().name),
                  ],
                ),
              ),

              /// Menu OrangeCountryCustom
              PopupMenuItem<String>(
                value: OrangeCountryCustomTheme().name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == OrangeCountryCustomTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(OrangeCountryCustomTheme().name),
                  ],
                ),
              ),

              /// Menu WhiteLabel
              PopupMenuItem<String>(
                value: WhiteLabelTheme().name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == WhiteLabelTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(WhiteLabelTheme().name),
                  ],
                ),
              ),
            ];
          },
        ),

        /// IconButton to change mode (Light/Dark/Auto)
        IconButton(
          icon: Icon(
            themeMode == ThemeMode.light
                ? Icons.wb_sunny

                /// Light mode
                : themeMode == ThemeMode.dark
                    ? Icons.nightlight_round

                    /// Dark mode
                    : Icons.brightness_auto,

            /// Auto mode
            size: 28,
          ),
          onPressed: () {
            /// Pass to light mode
            if (themeMode == ThemeMode.light) {
              themeController.setThemeMode(ThemeMode.dark);

              /// Pass to dark mode
            } else if (themeMode == ThemeMode.dark) {
              themeController.setThemeMode(ThemeMode.system);

              /// Pass to auto mode
            } else {
              themeController.setThemeMode(ThemeMode.light);
            }
          },
        ),
      ],
    );
  }
}
