import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/view_model/city_entry_view_model.dart';
import 'package:weather_app/view_model/forecast_view_model.dart';
import 'package:weather_app/views/components/city_entry.dart';
import 'package:weather_app/views/components/daily_summary.dart';
import 'package:weather_app/views/components/gradient_container.dart';
import 'package:weather_app/views/components/latest_updated.dart';
import 'package:weather_app/views/components/location.dart';
import 'package:weather_app/views/components/weather_description.dart';
import 'package:weather_app/views/components/weather_summary.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    onStart();
  }

  Future<void> onStart() async {
    // Do something before start
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Scaffold(
        body: _buildGradientContainer(
            model.condition, model.isDaytime, buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => Container(
            margin: const EdgeInsets.only(left: 10, right: 5),
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () => refreshWeather(weatherViewModel, context),
                child: ListView(
                  children: <Widget>[
                    const CityEntryView(),
                    weatherViewModel.isRequestPending
                        ? buildBusyIndicator()
                        : weatherViewModel.isRequestError
                        ? Center(
                        child: Text(weatherViewModel.errorMessage,
                            style: const TextStyle(
                                fontSize: 21, color: Colors.white)))
                        : Column(children: [
                      LocationView(
                        longitude: weatherViewModel.longitude,
                        latitude: weatherViewModel.latitude,
                        city: weatherViewModel.city,
                      ),
                      const SizedBox(height: 50),
                      WeatherSummary(
                          condition: weatherViewModel.condition,
                          temp: weatherViewModel.temp,
                          feelsLike: weatherViewModel.feelsLike,
                          isDayTime: weatherViewModel.isDaytime),
                      const SizedBox(height: 20),
                      WeatherDescriptionView(
                          weatherDescription:
                          weatherViewModel.description),
                      const SizedBox(height: 140),
                      LastUpdatedView(
                          lastUpdatedOn:
                          weatherViewModel.lastUpdated),
                    ]),
                  ],
                ))));
  }

  Widget buildBusyIndicator() {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Wait a minute',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => DailySummaryView(
          weather: item,
        ))
            .toList());
  }

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    return weatherVM.getLatestWeather(city);
  }

  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (!isDayTime) {
      container = GradientContainer(color: Colors.blueGrey, child: child);
    } else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}
