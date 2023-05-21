import 'package:home_sweet/utils/extensions.dart';

class Validators {
  Validators._();

  static final RegExp passwordMinMaxRegExp = RegExp(r'^\d{6,12}$');
  static final RegExp onlyEngCharsRegExp =
      RegExp(r'^\s*[a-zA-Z_]+\s*$'); //RegExp(r'^[a-zA-Z]+$');

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    }
    if (!onlyEngCharsRegExp.hasMatch(value)) {
      return 'نام کاربری فقط میتواند شامل حروف انگلیسی بدون فاصله باشد.';
    }
    if (value.length > 20 || value.length < 3) {
      return 'حداقل طول نام کاربری 3 و حداکثر 20 است.'.toFarsiNumber;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (!passwordMinMaxRegExp.hasMatch(value)) {
      return 'حداقل طول رمز عبور باید 6 و حداکثر 12 رقم باشد.'.toFarsiNumber;
    }
    return null;
  }

  static String? textInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 50) {
      return 'حداکثر طول نام کاربری 50 است.'.toFarsiNumber;
    }
    return null;
  }

  static String? amountInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 20) {
      return 'حداکثر طول مقدار 20 است.'.toFarsiNumber;
    }
    return null;
  }

  static String? descriptionInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 300) {
      return 'حداکثر طول مقدار 300 است.'.toFarsiNumber;
    }
    return null;
  }

  static String? dateInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    }
    return null;
  }
}
