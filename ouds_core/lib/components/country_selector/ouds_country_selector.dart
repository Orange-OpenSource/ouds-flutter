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
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class Country {
  final String code;
  final String name;
  final String prefix;
  final String flagEmoji;
  bool isSelected;

  Country({required this.code, required this.name, required this.prefix, required this.flagEmoji, this.isSelected = false});
}

// final List<Country> countries = [
//   Country(
//     code: 'FR',
//     name: 'France',
//     prefix: '+33',
//     flagUrl: 'flags/fr.svg',
//     isSelected: false,
//   ),
//   Country(
//     code: 'US',
//     name: 'United States',
//     prefix: '+1',
//     flagUrl: 'flags/us.svg',
//     isSelected: false,
//   ),
// ];

// Widget du Dropdown
class CountrySelector extends StatefulWidget {
  final ValueChanged<Country>? onCountryChanged;

  const CountrySelector({super.key, this.onCountryChanged});

  @override
  State<CountrySelector> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountrySelector> {
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    String? countryCode = PlatformDispatcher.instance.locale.countryCode;

    if (countryCode != null && countryCode.isNotEmpty) {
      selectedCountry = countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
        orElse: () => countries[0],
      );
    } else {
      selectedCountry = countries[0];
    }

    // 🔥 Notifie le parent après le build, pour éviter setState() during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedCountry != null) {
        widget.onCountryChanged?.call(selectedCountry!);
      }
    });
    print("prefix: ${selectedCountry!.prefix}");
  }

  void updateSelection(Country newCountry) {
    setState(() {
      // Réinitialiser tous les isSelected
      for (var country in countries) {
        country.isSelected = false;
      }
      newCountry.isSelected = true;
      selectedCountry = newCountry;
    });

    // 🔥 Notifie le parent avec le Country complet
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
            //isExpanded: true, // occupe toute la largeur
            //dropdownColor: Colors.amberAccent,
            menuWidth: 250,
            underline: SizedBox.shrink(),
            value: selectedCountry,
            icon: Icon(
              color: button.colorContentMinimalEnabled,
              Icons.keyboard_arrow_down,
            ),
            selectedItemBuilder: (BuildContext context) {
              return countries.map<Widget>((Country country) {
                return Row(
                  children: [
                    Text(
                      country.flagEmoji,
                      style: TextStyle(fontSize: textInput.sizeCountrySelectorFlagHeight),
                    ),
                    // SvgPicture.asset(
                    //   country.flagEmoji,
                    //   fit: BoxFit.contain,
                    //   package: OudsTheme.of(context).packageName,
                    //   height: textInput.sizeCountrySelectorFlagHeight,
                    // ),
                  ],
                );
              }).toList();
            },
            onChanged: (Country? newValue) {
              if (newValue != null) {
                updateSelection(newValue);
                //widget.onCountryChanged?.call(newValue);
              }
            },
            items: countries.map((Country country) {
              return DropdownMenuItem<Country>(
                value: country,
                child: Row(
                  spacing: textInput.spaceColumnGapInlineText,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SvgPicture.asset(
                    //   country.flagEmoji,
                    //   fit: BoxFit.contain,
                    //   package: OudsTheme.of(context).packageName,
                    //   height: textInput.sizeCountrySelectorFlagHeight,
                    // ),
                    Text(
                      country.flagEmoji,
                      style: TextStyle(fontSize: textInput.sizeCountrySelectorFlagHeight),
                    ),
                    Text(
                      country.name,
                      style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: button.colorContentMinimalEnabled),
                    ),
                    Text(
                      country.prefix,
                      style: theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: button.colorContentMinimalEnabled),
                    ),
                  ],
                ),
              );
            }).toList(),
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

