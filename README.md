# Flutter Weather App

![Flutter Weather App Demo](app_demo.gif)

## Introduction

This Flutter Weather App allows users to retrieve and display current weather information for a specific location. 
Users can input a location, such as a city name or zip code, and the app will fetch and display the latest weather data. 
Additionally, the app automatically loads weather information for the user's current location upon launching, provided the user grants the necessary location permission.

## Getting API Key

To use this app, you will need to obtain an API key from [OpenWeatherMap](https://openweathermap.org). Here's how to get one:

1. Visit [OpenWeatherMap](https://openweathermap.org).
2. Sign in or create an account if you don't have one.
3. Once logged in, go to the API Keys section.
4. Create a new API key and give it a name (e.g., "Flutter Weather App").
5. Copy the API key generated for your app.

## How to Run the App

To run this Flutter weather app, you'll need to set up your API key by creating a `.env` file in the root of your project. Here's how to do it:

1. Clone this repository to your local machine.
```bash
git clone https://github.com/your-username/flutter-weather-app.git
cd flutter-weather-app
```

2. Create a .env file in the root directory of your project.
```bash
# .env
API_KEY=YOUR_OPENWEATHERMAP_API_KEY
```

3. Replace `YOUR_OPENWEATHERMAP_API_KEY` with the API key you obtained from OpenWeatherMap.
4. Save the .env file.
5. Ensure you have Flutter and Dart installed. If not, you can install Flutter. 
6. Install the app's dependencies using the following command:
```bash
flutter pub get
```

7. Now, you can run the app using the following command:
```bash
flutter run
```
8. The app will launch, and you can start using it. Make sure to grant location permission when prompted to enable automatic location-based weather updates.

## Features
- Input a location (city name or zip code) to fetch weather data.
- Automatic loading of weather information for the current location (with user permission).
- Displays current weather conditions, temperature, humidity, and more.
- Customizable UI elements and styling.

Feel free to explore, modify, and enhance the app to meet your specific requirements. Happy coding!

## Dependencies

- `http`: 1.1.0
- `provider`: 6.0.5
- `intl`: 0.18.1
- `cupertino_icons`: ^1.0.2
- `flutter_dotenv`: ^5.1.0
- `geolocator`: ^10.1.0
- `geocoding`: ^2.1.1

## Contributions

If you would like to contribute to this project, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. see the [LICENSE](https://github.com/windy-itus/weather_app/blob/main/LICENSE) file for details.

## Contact

If you have any questions or need further assistance, you can contact us at [khoapham.wrk@gmail.com].
