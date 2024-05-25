import 'package:flutter/material.dart';
import 'package:flutter_app_course/repository/weather_repository.dart';

import '../entity/weather_entity.dart';

class WeatherProvider extends ChangeNotifier {
  TextEditingController nameCityField = TextEditingController();
  var state = WeatherState.initial;
  DataWeather? dataWeather;
  String messageError = '';

  void getWeather() async {
    state = WeatherState.loading;
    WeatherEntity result =
        await WeatherRepository().weatherToday(nameCityField.text);
    if (result.statusError) {
      state = WeatherState.error;
      messageError = result.message;
    } else {
      state = WeatherState.success;
      dataWeather = result.data;
    }
    notifyListeners();
  }
}

enum WeatherState { initial, error, noConnection, empty, success, loading }
