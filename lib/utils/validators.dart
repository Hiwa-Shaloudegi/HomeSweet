import 'package:home_sweet/utils/extensions.dart';

class Validators {
  Validators._();

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 20) {
      return 'حداکثر طول نام کاربری 20 است.'.toFarsiNumber;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (!RegExp(r'^\d{6,12}$').hasMatch(value)) {
      return 'حداقل طول رمز عبور باید 6 و حداکثر 12 رقم باشد.'.toFarsiNumber;
    }
    return null;
  }

  // TODO: match with password field.
  static String? repeatPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 20) {
      return 'حداکثر طول نام کاربری 20 است.'.toFarsiNumber;
    }
    return null;
  }
}
