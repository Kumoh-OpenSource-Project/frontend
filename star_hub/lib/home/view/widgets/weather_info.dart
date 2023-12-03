import 'package:flutter/material.dart';

import '../../model/home_entity.dart';

class WeatherInfo extends StatelessWidget {
  final RealTimeWeatherInfo? realTimeWeatherData;

  const WeatherInfo({
    Key? key,
    this.realTimeWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      '${realTimeWeatherData?.temp.ceil().toString()}˚',
                      style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 32,
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 40,
                      ),
                    ),
                    Text(
                      '${realTimeWeatherData?.tempMax.toString()}˚',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 32,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                      ),
                    ),
                    Text(
                      '${realTimeWeatherData?.tempMin.toString()}˚',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              width: 170,
              height: 110,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.white,
                    width: 1.3,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '체감 기온 ${realTimeWeatherData?.feelsLike.toString()}˚',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '현재 습도 ${realTimeWeatherData?.humidity.toString()}%',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '바람 세기 ${realTimeWeatherData?.windSpeed.toString()}km/h',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '바람 방향 ${getWindDirection(realTimeWeatherData?.windDeg ?? 0)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getWindDirection(int windDegree) {
  if (windDegree >= 337.5 || windDegree < 22.5) {
    return '북풍';
  } else if (windDegree >= 22.5 && windDegree < 67.5) {
    return '북동풍';
  } else if (windDegree >= 67.5 && windDegree < 112.5) {
    return '동풍';
  } else if (windDegree >= 112.5 && windDegree < 157.5) {
    return '남동풍';
  } else if (windDegree >= 157.5 && windDegree < 202.5) {
    return '남풍';
  } else if (windDegree >= 202.5 && windDegree < 247.5) {
    return '남서풍';
  } else if (windDegree >= 247.5 && windDegree < 292.5) {
    return '서풍';
  } else if (windDegree >= 292.5 && windDegree < 337.5) {
    return '북서풍';
  } else {
    return '방향 없음';
  }
}
