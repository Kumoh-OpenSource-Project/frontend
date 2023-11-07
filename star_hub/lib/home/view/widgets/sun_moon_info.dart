import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class SunMoonInfo extends StatelessWidget {
  const SunMoonInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconWithText(icon: WeatherIcons.sunrise, text: '오전\n05:50'),
          IconWithText(icon: WeatherIcons.sunset, text: '오후\n06:30'),
          IconWithText(icon: WeatherIcons.moonrise, text: '오전\n05:30'),
          IconWithText(icon: WeatherIcons.moonset, text: '오후\n06:15'),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
  });

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
