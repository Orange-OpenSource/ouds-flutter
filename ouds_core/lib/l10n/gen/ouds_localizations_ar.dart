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
  String get core_button_loading_a11y => 'جاري التحميل';

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
  String get core_chip_icon_only_a11y => 'أيقونة';

  @override
  String get core_chip_text_only_a11y => 'نص';

  @override
  String get core_chip_text_and_icon_a11y => 'نص وأيقونة';

  @override
  String get core_checkbox_checkbox_a11y => 'خانة الاختيار';

  @override
  String get core_checkbox_indeterminateCheckbox_a11y =>
      'خانة اختيار ثلاثية الحالات';

  @override
  String get core_checkbox_checked_a11y => 'تم الفحص';

  @override
  String get core_checkbox_not_checked_a11y => 'لم يتم التحقق منها';

  @override
  String get core_checkbox_error_a11y => 'خطأ';

  @override
  String get core_checkbox_indeterminate_a11y => 'نصف محددة';

  @override
  String get core_switch_error_a11y => 'خطأ';

  @override
  String get core_tag_tag_input_a11y => 'إدخال الوسم';

  @override
  String get core_tag_a11y => 'وسم';

  @override
  String get core_tag_tag_input_hint_a11y => 'انقر مرتين لحذف هذا العنصر';

  @override
  String get core_tag_loading_a11y => 'جاري التحميل';

  @override
  String get core_text_input_input_a11y => 'حقل النص';

  @override
  String core_pin_code_input_input_a11y(Object current, Object total) {
    return 'الرقم $current من $total';
  }

  @override
  String get core_pin_code_input_error_a11y => 'الخطأ';
}
