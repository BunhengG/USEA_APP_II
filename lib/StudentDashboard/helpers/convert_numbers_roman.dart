import 'package:get/get.dart';

String intToRoman(int number) {
  const Map<int, String> romanNumerals = {
    1: 'I',
    2: 'II',
    3: 'III',
    4: 'IV',
  };

  return romanNumerals[number] ?? number.toString();
}

String getCurrencySymbol() {
  return Get.locale?.languageCode == 'en' ? '\$' : '៛';
}
