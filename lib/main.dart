import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:weather_midterm/service.dart';
import 'package:flutter/material.dart';
import 'refresh weather.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;
  late String coName;

  Color purple = Color(0xff6300B4);
  Color anotherPurple = Color(0xff5802B7);
  Color lightPurple = Color(0xff5203B8);

  Color veryLightPurple = Color(0xff5830C9);

  Color lightBlue = Color(0xff4306BE);
  Color blue = Color(0xff2B0AC3);

  Color containerBorderColor = Color(0xff8C72DA);
  Color containerColor = Color(0xff6135C2);

  Color hot = Colors.orange;
  Color cold = Colors.lightBlueAccent;
  Color neutral = Colors.teal;
  Color tempcolor = Colors.teal;

  var nightbackgroundGradient = LinearGradient(colors: [
    Color.fromRGBO(145, 131, 222, 1),
    Color.fromRGBO(160, 148, 227, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  var daybackgroundGradient = LinearGradient(colors: [
    Color.fromRGBO(5, 196, 211, 1),
    Color.fromRGBO(4, 120, 213, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  var backgroundGradient = LinearGradient(colors: [
    Color.fromRGBO(5, 196, 211, 1),
    Color.fromRGBO(4, 120, 213, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  List<String> _code = [];
  List<String> _country = [];

  bool isDayTime = true;

  Future<List<String>> _loadLocations() async {
    List<String> locations = [];
    await rootBundle.loadString('assets/country.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        locations.add(i);
      }
    });
    return locations;
  }

  Future<List<String>> _loadCodes() async {
    List<String> codes = [];
    await rootBundle.loadString('assets/countryCode.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        codes.add(i);
      }
    });
    return codes;
  }

  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    List<String> location = await _loadLocations();
    List<String> code = await _loadCodes();

    setState(() {
      _country = location;
      _code = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: veryLightPurple,
                        prefixIcon: Icon(Icons.location_city_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'City name',
                      ),
                      textAlign: TextAlign.center),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      _search();
                      refreshWeather(
                        response: _response,
                        countryName: coName,
                        tempcolor: tempcolor,
                      );
                    });
                  },
                  icon: Icon(Icons.search)),
            ]),
            SizedBox(
              height: 20,
            ),
            if (_response != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      refreshWeather(
                        response: _response,
                        countryName: coName,
                        tempcolor: tempcolor,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    String? country;
    for (int i = 0; i < 223; i++) {
      if (response.country.contryCode == _code[i]) {
        country = _country[i];
      }
    }
    var isDay = (response.now.hour > 6 && response.now.hour < 18)
        ? daybackgroundGradient
        : nightbackgroundGradient;

    var color = (response.tempInfo.temperature > 30)
        ? hot
        : (response.tempInfo.temperature < 15)
            ? cold
            : neutral;
    setState(() {
      _response = response;
      coName = country!;
      backgroundGradient = isDay;
      tempcolor = color;
    });
  }

  /*void refresh(WeatherResponse? _response, {WeatherResponse? res}) {
    setState(() => refreshWeather(response: _response));
  }*/
}
