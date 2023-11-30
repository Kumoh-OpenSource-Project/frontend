import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../model/home_repository.dart';

class SunMoonInfo extends StatelessWidget {
  final TodayWeatherData? todayWeatherData;
  final WeatherData? weatherData;

  const SunMoonInfo({
    Key? key,
    this.todayWeatherData,
    this.weatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SunMoonData> data = todayWeatherData != null
        ? _getSunMoonDataFromTodayWeather(todayWeatherData!)
        : weatherData != null
            ? _getSunMoonDataFromWeather(weatherData!)
            : [];

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

  List<SunMoonData> _getSunMoonDataFromTodayWeather(TodayWeatherData data) {
    return _formatSunMoonData(
      data.sunrise,
      data.sunset,
      data.moonrise,
      data.moonset,
    );
  }

  List<SunMoonData> _getSunMoonDataFromWeather(WeatherData data) {
    return _formatSunMoonData(
      data.sunrise,
      data.sunset,
      data.moonrise,
      data.moonset,
    );
  }

  List<SunMoonData> _formatSunMoonData(
    String sunriseTime,
    String sunsetTime,
    String moonriseTime,
    String moonsetTime,
  ) {
    String formatTime(String time) {
      if (time == "--:--") {
        return "--:--";
      }

      List<String> parts = time.split(' ');
      String period = parts[0];
      String clockTime = parts[1];

      return '$period\n$clockTime';
    }

    return [
      SunMoonData(
        icon: WeatherIcons.sunrise,
        text: formatTime(sunriseTime),
      ),
      SunMoonData(
        icon: WeatherIcons.sunset,
        text: formatTime(sunsetTime),
      ),
      SunMoonData(
        icon: WeatherIcons.moonrise,
        text: formatTime(moonriseTime),
      ),
      SunMoonData(
        icon: WeatherIcons.moonset,
        text: formatTime(moonsetTime),
      ),
    ];
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
