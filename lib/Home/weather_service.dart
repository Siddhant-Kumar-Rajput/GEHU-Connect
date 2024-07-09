import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:my_app/Home/const.dart';

class WeatherServices extends StatefulWidget {
  const WeatherServices({super.key});

  @override
  State<WeatherServices> createState() => _HomePageState();
}

class _HomePageState extends State<WeatherServices> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Bhimtal").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
         width: double.infinity,
         height: 286,
         decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).alternate,
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      // width: MediaQuery.sizeOf(context).width,
      // height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          // SizedBox(
          //   height: 25,
          // ),
          _weatherIcon(),
          // SizedBox(
          //   height: 70,
          // ),
          _currentTemp(),
          // SizedBox(
          //   height: 35,
          // ),
          _extraInfo(),
        ],
      ),
      
    );
  }

  Widget _locationHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.0), // Adjust the top padding as needed
            child: Text(
              _weather?.areaName ?? "",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ), // Optional: Adjust the font size
            ),
          ),
          // Add other widgets as needed
        ],
    );
  }

  

  Widget _weatherIcon() {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 35,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent1,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      padding: const EdgeInsets.all(
        4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
