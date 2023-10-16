import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/forecast.dart';

abstract class WeatherApi {
  Future<Forecast> getWeatherByCityName(String cityName);

  Future<Forecast> getWeatherByZipCode(String zipCode);

  Future<Forecast> getWeatherByPosition(Position position);
}
