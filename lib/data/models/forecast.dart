
import 'package:weather_app/data/models/weather.dart';

class Forecast {
  final DateTime lastUpdated;
  final double longitude;
  final double latitude;
  final Weather current;
  final bool isDayTime;
  String city;

  Forecast(
      {required this.lastUpdated,
      required this.longitude,
      required this.latitude,
      required this.current,
      required this.city,
      required this.isDayTime});

  static Forecast fromJson(dynamic json) {
    var weather = json['weather'][0];
    var date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
        isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    var currentForecast = Weather(
        cloudiness: int.parse(json['clouds']['all'].toString()),
        temp: json['main']['temp'].toDouble(),
        condition: Weather.mapStringToWeatherCondition(
            weather['main'], int.parse(json['clouds']['all'].toString())),
        description: weather['description'],
        feelLikeTemp: json['main']['feels_like'],
        date: date);

    return Forecast(
        lastUpdated: DateTime.now(),
        current: currentForecast,
        latitude: json['coord']['lat'].toDouble(),
        longitude: json['coord']['lon'].toDouble(),
        isDayTime: isDay,
        city: json['name']);
  }
}