final List<Country> countries = [
  Country(code: 'AF', name: 'Afghanistan', prefix: '+93', flagEmoji: '🇦🇫'),
  Country(code: 'AL', name: 'Albania', prefix: '+355', flagEmoji: '🇦🇱'),
  Country(code: 'DZ', name: 'Algeria', prefix: '+213', flagEmoji: '🇩🇿'),
  Country(code: 'AD', name: 'Andorra', prefix: '+376', flagEmoji: '🇦🇩'),
  Country(code: 'AO', name: 'Angola', prefix: '+244', flagEmoji: '🇦🇴'),
  Country(code: 'AG', name: 'Antigua and Barbuda', prefix: '+1-268', flagEmoji: '🇦🇬'),
  Country(code: 'AR', name: 'Argentina', prefix: '+54', flagEmoji: '🇦🇷'),
  Country(code: 'AM', name: 'Armenia', prefix: '+374', flagEmoji: '🇦🇲'),
  Country(code: 'AU', name: 'Australia', prefix: '+61', flagEmoji: '🇦🇺'),
  Country(code: 'AT', name: 'Austria', prefix: '+43', flagEmoji: '🇦🇹'),
  Country(code: 'AZ', name: 'Azerbaijan', prefix: '+994', flagEmoji: '🇦🇿'),
  Country(code: 'BS', name: 'Bahamas', prefix: '+1-242', flagEmoji: '🇧🇸'),
  Country(code: 'BH', name: 'Bahrain', prefix: '+973', flagEmoji: '🇧🇭'),
  Country(code: 'BD', name: 'Bangladesh', prefix: '+880', flagEmoji: '🇧🇩'),
  Country(code: 'BB', name: 'Barbados', prefix: '+1-246', flagEmoji: '🇧🇧'),
  Country(code: 'BY', name: 'Belarus', prefix: '+375', flagEmoji: '🇧🇾'),
  Country(code: 'BE', name: 'Belgium', prefix: '+32', flagEmoji: '🇧🇪'),
  Country(code: 'BZ', name: 'Belize', prefix: '+501', flagEmoji: '🇧🇿'),
  Country(code: 'BJ', name: 'Benin', prefix: '+229', flagEmoji: '🇧🇯'),
  Country(code: 'BT', name: 'Bhutan', prefix: '+975', flagEmoji: '🇧🇹'),
  Country(code: 'BO', name: 'Bolivia', prefix: '+591', flagEmoji: '🇧🇴'),
  Country(code: 'BA', name: 'Bosnia and Herzegovina', prefix: '+387', flagEmoji: '🇧🇦'),
  Country(code: 'BW', name: 'Botswana', prefix: '+267', flagEmoji: '🇧🇼'),
  Country(code: 'BR', name: 'Brazil', prefix: '+55', flagEmoji: '🇧🇷'),
  Country(code: 'BN', name: 'Brunei', prefix: '+673', flagEmoji: '🇧🇳'),
  Country(code: 'BG', name: 'Bulgaria', prefix: '+359', flagEmoji: '🇧🇬'),
  Country(code: 'BF', name: 'Burkina Faso', prefix: '+226', flagEmoji: '🇧🇫'),
  Country(code: 'BI', name: 'Burundi', prefix: '+257', flagEmoji: '🇧🇮'),
  Country(code: 'CV', name: 'Cabo Verde', prefix: '+238', flagEmoji: '🇨🇻'),
  Country(code: 'KH', name: 'Cambodia', prefix: '+855', flagEmoji: '🇰🇭'),
  Country(code: 'CM', name: 'Cameroon', prefix: '+237', flagEmoji: '🇨🇲'),
  Country(code: 'CA', name: 'Canada', prefix: '+1', flagEmoji: '🇨🇦'),
  Country(code: 'CF', name: 'Central African Republic', prefix: '+236', flagEmoji: '🇨🇫'),
  Country(code: 'TD', name: 'Chad', prefix: '+235', flagEmoji: '🇹🇩'),
  Country(code: 'CL', name: 'Chile', prefix: '+56', flagEmoji: '🇨🇱'),
  Country(code: 'CN', name: 'China', prefix: '+86', flagEmoji: '🇨🇳'),
  Country(code: 'CO', name: 'Colombia', prefix: '+57', flagEmoji: '🇨🇴'),
  Country(code: 'KM', name: 'Comoros', prefix: '+269', flagEmoji: '🇰🇲'),
  Country(code: 'CG', name: 'Congo', prefix: '+242', flagEmoji: '🇨🇬'),
  Country(code: 'CD', name: 'Congo (DRC)', prefix: '+243', flagEmoji: '🇨🇩'),
  Country(code: 'CR', name: 'Costa Rica', prefix: '+506', flagEmoji: '🇨🇷'),
  Country(code: 'CI', name: 'Côte d’Ivoire', prefix: '+225', flagEmoji: '🇨🇮'),
  Country(code: 'HR', name: 'Croatia', prefix: '+385', flagEmoji: '🇭🇷'),
  Country(code: 'CU', name: 'Cuba', prefix: '+53', flagEmoji: '🇨🇺'),
  Country(code: 'CY', name: 'Cyprus', prefix: '+357', flagEmoji: '🇨🇾'),
  Country(code: 'CZ', name: 'Czech Republic', prefix: '+420', flagEmoji: '🇨🇿'),
  Country(code: 'DK', name: 'Denmark', prefix: '+45', flagEmoji: '🇩🇰'),
  Country(code: 'DJ', name: 'Djibouti', prefix: '+253', flagEmoji: '🇩🇯'),
  Country(code: 'DM', name: 'Dominica', prefix: '+1-767', flagEmoji: '🇩🇲'),
  Country(code: 'DO', name: 'Dominican Republic', prefix: '+1-809', flagEmoji: '🇩🇴'),
  Country(code: 'EC', name: 'Ecuador', prefix: '+593', flagEmoji: '🇪🇨'),
  Country(code: 'EG', name: 'Egypt', prefix: '+20', flagEmoji: '🇪🇬'),
  Country(code: 'SV', name: 'El Salvador', prefix: '+503', flagEmoji: '🇸🇻'),
  Country(code: 'GQ', name: 'Equatorial Guinea', prefix: '+240', flagEmoji: '🇬🇶'),
  Country(code: 'ER', name: 'Eritrea', prefix: '+291', flagEmoji: '🇪🇷'),
  Country(code: 'EE', name: 'Estonia', prefix: '+372', flagEmoji: '🇪🇪'),
  Country(code: 'SZ', name: 'Eswatini', prefix: '+268', flagEmoji: '🇸🇿'),
  Country(code: 'ET', name: 'Ethiopia', prefix: '+251', flagEmoji: '🇪🇹'),
  Country(code: 'FJ', name: 'Fiji', prefix: '+679', flagEmoji: '🇫🇯'),
  Country(code: 'FI', name: 'Finland', prefix: '+358', flagEmoji: '🇫🇮'),
  Country(code: 'FR', name: 'France', prefix: '+33', flagEmoji: '🇫🇷'),
  Country(code: 'GA', name: 'Gabon', prefix: '+241', flagEmoji: '🇬🇦'),
  Country(code: 'GM', name: 'Gambia', prefix: '+220', flagEmoji: '🇬🇲'),
  Country(code: 'GE', name: 'Georgia', prefix: '+995', flagEmoji: '🇬🇪'),
  Country(code: 'DE', name: 'Germany', prefix: '+49', flagEmoji: '🇩🇪'),
  Country(code: 'GH', name: 'Ghana', prefix: '+233', flagEmoji: '🇬🇭'),
  Country(code: 'GR', name: 'Greece', prefix: '+30', flagEmoji: '🇬🇷'),
  Country(code: 'GD', name: 'Grenada', prefix: '+1-473', flagEmoji: '🇬🇩'),
  Country(code: 'GT', name: 'Guatemala', prefix: '+502', flagEmoji: '🇬🇹'),
  Country(code: 'GN', name: 'Guinea', prefix: '+224', flagEmoji: '🇬🇳'),
  Country(code: 'GW', name: 'Guinea-Bissau', prefix: '+245', flagEmoji: '🇬🇼'),
  Country(code: 'GY', name: 'Guyana', prefix: '+592', flagEmoji: '🇬🇾'),
  Country(code: 'HT', name: 'Haiti', prefix: '+509', flagEmoji: '🇭🇹'),
  Country(code: 'HN', name: 'Honduras', prefix: '+504', flagEmoji: '🇭🇳'),
  Country(code: 'HU', name: 'Hungary', prefix: '+36', flagEmoji: '🇭🇺'),
  Country(code: 'IS', name: 'Iceland', prefix: '+354', flagEmoji: '🇮🇸'),
  Country(code: 'IN', name: 'India', prefix: '+91', flagEmoji: '🇮🇳'),
  Country(code: 'ID', name: 'Indonesia', prefix: '+62', flagEmoji: '🇮🇩'),
  Country(code: 'IR', name: 'Iran', prefix: '+98', flagEmoji: '🇮🇷'),
  Country(code: 'IQ', name: 'Iraq', prefix: '+964', flagEmoji: '🇮🇶'),
  Country(code: 'IE', name: 'Ireland', prefix: '+353', flagEmoji: '🇮🇪'),
  Country(code: 'IL', name: 'Israel', prefix: '+972', flagEmoji: '🇮🇱'),
  Country(code: 'IT', name: 'Italy', prefix: '+39', flagEmoji: '🇮🇹'),
  Country(code: 'JM', name: 'Jamaica', prefix: '+1-876', flagEmoji: '🇯🇲'),
  Country(code: 'JP', name: 'Japan', prefix: '+81', flagEmoji: '🇯🇵'),
  Country(code: 'JO', name: 'Jordan', prefix: '+962', flagEmoji: '🇯🇴'),
  Country(code: 'KZ', name: 'Kazakhstan', prefix: '+7', flagEmoji: '🇰🇿'),
  Country(code: 'KE', name: 'Kenya', prefix: '+254', flagEmoji: '🇰🇪'),
  Country(code: 'KI', name: 'Kiribati', prefix: '+686', flagEmoji: '🇰🇮'),
  Country(code: 'KR', name: 'South Korea', prefix: '+82', flagEmoji: '🇰🇷'),
  Country(code: 'KW', name: 'Kuwait', prefix: '+965', flagEmoji: '🇰🇼'),
  Country(code: 'KG', name: 'Kyrgyzstan', prefix: '+996', flagEmoji: '🇰🇬'),
  Country(code: 'LA', name: 'Laos', prefix: '+856', flagEmoji: '🇱🇦'),
  Country(code: 'LV', name: 'Latvia', prefix: '+371', flagEmoji: '🇱🇻'),
  Country(code: 'LB', name: 'Lebanon', prefix: '+961', flagEmoji: '🇱🇧'),
  Country(code: 'LS', name: 'Lesotho', prefix: '+266', flagEmoji: '🇱🇸'),
  Country(code: 'LR', name: 'Liberia', prefix: '+231', flagEmoji: '🇱🇷'),
  Country(code: 'LY', name: 'Libya', prefix: '+218', flagEmoji: '🇱🇾'),
  Country(code: 'LI', name: 'Liechtenstein', prefix: '+423', flagEmoji: '🇱🇮'),
  Country(code: 'LT', name: 'Lithuania', prefix: '+370', flagEmoji: '🇱🇹'),
  Country(code: 'LU', name: 'Luxembourg', prefix: '+352', flagEmoji: '🇱🇺'),
  Country(code: 'MG', name: 'Madagascar', prefix: '+261', flagEmoji: '🇲🇬'),
  Country(code: 'MW', name: 'Malawi', prefix: '+265', flagEmoji: '🇲🇼'),
  Country(code: 'MY', name: 'Malaysia', prefix: '+60', flagEmoji: '🇲🇾'),
  Country(code: 'MV', name: 'Maldives', prefix: '+960', flagEmoji: '🇲🇻'),
  Country(code: 'ML', name: 'Mali', prefix: '+223', flagEmoji: '🇲🇱'),
  Country(code: 'MT', name: 'Malta', prefix: '+356', flagEmoji: '🇲🇹'),
  Country(code: 'MH', name: 'Marshall Islands', prefix: '+692', flagEmoji: '🇲🇭'),
  Country(code: 'MR', name: 'Mauritania', prefix: '+222', flagEmoji: '🇲🇷'),
  Country(code: 'MU', name: 'Mauritius', prefix: '+230', flagEmoji: '🇲🇺'),
  Country(code: 'MX', name: 'Mexico', prefix: '+52', flagEmoji: '🇲🇽'),
  Country(code: 'FM', name: 'Micronesia', prefix: '+691', flagEmoji: '🇫🇲'),
  Country(code: 'MD', name: 'Moldova', prefix: '+373', flagEmoji: '🇲🇩'),
  Country(code: 'MC', name: 'Monaco', prefix: '+377', flagEmoji: '🇲🇨'),
  Country(code: 'MN', name: 'Mongolia', prefix: '+976', flagEmoji: '🇲🇳'),
  Country(code: 'ME', name: 'Montenegro', prefix: '+382', flagEmoji: '🇲🇪'),
  Country(code: 'MA', name: 'Morocco', prefix: '+212', flagEmoji: '🇲🇦'),
  Country(code: 'MZ', name: 'Mozambique', prefix: '+258', flagEmoji: '🇲🇿'),
  Country(code: 'MM', name: 'Myanmar', prefix: '+95', flagEmoji: '🇲🇲'),
  Country(code: 'NA', name: 'Namibia', prefix: '+264', flagEmoji: '🇳🇦'),
  Country(code: 'NR', name: 'Nauru', prefix: '+674', flagEmoji: '🇳🇷'),
  Country(code: 'NP', name: 'Nepal', prefix: '+977', flagEmoji: '🇳🇵'),
  Country(code: 'NL', name: 'Netherlands', prefix: '+31', flagEmoji: '🇳🇱'),
  Country(code: 'NZ', name: 'New Zealand', prefix: '+64', flagEmoji: '🇳🇿'),
  Country(code: 'NI', name: 'Nicaragua', prefix: '+505', flagEmoji: '🇳🇮'),
  Country(code: 'NE', name: 'Niger', prefix: '+227', flagEmoji: '🇳🇪'),
  Country(code: 'NG', name: 'Nigeria', prefix: '+234', flagEmoji: '🇳🇬'),
  Country(code: 'NO', name: 'Norway', prefix: '+47', flagEmoji: '🇳🇴'),
  Country(code: 'OM', name: 'Oman', prefix: '+968', flagEmoji: '🇴🇲'),
  Country(code: 'PK', name: 'Pakistan', prefix: '+92', flagEmoji: '🇵🇰'),
  Country(code: 'PW', name: 'Palau', prefix: '+680', flagEmoji: '🇵🇼'),
  Country(code: 'PA', name: 'Panama', prefix: '+507', flagEmoji: '🇵🇦'),
  Country(code: 'PG', name: 'Papua New Guinea', prefix: '+675', flagEmoji: '🇵🇬'),
  Country(code: 'PY', name: 'Paraguay', prefix: '+595', flagEmoji: '🇵🇾'),
  Country(code: 'PE', name: 'Peru', prefix: '+51', flagEmoji: '🇵🇪'),
  Country(code: 'PH', name: 'Philippines', prefix: '+63', flagEmoji: '🇵🇭'),
  Country(code: 'PL', name: 'Poland', prefix: '+48', flagEmoji: '🇵🇱'),
  Country(code: 'PT', name: 'Portugal', prefix: '+351', flagEmoji: '🇵🇹'),
  Country(code: 'QA', name: 'Qatar', prefix: '+974', flagEmoji: '🇶🇦'),
  Country(code: 'RO', name: 'Romania', prefix: '+40', flagEmoji: '🇷🇴'),
  Country(code: 'RU', name: 'Russia', prefix: '+7', flagEmoji: '🇷🇺'),
  Country(code: 'RW', name: 'Rwanda', prefix: '+250', flagEmoji: '🇷🇼'),
  Country(code: 'KN', name: 'Saint Kitts and Nevis', prefix: '+1-869', flagEmoji: '🇰🇳'),
  Country(code: 'LC', name: 'Saint Lucia', prefix: '+1-758', flagEmoji: '🇱🇨'),
  Country(code: 'VC', name: 'Saint Vincent and the Grenadines', prefix: '+1-784', flagEmoji: '🇻🇨'),
  Country(code: 'WS', name: 'Samoa', prefix: '+685', flagEmoji: '🇼🇸'),
  Country(code: 'SM', name: 'San Marino', prefix: '+378', flagEmoji: '🇸🇲'),
  Country(code: 'ST', name: 'Sao Tome and Principe', prefix: '+239', flagEmoji: '🇸🇹'),
  Country(code: 'SA', name: 'Saudi Arabia', prefix: '+966', flagEmoji: '🇸🇦'),
  Country(code: 'SN', name: 'Senegal', prefix: '+221', flagEmoji: '🇸🇳'),
  Country(code: 'RS', name: 'Serbia', prefix: '+381', flagEmoji: '🇷🇸'),
  Country(code: 'SC', name: 'Seychelles', prefix: '+248', flagEmoji: '🇸🇨'),
  Country(code: 'SL', name: 'Sierra Leone', prefix: '+232', flagEmoji: '🇸🇱'),
  Country(code: 'SG', name: 'Singapore', prefix: '+65', flagEmoji: '🇸🇬'),
  Country(code: 'SK', name: 'Slovakia', prefix: '+421', flagEmoji: '🇸🇰'),
  Country(code: 'SI', name: 'Slovenia', prefix: '+386', flagEmoji: '🇸🇮'),
  Country(code: 'SB', name: 'Solomon Islands', prefix: '+677', flagEmoji: '🇸🇧'),
  Country(code: 'SO', name: 'Somalia', prefix: '+252', flagEmoji: '🇸🇴'),
  Country(code: 'ZA', name: 'South Africa', prefix: '+27', flagEmoji: '🇿🇦'),
  Country(code: 'SS', name: 'South Sudan', prefix: '+211', flagEmoji: '🇸🇸'),
  Country(code: 'ES', name: 'Spain', prefix: '+34', flagEmoji: '🇪🇸'),
  Country(code: 'LK', name: 'Sri Lanka', prefix: '+94', flagEmoji: '🇱🇰'),
  Country(code: 'SD', name: 'Sudan', prefix: '+249', flagEmoji: '🇸🇩'),
  Country(code: 'SR', name: 'Suriname', prefix: '+597', flagEmoji: '🇸🇷'),
  Country(code: 'SE', name: 'Sweden', prefix: '+46', flagEmoji: '🇸🇪'),
  Country(code: 'CH', name: 'Switzerland', prefix: '+41', flagEmoji: '🇨🇭'),
  Country(code: 'SY', name: 'Syria', prefix: '+963', flagEmoji: '🇸🇾'),
  Country(code: 'TJ', name: 'Tajikistan', prefix: '+992', flagEmoji: '🇹🇯'),
  Country(code: 'TZ', name: 'Tanzania', prefix: '+255', flagEmoji: '🇹🇿'),
  Country(code: 'TH', name: 'Thailand', prefix: '+66', flagEmoji: '🇹🇭'),
  Country(code: 'TL', name: 'Timor-Leste', prefix: '+670', flagEmoji: '🇹🇱'),
  Country(code: 'TG', name: 'Togo', prefix: '+228', flagEmoji: '🇹🇬'),
  Country(code: 'TO', name: 'Tonga', prefix: '+676', flagEmoji: '🇹🇴'),
  Country(code: 'TT', name: 'Trinidad and Tobago', prefix: '+1-868', flagEmoji: '🇹🇹'),
  Country(code: 'TN', name: 'Tunisia', prefix: '+216', flagEmoji: '🇹🇳'),
  Country(code: 'TR', name: 'Turkey', prefix: '+90', flagEmoji: '🇹🇷'),
  Country(code: 'TM', name: 'Turkmenistan', prefix: '+993', flagEmoji: '🇹🇲'),
  Country(code: 'TV', name: 'Tuvalu', prefix: '+688', flagEmoji: '🇹🇻'),
  Country(code: 'UG', name: 'Uganda', prefix: '+256', flagEmoji: '🇺🇬'),
  Country(code: 'UA', name: 'Ukraine', prefix: '+380', flagEmoji: '🇺🇦'),
  Country(code: 'AE', name: 'United Arab Emirates', prefix: '+971', flagEmoji: '🇦🇪'),
  Country(code: 'GB', name: 'United Kingdom', prefix: '+44', flagEmoji: '🇬🇧'),
  Country(code: 'US', name: 'United States', prefix: '+1', flagEmoji: '🇺🇸'),
  Country(code: 'UY', name: 'Uruguay', prefix: '+598', flagEmoji: '🇺🇾'),
  Country(code: 'UZ', name: 'Uzbekistan', prefix: '+998', flagEmoji: '🇺🇿'),
  Country(code: 'VU', name: 'Vanuatu', prefix: '+678', flagEmoji: '🇻🇺'),
  Country(code: 'VA', name: 'Vatican City', prefix: '+379', flagEmoji: '🇻🇦'),
  Country(code: 'VE', name: 'Venezuela', prefix: '+58', flagEmoji: '🇻🇪'),
  Country(code: 'VN', name: 'Vietnam', prefix: '+84', flagEmoji: '🇻🇳'),
  Country(code: 'YE', name: 'Yemen', prefix: '+967', flagEmoji: '🇾🇪'),
  Country(code: 'ZM', name: 'Zambia', prefix: '+260', flagEmoji: '🇿🇲'),
  Country(code: 'ZW', name: 'Zimbabwe', prefix: '+263', flagEmoji: '🇿🇼'),
];
