import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/remote/weather_api_implement.dart';
import 'package:weather_app/services/forecast_service.dart';
import 'package:weather_app/utils/strings.dart';
import 'package:weather_app/utils/temperature_converter.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  // private fields with default values
  WeatherCondition _condition = WeatherCondition.unknown;
  String _description = '';
  double _minTemp = 0;
  double _maxTemp = 0;
  double _temp = 0;
  double _feelsLike = 0;
  int _locationId = 0;
  DateTime _lastUpdated = DateTime.now();
  String _city = '';
  double _latitude = 0;
  double _longitude = 0;
  bool _isDayTime = true;
  String _errorMessage = 'Something went wrong. Try again';


  // public getter
  WeatherCondition get condition => _condition;

  String get description => _description;

  double get minTemp => _minTemp;

  double get maxTemp => _maxTemp;

  double get temp => _temp;

  double get feelsLike => _feelsLike;

  int get locationId => _locationId;

  DateTime get lastUpdated => _lastUpdated;

  String get city => _city;

  double get longitude => _longitude;

  double get latitude => _latitude;

  bool get isDaytime => _isDayTime;

  String get errorMessage => _errorMessage;

  late ForecastService forecastService;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
    _getCurrentPosition();
  }

  Future<Forecast?> getLatestWeather(String input) async {
    setRequestPendingState(true);
    isRequestError = false;

    Forecast? latest;
    try {
      if (_isZipCode(input)) {
        latest = await forecastService.getWeatherByZipCode(input);
      } else {
        latest = await forecastService.getWeatherByCityName(input);
      }
    } catch (e) {
      _errorMessage = e.toString();
      isRequestError = true;
    }

    isWeatherLoaded = true;
    updateModel(latest, city);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast? forecast, String city) {
    if (isRequestError || forecast == null) return;

    _condition = forecast.current.condition;
    _city = Strings.toTitleCase(forecast.city);
    _description = Strings.toTitleCase(forecast.current.description);
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConverter.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConverter.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _isDayTime = forecast.isDayTime;
  }

  bool _isZipCode(String s) {
    if(s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<Forecast?> _getLatestWeatherByPosition(Position position) async {
    setRequestPendingState(true);
    isRequestError = false;

    Forecast? latest;
    try {
      latest = await forecastService.getWeatherByPosition(position);
    } catch (e) {
      _errorMessage = e.toString();
      isRequestError = true;
    }

    isWeatherLoaded = true;
    updateModel(latest, city);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _getLatestWeatherByPosition(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
