import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'animatedImage.dart';
import '../models/now_models.dart';
import 'package:bordered_text/bordered_text.dart';

class LoadCurrentWeather extends StatefulWidget {
  final WeatherResponse? response;
  final String countryName;
  final Color tempcolor;
  LoadCurrentWeather(
      {Key? key,
      required this.response,
      required this.countryName,
      required this.tempcolor})
      : super(key: key);
  @override
  _LoadCurrentWeatherState createState() => _LoadCurrentWeatherState();
}

class _LoadCurrentWeatherState extends State<LoadCurrentWeather> {
  var sd = [
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: Color(0xff4b4848)),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: Color(0xff4b4848)),
    Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: Color(0xff313031)),
    Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: Color(0xff444141)),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 450,
        /*decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(5, 196, 211, 1),
              Color.fromRGBO(4, 120, 213, 1),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10)),*/
        //color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BorderedText(
                      strokeWidth: 3.0,
                      child: Text(
                        '${widget.response!.cityName}',
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 14,
                          backgroundImage: AssetImage(
                              'assets/images/country/${widget.countryName}.png')),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                BorderedText(
                  strokeWidth: 2.0,
                  strokeColor: Colors.black87,
                  child: Text(
                    '${widget.response!.time}',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                AnimatedImage(
                  response: widget.response,
                  key: widget.key,
                ),
                SizedBox(
                  height: 15,
                ),
                BorderedText(
                  strokeWidth: 2.0,
                  strokeColor: Colors.black87,
                  child: Text(
                    '${widget.response!.tempInfo.temperature}°C',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  widget.response!.weatherInfo.description,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
