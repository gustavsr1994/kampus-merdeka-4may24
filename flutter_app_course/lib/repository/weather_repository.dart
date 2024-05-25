import 'package:dio/dio.dart';
import 'package:flutter_app_course/entity/weather_entity.dart';
import 'package:flutter_app_course/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherEntity> weatherToday(String nameCity) async {
    WeatherEntity? weatherEntity;
    try {
      var response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?q=$nameCity&key=xxxxxxxx');

      if (response.statusCode == 200) {
        print('Success');
        var result = WeatherResponse.fromJson(response.data);
        weatherEntity = WeatherEntity(
            false,
            'Success',
            DataWeather(
                result.location!.region!,
                result.current!.condition!.icon!.replaceAll('//', 'http://'),
                result.current!.condition!.text!,
                result.current!.tempC!,
                result.current!.uv!));
      } else {
        weatherEntity = WeatherEntity(
            true, response.statusMessage!, DataWeather('', '', '', 0, 0));
      }
    } catch (e) {
      weatherEntity =
          WeatherEntity(true, e.toString(), DataWeather('', '', '', 0, 0));
    }
    return weatherEntity;
  }
}
