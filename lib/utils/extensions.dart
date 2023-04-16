extension FarsiNumber on String {
  String get toFarsiNumber {
    final Map<String, String> numbers = {
      "0": "۰",
      "1": "۱",
      "2": "۲",
      "3": "۳",
      "4": "۴",
      "5": "۵",
      "6": "۶",
      "7": "۷",
      "8": "۸",
      "9": "۹",
    };
    String farsiNumber = '';
    for (int i = 0; i < length; i++) {
      if (numbers.containsKey(this[i])) {
        farsiNumber += numbers[this[i]]!;
      } else {
        farsiNumber += this[i];
      }
    }
    return farsiNumber;
  }
}
