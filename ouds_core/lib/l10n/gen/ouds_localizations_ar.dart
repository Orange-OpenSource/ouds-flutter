/// @nodoc
library;

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'ouds_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class OudsLocalizationsAr extends OudsLocalizations {
  OudsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get core_common_onError_a11y => 'يوجد خطأ';

  @override
  String get core_common_selected_a11y => 'محدد';

  @override
  String get core_common_unselected_a11y => 'غير محدد';

  @override
  String get core_common_loading_a11y => 'جاري التحميل';

  @override
  String get core_common_disabled_a11y => 'غير مفعّل';

  @override
  String get core_common_hint_a11y => 'اضغط مرتين للتعديل';

  @override
  String get core_button_icon_only_a11y => 'أيقونة';

  @override
  String get core_bottom_sheets_label_a11y => 'النافذة السفلية';

  @override
  String get core_bottom_sheets_expanded_a11y => 'مفتوحة';

  @override
  String get core_bottom_sheets_collapsed_a11y => 'مطوية';

  @override
  String get core_bottom_sheets_hint_a11y =>
      'اضغط لتوسيع أو طي النافذة السفلية';

  @override
  String get core_filterChip_selected_a11y => 'Selected';

  @override
  String get core_filterChip_unselected_a11y => 'Unselected';

  @override
  String get core_filterChip_hint_unselected_a11y => 'Double-tap to unselect';

  @override
  String get core_filterChip_hint_selected_a11y => 'Double-tap to select';

  @override
  String get core_chip_chip_label_a11y => 'تسمية الشارة';

  @override
  String get core_chip_chip_icon_a11y => 'أيقونة الشارة';

  @override
  String get core_checkbox_trait_a11y => 'خانة الاختيار';

  @override
  String get core_checkbox_checked_a11y => 'تم الفحص';

  @override
  String get core_checkbox_unchecked_a11y => 'غير محدد';

  @override
  String get core_checkbox_indeterminate_a11y => 'نصف محددة';

  @override
  String get core_checkbox_hint_a11y => 'انقر مرتين للتبديل';

  @override
  String get core_radioButton_radioButton_a11y => 'زر اختيار';

  @override
  String get core_link_trait_a11y => 'Link';

  @override
  String get core_inputTag_hint_a11y => 'Double-tap to delete';

  @override
  String get core_tag_tag_input_role_a11y => 'خيار';

  @override
  String get core_inputTag_delete_a11y => 'Remove tag';

  @override
  String core_tag_tag_input_removed_a11y(Object label) {
    return 'تمت إزالة الوسم $label';
  }

  @override
  String get core_textInput_trait_a11y => 'TextField';

  @override
  String get core_phoneNumberInput_a11y => 'رقم الهاتف';

  @override
  String get core_phoneNumberInput_countrySelector_a11y => 'محدد البلد';

  @override
  String get core_phoneNumberInput_countrySelector_hint_a11y =>
      'اضغط مرتين لتحديد البلد';

  @override
  String get core_password_input_hidden_a11y => 'كلمة المرور مخفية';

  @override
  String get core_password_input_visible_a11y => 'كلمة المرور ظاهرة';

  @override
  String get core_password_input_hint_show_a11y =>
      'اضغط مرتين لإظهار كلمة المرور';

  @override
  String get core_password_input_hint_hide_a11y =>
      'اضغط مرتين لإخفاء كلمة المرور';

  @override
  String core_pinCodeInput_digitCode_label_a11y(Object current) {
    return 'الرقم $current';
  }

  @override
  String core_pinCodeInput_pinCode_label_a11y(Object digitsCount) {
    return 'أدخل رمزك المكوّن من $digitsCount أرقام';
  }

  @override
  String get core_pinCodeInput_error_a11y => 'خطأ: الرمز غير صحيح';

  @override
  String get core_topAppBar_backNavigationIcon_a11y => 'رجوع';

  @override
  String get core_topAppBar_menuNavigationIcon_a11y => 'القائمة';

  @override
  String get core_topAppBar_closeNavigationIcon_a11y => 'إغلاق';
}
