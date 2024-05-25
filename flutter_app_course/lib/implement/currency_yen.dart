import 'package:flutter_app_course/implement/calculate_rupiah.dart';

class CurrencyYen implements CalculateRupiah {
  @override
  num processRupiah(num amountCurrency) {
    return 102 * amountCurrency;
  }
  
}