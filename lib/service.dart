import 'dart:convert';

import 'package:weather_midterm/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': '3aa6b9af54a1fdb532fdfbbdb85b11ca',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    print(uri);
    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    print('object json updated');
    return WeatherResponse.fromJson(json);
  }
}
