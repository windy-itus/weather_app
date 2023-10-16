import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isDayTime;

  const WeatherSummary(
      {Key? key,
        required this.condition,
        required this.temp,
        required this.feelsLike,
        required this.isDayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Text(
                  '${_formatTemperature(temp)}°ᶜ',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Feels like ${_formatTemperature(feelsLike)}°ᶜ',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          _mapWeatherConditionToImage(condition, isDayTime),
        ]),
      ),
    );
  }

  String _formatTemperature(double t) {
    var temp = (t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    String imagePath;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        imagePath = 'assets/images/thunder_storm.png';
        break;
      case WeatherCondition.heavyCloud:
        imagePath = 'assets/images/cloudy.png';
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? imagePath = 'assets/images/light_cloud.png'
            : imagePath = 'assets/images/light_cloud-night.png';
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        imagePath = 'assets/images/drizzle.png';
        break;
      case WeatherCondition.clear:
        isDayTime
            ? imagePath = 'assets/images/clear.png'
            : imagePath = 'assets/images/clear-night.png';
        break;
      case WeatherCondition.fog:
        imagePath = 'assets/images/fog.png';
        break;
      case WeatherCondition.snow:
        imagePath = 'assets/images/snow.png';
        break;
      case WeatherCondition.rain:
        imagePath = 'assets/images/rain.png';
        break;
      case WeatherCondition.atmosphere:
        imagePath = 'assets/images/fog.png';
        break;

      default:
        imagePath = 'assets/images/unknown.png';
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: Image.asset(imagePath, height: 150, fit:BoxFit.fill));
  }
}
