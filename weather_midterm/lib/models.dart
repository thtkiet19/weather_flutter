/*
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 16093,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
  }
 */
import 'package:intl/intl.dart';

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].toDouble();
    return TemperatureInfo(temperature: temperature);
  }
}

class CountryInfo {
  final String contryCode;

  CountryInfo({required this.contryCode});

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    final contryCode = json['country'];
    return CountryInfo(contryCode: contryCode);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final String time;
  final CountryInfo country;
  final DateTime now;

  String get iconUrl {
    return 'assets/images/${weatherInfo.icon}.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.weatherInfo,
      required this.time,
      required this.country,
      required this.now});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    print('get name');
    final tempInfoJson = json['main'];
    print('get main');
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    print('get temp');
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    print('get icon');
    final cntryInfo = json['sys'];
    final contry = CountryInfo.fromJson(cntryInfo);
    final int offset = json['timezone'];
    print('get time offset${offset}');
    DateTime now = DateTime.now().toUtc();
    now = now.add(Duration(seconds: offset));
    print('get time final');

    String time = DateFormat.jm().format(now);
    print('get time format');

    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        time: time,
        country: contry,
        now: now);
  }
}
