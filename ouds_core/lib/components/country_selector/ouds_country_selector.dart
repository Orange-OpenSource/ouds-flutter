/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

// Widget du Dropdown
class CountrySelector extends StatefulWidget {
  final ValueChanged<Country>? onCountryChanged;
  final CountryFilter? countryFilter;
  final List<String>? codes;
  Country? selectedCountry = Country.empty();

  CountrySelector({super.key, this.onCountryChanged, this.countryFilter, this.codes, this.selectedCountry});

  @override
  State<CountrySelector> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountrySelector> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    loadCountries();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedCountry != null) {
        widget.onCountryChanged?.call(widget.selectedCountry!);
      }
    });
  }

  Future<void> loadCountries() async {
    String? countryCode = PlatformDispatcher.instance.locale.countryCode;
    countries = CountryService().getCountries(filter: widget.countryFilter, codes: widget.codes);
    if (countryCode != null && countryCode.isNotEmpty) {
      widget.selectedCountry = countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
        orElse: () => countries[0],
      );
    } else {
      widget.selectedCountry = countries[0];
    }
  }

  void updateSelection(Country newCountry) {
    setState(() {
      for (var country in countries) {
        country.isSelected = false;
      }
      newCountry.isSelected = true;
      widget.selectedCountry = newCountry;
    });
    widget.onCountryChanged?.call(newCountry);
  }

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final textInput = theme.componentsTokens(context).textInput;
    final button = theme.componentsTokens(context).button;

    return Row(
      children: [
        Container(
          padding: EdgeInsetsGeometry.directional(
            start: textInput.spacePaddingInlineCountrySelectorStart,
            end: textInput.spacePaddingInlineCountrySelectorEnd,
          ),
          child: DropdownButton<Country>(
            menuWidth: 350,
            underline: SizedBox.shrink(),
            value: widget.selectedCountry,
            icon: Icon(
              color: button.colorContentMinimalEnabled,
              Icons.keyboard_arrow_down,
            ),
            selectedItemBuilder: (BuildContext context) {
              return countries.map<Widget>((Country country) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      country.flagAsset,
                      fit: BoxFit.contain,
                      height: textInput.sizeCountrySelectorFlagHeight,
                      package: 'ouds_core',
                    ),
                  ],
                );
              }).toList();
            },
            items: countries.map((Country country) {
              return DropdownMenuItem<Country>(
                value: country,
                child: Row(
                  spacing: textInput.spaceColumnGapInlineText,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      country.flagAsset,
                      fit: BoxFit.contain,
                      height: textInput.sizeCountrySelectorFlagHeight,
                      package: 'ouds_core',
                    ),
                    Text(
                      country.name,
                      style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: button.colorContentBrandEnabled),
                    ),
                    Text(
                      country.prefix,
                      style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: button.colorContentBrandEnabled),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (Country? newValue) {
              if (newValue != null) {
                updateSelection(newValue);
                //widget.onCountryChanged?.call(newValue);
              }
            },
          ),
        ),
        SizedBox(
          height: textInput.sizeVerticalDividerHeight,
          child: OudsDivider.vertical(length: 1),
        ),
      ],
    );
  }
}
