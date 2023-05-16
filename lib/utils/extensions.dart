import 'dart:convert';

import 'package:crypto/crypto.dart';

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

  String hash() {
    var bytes = utf8.encode(this);
    var hashedPassword = sha256.convert(bytes);
    return hashedPassword.toString();
  }

  String toTooman() {
    String res = '';
    int numberCounter = 0;

    for (int index = length - 1; index >= 0; index--) {
      numberCounter++;
      res = this[index] + res;

      if (numberCounter % 3 == 0 && index != 0) {
        res = ',$res';
      }
    }

    return res.toFarsiNumber;
  }
}
