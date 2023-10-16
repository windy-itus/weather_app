import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/city_entry_view_model.dart';

class CityEntryView extends StatefulWidget {
  const CityEntryView({super.key});

  @override
  State<CityEntryView> createState() => _CityEntryState();
}

class _CityEntryState extends State<CityEntryView> {
  late TextEditingController cityEditController;

  @override
  void initState() {
    super.initState();

    cityEditController = TextEditingController();

    // sync the current value in text field to
    // the view model
    cityEditController.addListener(() {
      Provider.of<CityEntryViewModel>(context, listen: false)
          .updateCity(cityEditController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityEntryViewModel>(
        builder: (context, model, child) => Container(
            margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
            padding: const EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    model.updateCity(cityEditController.text);
                    model.refreshWeather(cityEditController.text, context);
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        controller: cityEditController,
                        decoration:
                        const InputDecoration.collapsed(hintText: "Search by location name or zip code"),
                        onSubmitted: (String city) =>
                        {model.refreshWeather(city, context)})),
              ],
            )));
  }
}
