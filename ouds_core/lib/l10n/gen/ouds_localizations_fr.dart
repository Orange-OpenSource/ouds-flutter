/// @nodoc
library;

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'ouds_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class OudsLocalizationsFr extends OudsLocalizations {
  OudsLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get core_common_error_a11y => 'Erreur';

  @override
  String get core_common_selected_a11y => 'Sélectionné';

  @override
  String get core_common_unselected_a11y => 'Non sélectionné';

  @override
  String get core_common_loading_a11y => 'Chargement';

  @override
  String get core_common_disabled_a11y => 'Désactivé';

  @override
  String get core_common_hint_a11y => 'Double tap pour modifier';

  @override
  String get core_button_icon_only_a11y => 'Icône';

  @override
  String get core_bottom_sheets_label_a11y => 'Bottom sheet';

  @override
  String get core_bottom_sheets_expanded_a11y => 'Dépliée';

  @override
  String get core_bottom_sheets_collapsed_a11y => 'Repliée';

  @override
  String get core_bottom_sheets_hint_a11y =>
      'Tapoter pour déployer ou réduire la feuille inférieure';

  @override
  String get core_filterChip_hint_unselected_a11y =>
      'Double tap pour désélectionner';

  @override
  String get core_filterChip_hint_selected_a11y =>
      'Double tap pour sélectionner';

  @override
  String get core_chip_chip_icon_a11y => 'Icône';

  @override
  String get core_checkbox_trait_a11y => 'Case à cocher';

  @override
  String get core_checkbox_checked_a11y => 'Coché';

  @override
  String get core_checkbox_unchecked_a11y => 'Non coché';

  @override
  String get core_checkbox_indeterminate_a11y => 'Indéterminé';

  @override
  String get core_checkbox_hint_a11y => 'Double tap pour basculer';

  @override
  String get core_radioButton_radioButton_a11y => 'Bouton radio';

  @override
  String get core_link_trait_a11y => 'Lien';

  @override
  String get core_inputTag_hint_a11y => 'Double tap pour supprimer';

  @override
  String get core_tag_tag_input_role_a11y => 'Option';

  @override
  String get core_inputTag_delete_a11y => 'Supprimer l’étiquette';

  @override
  String core_tag_tag_input_removed_a11y(Object label) {
    return 'Étiquette $label supprimée';
  }

  @override
  String get core_textInput_trait_a11y => 'Champ de texte';

  @override
  String get core_phoneNumberInput_a11y => 'Numéro de téléphone';

  @override
  String get core_phoneNumberInput_countrySelector_a11y => 'Sélecteur de pays';

  @override
  String get core_phoneNumberInput_countrySelector_hint_a11y =>
      'Double tap pour sélectionner un pays';

  @override
  String get core_passwordInput_showPassword_a11y => 'Afficher le mot de passe';

  @override
  String get core_passwordInput_hidePassword_a11y => 'Masquer le mot de passe';

  @override
  String core_pinCodeInput_digitCode_label_a11y(Object current) {
    return 'Code à chiffres $current';
  }

  @override
  String core_pinCodeInput_pinCode_label_a11y(Object digitsCount) {
    return 'Entrez votre code à $digitsCount chiffres';
  }

  @override
  String get core_pinCodeInput_trait_a11y => 'Champ de saisie';
}
