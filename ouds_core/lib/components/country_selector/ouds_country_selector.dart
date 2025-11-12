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
/// OudsCountrySelector
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/country_selector/countries.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A custom widget for selecting a country from a list.
///
/// This widget displays a dropdown menu allowing the user to choose a country.
/// The list of countries can be filtered based on different criteria, and
/// the selection can be managed via a callback. It also supports a read-only mode.
///
/// Parameters:
/// - [onCountryChanged]: Function called when the user selects a new country.
/// - [countryFilter]: Filter to limit the list of countries (default: [CountryFilter.all]).
/// - [codes]: Optional list of allowed country codes. If [countryFilter] is set to custom,
///   this list is used to filter the displayed countries.
/// - [selectedCountry]: The default selected country. If null, the country matching the locale code is selected.
/// - [readOnly]: If true, disables user interaction, making the dropdown read-only, this value is related to readOnly of Input where you used.
///
/// Usage examples:
/// ```dart
/// // Example with custom filter and list of codes
/// CountrySelector(
///   onCountryChanged: (country) {
///     // Handle country change
///   },
///   countryFilter: CountryFilter.custom,
///   codes: ['FR', 'US', 'DE'],
///   readOnly: false, // or true to make it read-only
/// )
/// ```
///
/// ```dart
/// // Example without specific filter, full list
/// CountrySelector(
///   countryFilter: CountryFilter.all,
///   onCountryChanged: (country) {
///     // Handle country change
///   },
///   readOnly: true, // disables interaction
/// )
/// ```

class CountrySelector extends StatefulWidget {
  final bool? readOnly;
  final ValueChanged<Country>? onCountryChanged;
  final CountryFilter? countryFilter;
  final List<String>? codes;
  Country? selectedCountry = Country.empty();

  CountrySelector({
    super.key,
    this.readOnly,
    this.onCountryChanged,
    this.countryFilter,
    this.codes,
    this.selectedCountry,
  });

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

  /// Loads the list of countries based on the filter and codes.
  Future<void> loadCountries() async {
    String? countryCode = PlatformDispatcher.instance.locale.countryCode;
    List<Country> filteredCountries;

    if (widget.countryFilter == CountryFilter.custom && widget.codes != null) {
      // Filter by ISO codes using 'code'
      filteredCountries = CountryService().getCountriesByIsoCodes(widget.codes!);
    } else {
      // Filter according to the standard filter
      filteredCountries = CountryService().getCountries(filter: widget.countryFilter, codes: widget.codes);
    }

    setState(() {
      countries = filteredCountries;
    });

    if (countryCode != null && countryCode.isNotEmpty) {
      widget.selectedCountry = countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
        orElse: () => countries.isNotEmpty ? countries[0] : Country.empty(),
      );
    } else {
      widget.selectedCountry = countries.isNotEmpty ? countries[0] : Country.empty();
    }
  }

  /// Updates the selected country.
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
    final l10n = OudsLocalizations.of(context);
    final colorsScheme = OudsTheme.of(context).colorScheme;

    return Semantics(
      label: l10n?.core_phone_number_input_country_selector_a11y,
      hint: l10n?.core_phone_number_input_country_selector_hint_a11y,
      value: widget.selectedCountry?.name,
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsGeometry.only(
              left: textInput.spacePaddingInlineCountrySelectorStart,
              right: textInput.spacePaddingInlineCountrySelectorEnd,
            ),
            child: Center(
              child: DropdownButton<Country>(
                menuWidth: 320,
                //menuMaxHeight: 600,
                dropdownColor: colorsScheme(context).bgPrimary,
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
                        ExcludeSemantics(
                          child: SvgPicture.asset(
                            country.flagAsset,
                            fit: BoxFit.contain,
                            height: textInput.sizeCountrySelectorFlagHeight,
                            package: 'ouds_core',
                          ),
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
                        ExcludeSemantics(
                          child: SvgPicture.asset(
                            country.flagAsset,
                            fit: BoxFit.contain,
                            height: textInput.sizeCountrySelectorFlagHeight,
                            package: 'ouds_core',
                          ),
                        ),
                        Text(
                          country.name,
                          style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: colorsScheme(context).contentDefault),
                        ),
                        Text(
                          country.prefix,
                          style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: colorsScheme(context).contentDefault),
                        ),
                        if (country == widget.selectedCountry)
                          SvgPicture.asset(
                            excludeFromSemantics: true,
                            AppAssets.icons.checkboxSelected,
                            package: OudsTheme.of(context).packageName,
                            width: theme.spaceScheme(context).fixedLarge,
                            height: theme.spaceScheme(context).fixedLarge,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              colorsScheme(context).contentDefault,
                              BlendMode.srcIn,
                            ),
                          )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: widget.readOnly == false
                    ? (Country? newValue) {
                        if (newValue != null) {
                          updateSelection(newValue);
                        }
                      }
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: textInput.sizeVerticalDividerHeight,
            child: OudsDivider.vertical(length: 1),
          ),
        ],
      ),
    );
  }
}
