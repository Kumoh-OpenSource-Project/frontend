import 'package:flutter/material.dart';

import '../../model/home_entity.dart';

class Description extends StatelessWidget {
  final RealTimeWeatherInfo? realTimeWeatherInfo;
  final WeatherData? otherDayWeatherData;

  const Description({
    Key? key,
    this.realTimeWeatherInfo,
    this.otherDayWeatherData,
  }) : super(key: key);

  String getSeeingText(int seeing) {
    if (seeing >= 0.0 && seeing <= 1.0) {
      return "현재는 천체 관측에 가장 이상적인 조건입니다. 맑은 하늘과 뛰어난 기상 조건을 활용해 별, 행성, 은하 등을 관찰하는 데 최적의 시간입니다.";
    } else if (seeing > 1.0 && seeing <= 2.0) {
      return "현재 천체 관측 조건이 아주 좋습니다. 많은 별과 행성을 쉽게 볼 수 있으며, 몇몇 은하도 관찰할 수 있을 것입니다.";
    } else if (seeing > 2.0 && seeing <= 3.0) {
      return "관측 조건이 꽤 좋습니다. 대부분의 별과 행성을 볼 수 있으며, 밝은 은하도 볼 수 있을 것입니다.";
    } else if (seeing > 3.0 && seeing <= 4.0) {
      return "현재 조건은 양호합니다. 별과 행성은 여전히 잘 보이지만, 은하를 관찰하기는 조금 어려울 수 있습니다.";
    } else if (seeing > 4.0 && seeing <= 5.0) {
      return "현재 천체 관측 조건이 보통입니다. 별과 행성은 여전히 볼 수 있지만, 은하 관찰은 더 어려워질 것입니다.";
    } else if (seeing > 5.0 && seeing <= 6.0) {
      return "현재 조건에서는 별과 행성 관찰은 가능하지만, 은하를 관찰하기는 어려울 것입니다.";
    } else if (seeing > 6.0 && seeing <= 7.0) {
      return "현재 천체 관측에는 어려운 조건입니다. 가장 밝은 별과 행성만 볼 수 있을 것입니다.";
    } else if (seeing > 7.0 && seeing <= 8.0) {
      return "현재는 천체 관측에 매우 부적합한 조건입니다. 맑은 날을 기다리는 것이 좋을 것입니다.";
    } else {
      return "현재 조건에 대한 정보가 없습니다.";
    }
  }

  Widget buildDescriptionText(int seeing) {
    return Text(
      getSeeingText(seeing),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Column(
        children: [
          if (realTimeWeatherInfo != null)
            buildDescriptionText(realTimeWeatherInfo!.seeing),
          if (otherDayWeatherData != null)
            buildDescriptionText(otherDayWeatherData!.seeing),
        ],
      ),
    );
  }
}
