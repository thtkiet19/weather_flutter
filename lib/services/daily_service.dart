import 'dart:convert';

import 'package:weather_midterm/models/daily_models.dart';
import 'package:http/http.dart' as http;

class DailyService {
  Future<DailyWeather> getWeatherNow(double lat, double lon) async {
    print('passed lat  $lat, lon  $lon');
    final queryParameters = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'exclude': 'minutes',
      'appid': '3aa6b9af54a1fdb532fdfbbdb85b11ca',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/onecall', queryParameters);
    print(uri);
    final daily_response = await http.get(uri);

    //print(daily_response.body);
    final json = jsonDecode(daily_response.body);
    print('object json updated');

    return DailyWeather.fromJson(json);
  }
}
