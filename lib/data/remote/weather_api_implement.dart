import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_app/data/remote/exception.dart';
import 'package:weather_app/data/remote/weather_api.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  var apiKey = "";
  late http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    _setUpHttpClient();
  }

  void _setUpHttpClient() {
    // Use default
    httpClient = http.Client();
    apiKey = dotenv.env['API_KEY'] ?? '';
  }

  @override
  Future<Forecast> getWeatherByCityName(String cityName) async {
    final requestUrl = '$endPointUrl/weather?q=$cityName&appid=$apiKey';
    return _getWeather(requestUrl);
  }

  @override
  Future<Forecast> getWeatherByZipCode(String zipCode) async {
    final requestUrl = '$endPointUrl/weather?zip=$zipCode&appid=$apiKey';
    return _getWeather(requestUrl);
  }

  @override
  Future<Forecast> getWeatherByPosition(Position position) async {
    final requestUrl = '$endPointUrl/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
    return _getWeather(requestUrl);
  }

  Future<Forecast> _getWeather(String requestUrl) async {
    final response = await httpClient.get(Uri.parse(requestUrl));

    var responseData = _returnResponse(response);

    return Forecast.fromJson(jsonDecode(responseData));
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
      case 404:
        throw BadRequestException("Location not found. Try something else.");
      case 401:
      case 403:
        throw UnauthorisedException('Authorization required.');
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

}