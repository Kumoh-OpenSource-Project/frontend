import 'package:flutter/material.dart';

class SunMoonData {
  final IconData icon;
  final String text;

  SunMoonData({
    required this.icon,
    required this.text,
  });
}

class TodayWeatherData {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final List<TodayWeatherInfo> weathers;

  TodayWeatherData({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.weathers,
  });
}

class TodayWeatherInfo {
  final String fcstTime;
  final String icon;
  final String temp;
  final String humidity;

  TodayWeatherInfo({
    required this.fcstTime,
    required this.icon,
    required this.temp,
    required this.humidity,
  });
}

class WeatherData {
  final String date;
  final List<WeekHourlyWeatherInfo> weathers;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final int seeing;

  WeatherData({
    required this.date,
    required this.weathers,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.seeing,
  });

// factory WeatherData.fromJson(Map<String, dynamic> json) {
//   final List<dynamic> weatherList = json['weathers'];
//   return WeatherData(
//     date: json['date'],
//     weathers: weatherList.map((weather) => WeekHourlyWeatherInfo.fromJson(weather)).toList(),
//     sunrise: json['sunrise'],
//     sunset: json['sunset'],
//     moonrise: json['moonrise'],
//     moonset: json['moonset'],
//     seeing: json['seeing'],
//   );
// }
}

class WeekHourlyWeatherInfo {
  final String main;
  final String description;
  final String icon;
  final double temp;
  final String time;

  WeekHourlyWeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.time,
  });

// factory WeekHourlyWeatherInfo.fromJson(Map<String, dynamic> json) {
//   return WeekHourlyWeatherInfo(
//     main: json['main'],
//     description: json['description'],
//     icon: json['icon'],
//     temp: json['temp'].toDouble(),
//     time: json['time'],
//   );
// }
}

class RealTimeWeatherInfo {
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double humidity;
  final double windSpeed;
  final double windDeg;
  final int seeing;

  RealTimeWeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.seeing,
  });
}
