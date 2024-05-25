import 'package:flutter_app_course/implement/calculate_rupiah.dart';

class CurrencyDollar implements CalculateRupiah {
  @override
  num processRupiah( num amountCurrency) {
    return 16000 * amountCurrency;
  }
}