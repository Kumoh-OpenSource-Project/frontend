import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:star_hub/common/local_storage/local_storage.dart';
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
  static const String baseUrl =
      'http://ec2-3-39-84-165.ap-northeast-2.compute.amazonaws.com:3000';
  final HomeRepository repository;
    String? token = await LocalStorage().getAccessToken();
    //"kz7D-iGSZbsVGHiUUddOoXfQcO3JeXzS4LYKPXNNAAABjBZT1B3OkqTnJF629A";

  HomeService(this.repository) : super(HomeStateNone()) {
    _initialize();
  }

  Future<List<LunarData>> getLunarData(String year, String month) async {
    final url = "$baseUrl/home/moon?year=$year&month=$month";

    final response = await http.get(
      Uri.parse(url),
      headers: await _createHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonDataList = json.decode(response.body);

      final List<LunarData> lunarDataList = jsonDataList
          .map((jsonData) => LunarData.fromJson(jsonData))
          .toList();

      return lunarDataList;
    } else {
      throw Exception('Failed to load lunar data. Status code: ${response.statusCode}');
    }
  }

  Future<void> _initialize() async {
    try {
      state = HomeStateLoading();
      TodayWeatherData? todayWeatherData = await getTodayWeatherData();
      RealTimeWeatherInfo? currentWeather = await getCurrentWeather();
      List<WeatherData> weeklyWeather = await getWeeklyWeather();

      if (todayWeatherData != null && currentWeather != null) {
        print("성공");
        print(todayWeatherData.moonrise);
        print(currentWeather);
        print(weeklyWeather);
        state = HomeStateSuccess(todayWeatherData, currentWeather, weeklyWeather);
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
