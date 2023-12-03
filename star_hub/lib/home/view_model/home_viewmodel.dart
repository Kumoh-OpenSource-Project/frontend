import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/home/model/home_entity.dart';
import 'package:star_hub/home/model/home_service.dart';
import 'package:star_hub/home/model/state.dart';

final homeViewModelProvider =
ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  Ref ref;
  late HomeState homeState;

  TodayWeatherData get todayData =>
      (homeState as HomeStateSuccess).data;

  RealTimeWeatherInfo get realTimeData =>
      (homeState as HomeStateSuccess).data1;

  List<WeatherData> get weekData =>
      (homeState as HomeStateSuccess).data2;

  HomeViewModel(this.ref) {
    homeState = ref.read(homeServiceProvider);

    ref.listen(homeServiceProvider, (previous, next) {
      print('home State: $previous -> $next');
      if (previous != next) {
        homeState = next;
        notifyListeners();
      }
    });
  }
}
