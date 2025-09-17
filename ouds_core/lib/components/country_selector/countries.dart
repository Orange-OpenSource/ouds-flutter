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

/// Enum representing the available continent filters for country selection.
/// Use `all` to include every country, or select a specific continent.
enum CountryFilter {
  all,
  africa,
  asia,
  europe,
  northAmerica,
  oceania,
  southAmerica,
  antarctica,
}

class Country {
  final String name;
  final String code;
  final String flagAsset;
  final String continent;
  late final String prefix;
  bool isSelected;

  Country({
    required this.name,
    required this.code,
    required this.flagAsset,
    required this.continent,
    required this.prefix,
    this.isSelected = false,
  });

  factory Country.empty() {
    return Country(
      name: "",
      code: PlatformDispatcher.instance.locale.countryCode ?? "fr",
      flagAsset: "",
      continent: "",
      prefix: "",
    );
  }
}

/// Returns a list of countries filtered either by a list of country codes (if provided) or by continent (using the filter enum).
/// If neither is specified, returns all countries.
class CountryService {
  List<Country> getCountries({
    CountryFilter? filter,
    List<String>? codes,
  }) {
    if (codes != null && codes.isNotEmpty) {
      return countries.where((country) => codes.any((code) => code == country.code)).toList();
    }

    if (filter != CountryFilter.all) {
      String continentStr = filter.toString().split('.').last.toLowerCase().replaceAll(' ', '');
      return countries.where((country) => country.continent.replaceAll(' ', '').toLowerCase() == continentStr).toList();
    }

    return countries;
  }

  Country? findCountryByPrefix(String prefix) {
    // Assurez que le préfixe commence par '+'
    if (!prefix.startsWith('+')) {
      prefix = '+$prefix';
    }

    // Rechercher dans la liste
    for (var country in countries) {
      if (country.prefix == prefix) {
        return country; // ou 'iso' selon ce que vous souhaitez
      }
    }
    return null; // Si pas trouvé
  }
}

