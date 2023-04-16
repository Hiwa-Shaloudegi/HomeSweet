class Validators {
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.contains(' ')) {
      return 'اسپیس';
    }
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* این فیلد الزامی است';
    } else if (value.length > 20) {
      return 'بیشتر از 20 کاراکتر';
    }
  }
}
