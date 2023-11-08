import 'package:flutter/material.dart';

class HourlyWeather {
  final String hour;
  final String weather;
  final String temperature;

  HourlyWeather({required this.hour, required this.weather, required this.temperature});
}

class SunMoonData {
  final IconData icon;
  final String text;

  SunMoonData({
    required this.icon,
    required this.text,
  });
}
