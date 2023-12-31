import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/forecast_view_model.dart';

class CityEntryViewModel with ChangeNotifier {
  String _city = '';

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather(_city);
    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}