final List<Country> countries = [
  Country(name: "Afghanistan", code: "af", continent: "Asia", prefix: "+93", flagAsset: "assets/flags/af.svg"),
  Country(name: "Aland Islands", code: "ax", continent: "Europe", prefix: "+358", flagAsset: "assets/flags/ax.svg"),
  Country(name: "Albania", code: "al", continent: "Europe", prefix: "+355", flagAsset: "assets/flags/al.svg"),
  Country(name: "Algeria", code: "dz", continent: "Africa", prefix: "+213", flagAsset: "assets/flags/dz.svg"),
  Country(name: "American Samoa", code: "as", continent: "Oceania", prefix: "+1-684", flagAsset: "assets/flags/as.svg"),
  Country(name: "Andorra", code: "ad", continent: "Europe", prefix: "+376", flagAsset: "assets/flags/ad.svg"),
  Country(name: "Angola", code: "ao", continent: "Africa", prefix: "+244", flagAsset: "assets/flags/ao.svg"),
  Country(name: "Anguilla", code: "ai", continent: "North America", prefix: "+1-264", flagAsset: "assets/flags/ai.svg"),
  Country(name: "Antigua and Barbuda", code: "ag", continent: "North America", prefix: "+1-268", flagAsset: "assets/flags/ag.svg"),
  Country(name: "Argentina", code: "ar", continent: "South America", prefix: "+54", flagAsset: "assets/flags/ar.svg"),
  Country(name: "Armenia", code: "am", continent: "Asia", prefix: "+374", flagAsset: "assets/flags/am.svg"),
  Country(name: "Aruba", code: "aw", continent: "South America", prefix: "+297", flagAsset: "assets/flags/aw.svg"),
  Country(name: "Ascension Island", code: "sh-ac", continent: "Africa", prefix: "+247", flagAsset: "assets/flags/sh-ac.svg"),
  Country(name: "Australia", code: "au", continent: "Oceania", prefix: "+61", flagAsset: "assets/flags/au.svg"),
  Country(name: "Austria", code: "at", continent: "Europe", prefix: "+43", flagAsset: "assets/flags/at.svg"),
  Country(name: "Azerbaijan", code: "az", continent: "Asia", prefix: "+994", flagAsset: "assets/flags/az.svg"),
  Country(name: "Bahamas", code: "bs", continent: "North America", prefix: "+1-242", flagAsset: "assets/flags/bs.svg"),
  Country(name: "Bahrain", code: "bh", continent: "Asia", prefix: "+973", flagAsset: "assets/flags/bh.svg"),
  Country(name: "Bangladesh", code: "bd", continent: "Asia", prefix: "+880", flagAsset: "assets/flags/bd.svg"),
  Country(name: "Barbados", code: "bb", continent: "North America", prefix: "+1-246", flagAsset: "assets/flags/bb.svg"),
  Country(name: "Belarus", code: "by", continent: "Europe", prefix: "+375", flagAsset: "assets/flags/by.svg"),
  Country(name: "Belgium", code: "be", continent: "Europe", prefix: "+32", flagAsset: "assets/flags/be.svg"),
  Country(name: "Belize", code: "bz", continent: "North America", prefix: "+501", flagAsset: "assets/flags/bz.svg"),
  Country(name: "Benin", code: "bj", continent: "Africa", prefix: "+229", flagAsset: "assets/flags/bj.svg"),
  Country(name: "Bermuda", code: "bm", continent: "North America", prefix: "+1-441", flagAsset: "assets/flags/bm.svg"),
  Country(name: "Bhutan", code: "bt", continent: "Asia", prefix: "+975", flagAsset: "assets/flags/bt.svg"),
  Country(name: "Bolivia", code: "bo", continent: "South America", prefix: "+591", flagAsset: "assets/flags/bo.svg"),
  Country(name: "Bonaire, Sint Eustatius and Saba", code: "bq", continent: "South America", prefix: "+599", flagAsset: "assets/flags/bq.svg"),
  Country(name: "Bosnia and Herzegovina", code: "ba", continent: "Europe", prefix: "+387", flagAsset: "assets/flags/ba.svg"),
  Country(name: "Botswana", code: "bw", continent: "Africa", prefix: "+267", flagAsset: "assets/flags/bw.svg"),
  Country(name: "Bouvet Island", code: "bv", continent: "Antarctica", prefix: "+47", flagAsset: "assets/flags/bv.svg"),
  Country(name: "Brazil", code: "br", continent: "South America", prefix: "+55", flagAsset: "assets/flags/br.svg"),
  Country(name: "British Indian Ocean Territory", code: "io", continent: "Asia", prefix: "+246", flagAsset: "assets/flags/io.svg"),
  Country(name: "Brunei Darussalam", code: "bn", continent: "Asia", prefix: "+673", flagAsset: "assets/flags/bn.svg"),
  Country(name: "Bulgaria", code: "bg", continent: "Europe", prefix: "+359", flagAsset: "assets/flags/bg.svg"),
  Country(name: "Burkina Faso", code: "bf", continent: "Africa", prefix: "+226", flagAsset: "assets/flags/bf.svg"),
  Country(name: "Burundi", code: "bi", continent: "Africa", prefix: "+257", flagAsset: "assets/flags/bi.svg"),
  Country(name: "Cabo Verde", code: "cv", continent: "Africa", prefix: "+238", flagAsset: "assets/flags/cv.svg"),
  Country(name: "Cambodia", code: "kh", continent: "Asia", prefix: "+855", flagAsset: "assets/flags/kh.svg"),
  Country(name: "Cameroon", code: "cm", continent: "Africa", prefix: "+237", flagAsset: "assets/flags/cm.svg"),
  Country(name: "Canada", code: "ca", continent: "North America", prefix: "+1", flagAsset: "assets/flags/ca.svg"),
  Country(name: "Cayman Islands", code: "ky", continent: "North America", prefix: "+1-345", flagAsset: "assets/flags/ky.svg"),
  Country(name: "Central African Republic", code: "cf", continent: "Africa", prefix: "+236", flagAsset: "assets/flags/cf.svg"),
  Country(name: "Chad", code: "td", continent: "Africa", prefix: "+235", flagAsset: "assets/flags/td.svg"),
  Country(name: "Chile", code: "cl", continent: "South America", prefix: "+56", flagAsset: "assets/flags/cl.svg"),
  Country(name: "China", code: "cn", continent: "Asia", prefix: "+86", flagAsset: "assets/flags/cn.svg"),
  Country(name: "Christmas Island", code: "cx", continent: "Asia", prefix: "+61", flagAsset: "assets/flags/cx.svg"),
  Country(name: "Cocos (Keeling) Islands", code: "cc", continent: "Asia", prefix: "+61", flagAsset: "assets/flags/cc.svg"),
  Country(name: "Colombia", code: "co", continent: "South America", prefix: "+57", flagAsset: "assets/flags/co.svg"),
  Country(name: "Comoros", code: "km", continent: "Africa", prefix: "+269", flagAsset: "assets/flags/km.svg"),
  Country(name: "Cook Islands", code: "ck", continent: "Oceania", prefix: "+682", flagAsset: "assets/flags/ck.svg"),
  Country(name: "Costa Rica", code: "cr", continent: "North America", prefix: "+506", flagAsset: "assets/flags/cr.svg"),
  Country(name: "Croatia", code: "hr", continent: "Europe", prefix: "+385", flagAsset: "assets/flags/hr.svg"),
  Country(name: "Cuba", code: "cu", continent: "North America", prefix: "+53", flagAsset: "assets/flags/cu.svg"),
  Country(name: "Curaçao", code: "cw", continent: "South America", prefix: "+599", flagAsset: "assets/flags/cw.svg"),
  Country(name: "Cyprus", code: "cy", continent: "Europe", prefix: "+357", flagAsset: "assets/flags/cy.svg"),
  Country(name: "Czech Republic", code: "cz", continent: "Europe", prefix: "+420", flagAsset: "assets/flags/cz.svg"),
  Country(name: "Côte d'Ivoire", code: "ci", continent: "Africa", prefix: "+225", flagAsset: "assets/flags/ci.svg"),
  Country(name: "Democratic Republic of the Congo", code: "cd", continent: "Africa", prefix: "+243", flagAsset: "assets/flags/cd.svg"),
  Country(name: "Denmark", code: "dk", continent: "Europe", prefix: "+45", flagAsset: "assets/flags/dk.svg"),
  Country(name: "Djibouti", code: "dj", continent: "Africa", prefix: "+253", flagAsset: "assets/flags/dj.svg"),
  Country(name: "Dominica", code: "dm", continent: "North America", prefix: "+1-767", flagAsset: "assets/flags/dm.svg"),
  Country(name: "Dominican Republic", code: "do", continent: "North America", prefix: "+1-809", flagAsset: "assets/flags/do.svg"),
  Country(name: "Ecuador", code: "ec", continent: "South America", prefix: "+593", flagAsset: "assets/flags/ec.svg"),
  Country(name: "Egypt", code: "eg", continent: "Africa", prefix: "+20", flagAsset: "assets/flags/eg.svg"),
  Country(name: "El Salvador", code: "sv", continent: "North America", prefix: "+503", flagAsset: "assets/flags/sv.svg"),
  Country(name: "England", code: "gb-eng", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/gb-eng.svg"),
  Country(name: "Equatorial Guinea", code: "gq", continent: "Africa", prefix: "+240", flagAsset: "assets/flags/gq.svg"),
  Country(name: "Eritrea", code: "er", continent: "Africa", prefix: "+291", flagAsset: "assets/flags/er.svg"),
  Country(name: "Estonia", code: "ee", continent: "Europe", prefix: "+372", flagAsset: "assets/flags/ee.svg"),
  Country(name: "Eswatini", code: "sz", continent: "Africa", prefix: "+268", flagAsset: "assets/flags/sz.svg"),
  Country(name: "Ethiopia", code: "et", continent: "Africa", prefix: "+251", flagAsset: "assets/flags/et.svg"),
  Country(name: "Falkland Islands", code: "fk", continent: "South America", prefix: "+500", flagAsset: "assets/flags/fk.svg"),
  Country(name: "Faroe Islands", code: "fo", continent: "Europe", prefix: "+298", flagAsset: "assets/flags/fo.svg"),
  Country(name: "Federated States of Micronesia", code: "fm", continent: "Oceania", prefix: "+691", flagAsset: "assets/flags/fm.svg"),
  Country(name: "Fiji", code: "fj", continent: "Oceania", prefix: "+679", flagAsset: "assets/flags/fj.svg"),
  Country(name: "Finland", code: "fi", continent: "Europe", prefix: "+358", flagAsset: "assets/flags/fi.svg"),
  Country(name: "France", code: "fr", continent: "Europe", prefix: "+33", flagAsset: "assets/flags/fr.svg"),
  Country(name: "French Guiana", code: "gf", continent: "South America", prefix: "+594", flagAsset: "assets/flags/gf.svg"),
  Country(name: "French Polynesia", code: "pf", continent: "Oceania", prefix: "+689", flagAsset: "assets/flags/pf.svg"),
  Country(name: "French Southern Territories", code: "tf", continent: "Africa", prefix: "+262", flagAsset: "assets/flags/tf.svg"),
  Country(name: "Gabon", code: "ga", continent: "Africa", prefix: "+241", flagAsset: "assets/flags/ga.svg"),
  Country(name: "Galicia", code: "es-ga", continent: "Europe", prefix: "+34", flagAsset: "assets/flags/es-ga.svg"),
  Country(name: "Gambia", code: "gm", continent: "Africa", prefix: "+220", flagAsset: "assets/flags/gm.svg"),
  Country(name: "Georgia", code: "ge", continent: "Asia", prefix: "+995", flagAsset: "assets/flags/ge.svg"),
  Country(name: "Germany", code: "de", continent: "Europe", prefix: "+49", flagAsset: "assets/flags/de.svg"),
  Country(name: "Ghana", code: "gh", continent: "Africa", prefix: "+233", flagAsset: "assets/flags/gh.svg"),
  Country(name: "Gibraltar", code: "gi", continent: "Europe", prefix: "+350", flagAsset: "assets/flags/gi.svg"),
  Country(name: "Greece", code: "gr", continent: "Europe", prefix: "+30", flagAsset: "assets/flags/gr.svg"),
  Country(name: "Greenland", code: "gl", continent: "North America", prefix: "+299", flagAsset: "assets/flags/gl.svg"),
  Country(name: "Grenada", code: "gd", continent: "North America", prefix: "+1-473", flagAsset: "assets/flags/gd.svg"),
  Country(name: "Guadeloupe", code: "gp", continent: "North America", prefix: "+590", flagAsset: "assets/flags/gp.svg"),
  Country(name: "Guam", code: "gu", continent: "Oceania", prefix: "+1-671", flagAsset: "assets/flags/gu.svg"),
  Country(name: "Guatemala", code: "gt", continent: "North America", prefix: "+502", flagAsset: "assets/flags/gt.svg"),
  Country(name: "Guernsey", code: "gg", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/gg.svg"),
  Country(name: "Guinea", code: "gn", continent: "Africa", prefix: "+224", flagAsset: "assets/flags/gn.svg"),
  Country(name: "Guinea-Bissau", code: "gw", continent: "Africa", prefix: "+245", flagAsset: "assets/flags/gw.svg"),
  Country(name: "Guyana", code: "gy", continent: "South America", prefix: "+592", flagAsset: "assets/flags/gy.svg"),
  Country(name: "Haiti", code: "ht", continent: "North America", prefix: "+509", flagAsset: "assets/flags/ht.svg"),
  Country(name: "Heard Island and McDonald Islands", code: "hm", continent: "Antarctica", prefix: "+334", flagAsset: "assets/flags/hm.svg"),
  Country(name: "Holy See", code: "va", continent: "Europe", prefix: "+379", flagAsset: "assets/flags/va.svg"),
  Country(name: "Honduras", code: "hn", continent: "North America", prefix: "+504", flagAsset: "assets/flags/hn.svg"),
  Country(name: "Hong Kong", code: "hk", continent: "Asia", prefix: "+852", flagAsset: "assets/flags/hk.svg"),
  Country(name: "Hungary", code: "hu", continent: "Europe", prefix: "+36", flagAsset: "assets/flags/hu.svg"),
  Country(name: "Iceland", code: "is", continent: "Europe", prefix: "+354", flagAsset: "assets/flags/is.svg"),
  Country(name: "India", code: "in", continent: "Asia", prefix: "+91", flagAsset: "assets/flags/in.svg"),
  Country(name: "Indonesia", code: "id", continent: "Asia", prefix: "+62", flagAsset: "assets/flags/id.svg"),
  Country(name: "Iran", code: "ir", continent: "Asia", prefix: "+98", flagAsset: "assets/flags/ir.svg"),
  Country(name: "Iraq", code: "iq", continent: "Asia", prefix: "+964", flagAsset: "assets/flags/iq.svg"),
  Country(name: "Ireland", code: "ie", continent: "Europe", prefix: "+353", flagAsset: "assets/flags/ie.svg"),
  Country(name: "Isle of Man", code: "im", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/im.svg"),
  Country(name: "Israel", code: "il", continent: "Asia", prefix: "+972", flagAsset: "assets/flags/il.svg"),
  Country(name: "Italy", code: "it", continent: "Europe", prefix: "+39", flagAsset: "assets/flags/it.svg"),
  Country(name: "Jamaica", code: "jm", continent: "North America", prefix: "+1-876", flagAsset: "assets/flags/jm.svg"),
  Country(name: "Japan", code: "jp", continent: "Asia", prefix: "+81", flagAsset: "assets/flags/jp.svg"),
  Country(name: "Jersey", code: "je", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/je.svg"),
  Country(name: "Jordan", code: "jo", continent: "Asia", prefix: "+962", flagAsset: "assets/flags/jo.svg"),
  Country(name: "Kazakhstan", code: "kz", continent: "Asia", prefix: "+7", flagAsset: "assets/flags/kz.svg"),
  Country(name: "Kenya", code: "ke", continent: "Africa", prefix: "+254", flagAsset: "assets/flags/ke.svg"),
  Country(name: "Kiribati", code: "ki", continent: "Oceania", prefix: "+686", flagAsset: "assets/flags/ki.svg"),
  Country(name: "Kosovo", code: "xk", continent: "Europe", prefix: "+383", flagAsset: "assets/flags/xk.svg"),
  Country(name: "Kuwait", code: "kw", continent: "Asia", prefix: "+965", flagAsset: "assets/flags/kw.svg"),
  Country(name: "Kyrgyzstan", code: "kg", continent: "Asia", prefix: "+996", flagAsset: "assets/flags/kg.svg"),
  Country(name: "Laos", code: "la", continent: "Asia", prefix: "+856", flagAsset: "assets/flags/la.svg"),
  Country(name: "Latvia", code: "lv", continent: "Europe", prefix: "+371", flagAsset: "assets/flags/lv.svg"),
  Country(name: "Lebanon", code: "lb", continent: "Asia", prefix: "+961", flagAsset: "assets/flags/lb.svg"),
  Country(name: "Lesotho", code: "ls", continent: "Africa", prefix: "+266", flagAsset: "assets/flags/ls.svg"),
  Country(name: "Liberia", code: "lr", continent: "Africa", prefix: "+231", flagAsset: "assets/flags/lr.svg"),
  Country(name: "Libya", code: "ly", continent: "Africa", prefix: "+218", flagAsset: "assets/flags/ly.svg"),
  Country(name: "Liechtenstein", code: "li", continent: "Europe", prefix: "+423", flagAsset: "assets/flags/li.svg"),
  Country(name: "Lithuania", code: "lv", continent: "Europe", prefix: "+370", flagAsset: "assets/flags/lv.svg"),
  Country(name: "Luxembourg", code: "lu", continent: "Europe", prefix: "+352", flagAsset: "assets/flags/lu.svg"),
  Country(name: "Macau", code: "mo", continent: "Asia", prefix: "+853", flagAsset: "assets/flags/mo.svg"),
  Country(name: "Madagascar", code: "mg", continent: "Africa", prefix: "+261", flagAsset: "assets/flags/mg.svg"),
  Country(name: "Malawi", code: "mw", continent: "Africa", prefix: "+265", flagAsset: "assets/flags/mw.svg"),
  Country(name: "Malaysia", code: "my", continent: "Asia", prefix: "+60", flagAsset: "assets/flags/my.svg"),
  Country(name: "Maldives", code: "mv", continent: "Asia", prefix: "+960", flagAsset: "assets/flags/mv.svg"),
  Country(name: "Mali", code: "ml", continent: "Africa", prefix: "+223", flagAsset: "assets/flags/ml.svg"),
  Country(name: "Malta", code: "mt", continent: "Europe", prefix: "+356", flagAsset: "assets/flags/mt.svg"),
  Country(name: "Marshall Islands", code: "mh", continent: "Oceania", prefix: "+692", flagAsset: "assets/flags/mh.svg"),
  Country(name: "Martinique", code: "mq", continent: "North America", prefix: "+596", flagAsset: "assets/flags/mq.svg"),
  Country(name: "Mauritania", code: "mr", continent: "Africa", prefix: "+222", flagAsset: "assets/flags/mr.svg"),
  Country(name: "Mauritius", code: "mu", continent: "Africa", prefix: "+230", flagAsset: "assets/flags/mu.svg"),
  Country(name: "Mayotte", code: "yt", continent: "Africa", prefix: "+262", flagAsset: "assets/flags/yt.svg"),
  Country(name: "Mexico", code: "mx", continent: "North America", prefix: "+52", flagAsset: "assets/flags/mx.svg"),
  Country(name: "Moldova", code: "md", continent: "Europe", prefix: "+373", flagAsset: "assets/flags/md.svg"),
  Country(name: "Monaco", code: "mc", continent: "Europe", prefix: "+377", flagAsset: "assets/flags/mc.svg"),
  Country(name: "Mongolia", code: "mn", continent: "Asia", prefix: "+976", flagAsset: "assets/flags/mn.svg"),
  Country(name: "Montenegro", code: "me", continent: "Europe", prefix: "+382", flagAsset: "assets/flags/me.svg"),
  Country(name: "Montserrat", code: "ms", continent: "North America", prefix: "+1-664", flagAsset: "assets/flags/ms.svg"),
  Country(name: "Morocco", code: "ma", continent: "Africa", prefix: "+212", flagAsset: "assets/flags/ma.svg"),
  Country(name: "Mozambique", code: "mz", continent: "Africa", prefix: "+258", flagAsset: "assets/flags/mz.svg"),
  Country(name: "Myanmar", code: "mm", continent: "Asia", prefix: "+95", flagAsset: "assets/flags/mm.svg"),
  Country(name: "Namibia", code: "na", continent: "Africa", prefix: "+264", flagAsset: "assets/flags/na.svg"),
  Country(name: "Nauru", code: "nr", continent: "Oceania", prefix: "+674", flagAsset: "assets/flags/nr.svg"),
  Country(name: "Nepal", code: "np", continent: "Asia", prefix: "+977", flagAsset: "assets/flags/np.svg"),
  Country(name: "Netherlands", code: "nl", continent: "Europe", prefix: "+31", flagAsset: "assets/flags/nl.svg"),
  Country(name: "New Caledonia", code: "nc", continent: "Oceania", prefix: "+687", flagAsset: "assets/flags/nc.svg"),
  Country(name: "New Zealand", code: "nz", continent: "Oceania", prefix: "+64", flagAsset: "assets/flags/nz.svg"),
  Country(name: "Nicaragua", code: "ni", continent: "North America", prefix: "+505", flagAsset: "assets/flags/ni.svg"),
  Country(name: "Niger", code: "ne", continent: "Africa", prefix: "+227", flagAsset: "assets/flags/ne.svg"),
  Country(name: "Nigeria", code: "ng", continent: "Africa", prefix: "+234", flagAsset: "assets/flags/ng.svg"),
  Country(name: "Niue", code: "nu", continent: "Oceania", prefix: "+683", flagAsset: "assets/flags/nu.svg"),
  Country(name: "Norfolk Island", code: "nf", continent: "Oceania", prefix: "+672", flagAsset: "assets/flags/nf.svg"),
  Country(name: "North Korea", code: "kp", continent: "Asia", prefix: "+850", flagAsset: "assets/flags/kp.svg"),
  Country(name: "North Macedonia", code: "mk", continent: "Europe", prefix: "+389", flagAsset: "assets/flags/mk.svg"),
  Country(name: "Northern Mariana Islands", code: "mp", continent: "Oceania", prefix: "+1-670", flagAsset: "assets/flags/mp.svg"),
  Country(name: "Norway", code: "no", continent: "Europe", prefix: "+47", flagAsset: "assets/flags/no.svg"),
  Country(name: "Oman", code: "om", continent: "Asia", prefix: "+968", flagAsset: "assets/flags/om.svg"),
  Country(name: "Pakistan", code: "pk", continent: "Asia", prefix: "+92", flagAsset: "assets/flags/pk.svg"),
  Country(name: "Palau", code: "pw", continent: "Oceania", prefix: "+680", flagAsset: "assets/flags/pw.svg"),
  Country(name: "Panama", code: "pa", continent: "North America", prefix: "+507", flagAsset: "assets/flags/pa.svg"),
  Country(name: "Papua New Guinea", code: "pg", continent: "Oceania", prefix: "+675", flagAsset: "assets/flags/pg.svg"),
  Country(name: "Paraguay", code: "py", continent: "South America", prefix: "+595", flagAsset: "assets/flags/py.svg"),
  Country(name: "Peru", code: "pe", continent: "South America", prefix: "+51", flagAsset: "assets/flags/pe.svg"),
  Country(name: "Philippines", code: "ph", continent: "Asia", prefix: "+63", flagAsset: "assets/flags/ph.svg"),
  Country(name: "Pitcairn", code: "pn", continent: "Oceania", prefix: "+64", flagAsset: "assets/flags/pn.svg"),
  Country(name: "Poland", code: "pl", continent: "Europe", prefix: "+48", flagAsset: "assets/flags/pl.svg"),
  Country(name: "Portugal", code: "pt", continent: "Europe", prefix: "+351", flagAsset: "assets/flags/pt.svg"),
  Country(name: "Puerto Rico", code: "pr", continent: "North America", prefix: "+1-787", flagAsset: "assets/flags/pr.svg"),
  Country(name: "Qatar", code: "qa", continent: "Asia", prefix: "+974", flagAsset: "assets/flags/qa.svg"),
  Country(name: "Republic of the Congo", code: "cg", continent: "Africa", prefix: "+242", flagAsset: "assets/flags/cg.svg"),
  Country(name: "Romania", code: "ro", continent: "Europe", prefix: "+40", flagAsset: "assets/flags/ro.svg"),
  Country(name: "Russia", code: "ru", continent: "Europe", prefix: "+7", flagAsset: "assets/flags/ru.svg"),
  Country(name: "Rwanda", code: "rw", continent: "Africa", prefix: "+250", flagAsset: "assets/flags/rw.svg"),
  Country(name: "Réunion", code: "re", continent: "Africa", prefix: "+262", flagAsset: "assets/flags/re.svg"),
  Country(name: "Saint Barthélemy", code: "bl", continent: "North America", prefix: "+590", flagAsset: "assets/flags/bl.svg"),
  Country(name: "Saint Helena", code: "sh-hl", continent: "Africa", prefix: "+290", flagAsset: "assets/flags/sh-hl.svg"),
  Country(name: "Saint Kitts and Nevis", code: "kn", continent: "North America", prefix: "+1-869", flagAsset: "assets/flags/kn.svg"),
  Country(name: "Saint Lucia", code: "lc", continent: "North America", prefix: "+1-758", flagAsset: "assets/flags/lc.svg"),
  Country(name: "Saint Martin", code: "mf", continent: "North America", prefix: "+590", flagAsset: "assets/flags/mf.svg"),
  Country(name: "Saint Pierre and Miquelon", code: "pm", continent: "North America", prefix: "+508", flagAsset: "assets/flags/pm.svg"),
  Country(name: "Saint Vincent and the Grenadines", code: "vc", continent: "North America", prefix: "+1-784", flagAsset: "assets/flags/vc.svg"),
  Country(name: "Samoa", code: "ws", continent: "Oceania", prefix: "+685", flagAsset: "assets/flags/ws.svg"),
  Country(name: "San Marino", code: "sm", continent: "Europe", prefix: "+378", flagAsset: "assets/flags/sm.svg"),
  Country(name: "São Tomé", code: "st", continent: "Africa", prefix: "+239", flagAsset: "assets/flags/st.svg"),
  Country(name: "Saudi Arabia", code: "sa", continent: "Asia", prefix: "+966", flagAsset: "assets/flags/sa.svg"),
  Country(name: "Scotland", code: "gb-sct", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/gb-sct.svg"),
  Country(name: "Senegal", code: "sn", continent: "Africa", prefix: "+221", flagAsset: "assets/flags/sn.svg"),
  Country(name: "Serbia", code: "rs", continent: "Europe", prefix: "+381", flagAsset: "assets/flags/rs.svg"),
  Country(name: "Seychelles", code: "sc", continent: "Africa", prefix: "+248", flagAsset: "assets/flags/sc.svg"),
  Country(name: "Sierra Leone", code: "sl", continent: "Africa", prefix: "+232", flagAsset: "assets/flags/sl.svg"),
  Country(name: "Singapore", code: "sg", continent: "Asia", prefix: "+65", flagAsset: "assets/flags/sg.svg"),
  Country(name: "Sint Maarten", code: "sx", continent: "North America", prefix: "+1-721", flagAsset: "assets/flags/sx.svg"),
  Country(name: "Slovakia", code: "sk", continent: "Europe", prefix: "+421", flagAsset: "assets/flags/sk.svg"),
  Country(name: "Slovenia", code: "si", continent: "Europe", prefix: "+386", flagAsset: "assets/flags/si.svg"),
  Country(name: "Solomon Islands", code: "sb", continent: "Oceania", prefix: "+677", flagAsset: "assets/flags/sb.svg"),
  Country(name: "Somalia", code: "so", continent: "Africa", prefix: "+252", flagAsset: "assets/flags/so.svg"),
  Country(name: "South Africa", code: "za", continent: "Africa", prefix: "+27", flagAsset: "assets/flags/za.svg"),
  Country(name: "South Georgia and South Sandwich", code: "gs", continent: "Antarctica", prefix: "+500", flagAsset: "assets/flags/gs.svg"),
  Country(name: "South Korea", code: "kr", continent: "Asia", prefix: "+82", flagAsset: "assets/flags/kr.svg"),
  Country(name: "South Sudan", code: "ss", continent: "Africa", prefix: "+211", flagAsset: "assets/flags/ss.svg"),
  Country(name: "Spain", code: "es", continent: "Europe", prefix: "+34", flagAsset: "assets/flags/es.svg"),
  Country(name: "Sri Lanka", code: "lk", continent: "Asia", prefix: "+94", flagAsset: "assets/flags/lk.svg"),
  Country(name: "State of Palestine", code: "ps", continent: "Asia", prefix: "+970", flagAsset: "assets/flags/ps.svg"),
  Country(name: "Sudan", code: "sd", continent: "Africa", prefix: "+249", flagAsset: "assets/flags/sd.svg"),
  Country(name: "Suriname", code: "sr", continent: "South America", prefix: "+597", flagAsset: "assets/flags/sr.svg"),
  Country(name: "Svalbard and Jan Mayen", code: "sj", continent: "Europe", prefix: "+4779", flagAsset: "assets/flags/sj.svg"),
  Country(name: "Stockholm", code: "se", continent: "Europe", prefix: "+46", flagAsset: "assets/flags/se.svg"),
  Country(name: "Switzerland", code: "ch", continent: "Europe", prefix: "+41", flagAsset: "assets/flags/ch.svg"),
  Country(name: "Syria", code: "sy", continent: "Asia", prefix: "+963", flagAsset: "assets/flags/sy.svg"),
  Country(name: "Taipei", code: "tw", continent: "Asia", prefix: "+886", flagAsset: "assets/flags/tw.svg"),
  Country(name: "Tajikistan", code: "tj", continent: "Asia", prefix: "+992", flagAsset: "assets/flags/tj.svg"),
  Country(name: "Tanzania", code: "tz", continent: "Africa", prefix: "+255", flagAsset: "assets/flags/tz.svg"),
  Country(name: "Thailand", code: "th", continent: "Asia", prefix: "+66", flagAsset: "assets/flags/th.svg"),
  Country(name: "Timor-Leste", code: "tl", continent: "Asia", prefix: "+670", flagAsset: "assets/flags/tl.svg"),
  Country(name: "Togo", code: "tg", continent: "Africa", prefix: "+228", flagAsset: "assets/flags/tg.svg"),
  Country(name: "Tokelau", code: "tk", continent: "Oceania", prefix: "+690", flagAsset: "assets/flags/tk.svg"),
  Country(name: "Tonga", code: "to", continent: "Oceania", prefix: "+676", flagAsset: "assets/flags/to.svg"),
  Country(name: "Trinidad and Tobago", code: "tt", continent: "South America", prefix: "+1-868", flagAsset: "assets/flags/tt.svg"),
  Country(name: "Tristan da Cunha", code: "sh-ta", continent: "Africa", prefix: "+290", flagAsset: "assets/flags/sh-ta.svg"),
  Country(name: "Tunisia", code: "tn", continent: "Africa", prefix: "+216", flagAsset: "assets/flags/tn.svg"),
  Country(name: "Turkmenistan", code: "tm", continent: "Asia", prefix: "+993", flagAsset: "assets/flags/tm.svg"),
  Country(name: "Turks and Caicos Islands", code: "tc", continent: "North America", prefix: "+1-649", flagAsset: "assets/flags/tc.svg"),
  Country(name: "Tuvalu", code: "tv", continent: "Oceania", prefix: "+688", flagAsset: "assets/flags/tv.svg"),
  Country(name: "Türkiye", code: "tr", continent: "Asia", prefix: "+90", flagAsset: "assets/flags/tr.svg"),
  Country(name: "Uganda", code: "ug", continent: "Africa", prefix: "+256", flagAsset: "assets/flags/ug.svg"),
  Country(name: "Ukraine", code: "ua", continent: "Europe", prefix: "+380", flagAsset: "assets/flags/ua.svg"),
  Country(name: "United Arab Emirates", code: "ae", continent: "Asia", prefix: "+971", flagAsset: "assets/flags/ae.svg"),
  Country(name: "United Kingdom", code: "gb", continent: "Europe", prefix: "+44", flagAsset: "assets/flags/gb.svg"),
  Country(name: "United States Minor Outlying Islands", code: "um", continent: "North America", prefix: "+1", flagAsset: "assets/flags/um.svg"),
  Country(name: "United States of America", code: "us", continent: "North America", prefix: "+1", flagAsset: "assets/flags/us.svg"),
  Country(name: "Uruguay", code: "uy", continent: "South America", prefix: "+598", flagAsset: "assets/flags/uy.svg"),
  Country(name: "Uzbekistan", code: "uz", continent: "Asia", prefix: "+998", flagAsset: "assets/flags/uz.svg"),
  Country(name: "Vanuatu", code: "vu", continent: "Oceania", prefix: "+678", flagAsset: "assets/flags/vu.svg"),
  Country(name: "Venezuela", code: "ve", continent: "South America", prefix: "+58", flagAsset: "assets/flags/ve.svg"),
  Country(name: "Vietnam", code: "vn", continent: "Asia", prefix: "+84", flagAsset: "assets/flags/vn.svg"),
  Country(name: "Virgin Islands (British)", code: "vg", continent: "North America", prefix: "+1-284", flagAsset: "assets/flags/vg.svg"),
  Country(name: "Virgin Islands (U.S.)", code: "vi", continent: "North America", prefix: "+1-340", flagAsset: "assets/flags/vi.svg"),
  Country(name: "Wallis and Futuna", code: "wf", continent: "Oceania", prefix: "+681", flagAsset: "assets/flags/wf.svg"),
  Country(name: "Western Sahara", code: "eh", continent: "Africa", prefix: "+212", flagAsset: "assets/flags/eh.svg"),
  Country(name: "Yemen", code: "ye", continent: "Asia", prefix: "+967", flagAsset: "assets/flags/ye.svg"),
  Country(name: "Zambia", code: "zm", continent: "Africa", prefix: "+260", flagAsset: "assets/flags/zm.svg"),
  Country(name: "Zimbabwe", code: "zw", continent: "Africa", prefix: "+263", flagAsset: "assets/flags/zw.svg"),
];
