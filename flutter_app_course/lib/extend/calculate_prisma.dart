import 'package:flutter_app_course/extend/calculate_volume.dart';

class CalculatePrisma extends CalculateVolume {
  @override
  num processVolume(num alas, num tinggi){
    return alas * tinggi / 3;
  }
}
 