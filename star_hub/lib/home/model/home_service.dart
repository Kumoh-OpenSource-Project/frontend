import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/home/model/home_repository.dart';
import 'package:star_hub/home/model/state.dart';
import 'package:dio/dio.dart';
import 'home_entity.dart';

final homeServiceProvider =
    StateNotifierProvider<HomeService, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeService(repository);
});

class HomeService extends StateNotifier<HomeState> {
  final HomeRepository repository;

  HomeService(this.repository) : super(HomeStateNone()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      state = HomeStateLoading();
      TodayWeatherData? todayWeatherData = await getTodayWeatherData();
      RealTimeWeatherInfo? currentWeather = await getCurrentWeather();
      List<WeatherData> weeklyWeather = await getWeeklyWeather();

      if (todayWeatherData != null && currentWeather != null) {
        state =
            HomeStateSuccess(todayWeatherData, currentWeather, weeklyWeather);
      } else {
        state = HomeStateError('에러: 데이터를 불러올 수 없습니다.');
      }
    } catch (e) {
      state = HomeStateError('에러: $e');
    }
  }

  Future<TodayWeatherData?> getTodayWeatherData() async {
    try {
      final response = await repository.getTodayData();
      return response;
    } on DioException catch (e) {
      print('Failed to load today weather data DioError: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }

  Future<List<LunarData>?> getLunarData(String year, String month) async {
    try {
      final response = await repository.getLunarData(year, month);
      return response;
    } on DioException catch (e) {
      print('Failed to load lunar data DioError: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }

  Future<RealTimeWeatherInfo?> getCurrentWeather() async {
    try {
      final response = await repository.getRealTimeData();
      return response;
    } on DioException catch (e) {
      print('Failed to load current weather data. DioError: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }

  Future<List<WeatherData>> getWeeklyWeather() async {
    try {
      final response = await repository.getWeekData();
      return response;
    } on DioException catch (e) {
      print('Failed to load weekly weather data. DioError: ${e.message}');
    } catch (e) {
      print('여기 ? Unexpected Error: $e');
    }
    return [];
  }
}
