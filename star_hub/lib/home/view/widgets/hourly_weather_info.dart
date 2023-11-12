import 'package:flutter/material.dart';

import '../../model/home_repository.dart';

class HourlyWeatherInfo extends StatelessWidget {
  final TodayWeatherData? todayWeatherData;
  final WeatherData? otherDayWeatherData;

  const HourlyWeatherInfo({
    Key? key,
    this.todayWeatherData,
    this.otherDayWeatherData,
  }) : super(key: key);

  String formatHourlyTime(String timeString) {
    if (timeString.length == 4 || timeString.length > 4) {
      final hour = timeString.substring(0, 2);
      return '$hour시';
    } else {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TodayWeatherInfo> weatherDataList;

    if (todayWeatherData != null) {
      weatherDataList = todayWeatherData!.weathers;
    } else if (otherDayWeatherData != null) {
      weatherDataList = otherDayWeatherData!.weathers.map((info) {
        return TodayWeatherInfo(
          fcstTime: info.time,
          icon: info.icon,
          temp: info.temp.toString(),
          humidity: '',
        );
      }).toList();
    } else {
      weatherDataList = [];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(todayWeatherData != null) Image.asset('assets/sunny.png'),
              Row(
                children: weatherDataList.map((data) {
                  return Column(
                    children: [
                      Text(formatHourlyTime(data.fcstTime)),
                      Image.asset('assets/${data.icon}.png', width: 45),
                      Text('${data.temp}˚'),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
