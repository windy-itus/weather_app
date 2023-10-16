import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/remote/weather_api.dart';
import 'package:weather_app/data/models/forecast.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeatherByCityName(String city) async {
    return await weatherApi.getWeatherByCityName(city);
  }

  Future<Forecast> getWeatherByZipCode(String zipCode) async {
    return await weatherApi.getWeatherByZipCode(zipCode);
  }

  Future<Forecast> getWeatherByPosition(Position position) async {
    return await weatherApi.getWeatherByPosition(position);
  }
}
