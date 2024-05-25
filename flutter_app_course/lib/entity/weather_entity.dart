class WeatherEntity {
  bool statusError;
  String message;
  DataWeather data;
  WeatherEntity(this.statusError, this.message, this.data);
}

class DataWeather {
  String nameRegion;
  String iconCondition;
  String condition;
  num temperatur;
  num uv;
  DataWeather(this.nameRegion, this.iconCondition, this.condition,
      this.temperatur, this.uv);
}
