import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'animatedImage.dart';
import '../models/daily_models.dart';
import 'package:bordered_text/bordered_text.dart';

class LoadDailyWeather extends StatefulWidget {
  final DailyWeather? response;
  LoadDailyWeather({
    Key? key,
    required this.response,
  }) : super(key: key);
  @override
  _LoadDailyWeatherState createState() => _LoadDailyWeatherState();
}

class _LoadDailyWeatherState extends State<LoadDailyWeather> {
  DateTime now = DateTime.utc(1970).toUtc();
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
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < widget.response!.daily.length; ++i)
                Row(
                  children: [
                    Container(
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white70, width: 2)),
                      //color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/${widget.response!.daily[i].weather[0].icon}.png',
                                width: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BorderedText(
                                    strokeWidth: 3.0,
                                    child: Text(
                                      '${DateFormat.MMMd().format(now.add(Duration(seconds: widget.response!.daily[i].dt)))}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 4,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BorderedText(
                                    strokeWidth: 2.0,
                                    strokeColor: Colors.black87,
                                    child: Text(
                                      '${widget.response!.daily[i].temp.day}°C',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget
                                    .response!.daily[i].weather[0].description,
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
