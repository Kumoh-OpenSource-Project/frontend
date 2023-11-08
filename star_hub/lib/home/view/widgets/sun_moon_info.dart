import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../model/home_repository.dart';

class SunMoonInfo extends StatelessWidget {
  SunMoonInfo({
    Key? key,
  }) : super(key: key);

  final List<SunMoonData> data = [
    SunMoonData(
      icon: WeatherIcons.sunrise,
      text: '오전\n05:50',
    ),
    SunMoonData(
      icon: WeatherIcons.sunset,
      text: '오후\n06:30',
    ),
    SunMoonData(
      icon: WeatherIcons.moonrise,
      text: '오전\n05:30',
    ),
    SunMoonData(
      icon: WeatherIcons.moonset,
      text: '오후\n06:15',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data.map((item) {
          return IconWithText(
            icon: item.icon,
            text: item.text,
          );
        }).toList(),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

