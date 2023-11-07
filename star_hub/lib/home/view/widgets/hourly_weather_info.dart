import 'package:flutter/material.dart';

import '../../model/home_repository.dart';

class HourlyWeatherInfo extends StatelessWidget {
  const HourlyWeatherInfo({
    super.key,
    required this.hourlyWeatherData,
  });

  final List<HourlyWeather> hourlyWeatherData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/sunny.png'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: hourlyWeatherData.map((data) {
                return Column(
                  children: [
                    Text(data.hour),
                    Image.asset('assets/${data.weather}.png', width: 45),
                    Text(data.temperature),
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
