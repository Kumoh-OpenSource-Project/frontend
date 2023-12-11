import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/home/model/home_repository.dart';
import 'package:star_hub/home/model/state.dart';
import 'package:dio/dio.dart';
import 'home_entity.dart';
import 'package:geolocator/geolocator.dart';

final homeServiceProvider =
StateNotifierProvider<HomeService, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeService(repository);
});

class HomeService extends StateNotifier<HomeState> {
  final HomeRepository repository;
  late Position position;
  HomeService(this.repository) : super(HomeStateNone()) {
   initialize();
  }

  Future<void> initialize() async {
    try {
      state = HomeStateLoading();
      position = await getCurrentLocation();
      EventData? eventData = await getEventData();
      TodayWeatherData? todayWeatherData = await getTodayWeatherData();
      RealTimeWeatherInfo? currentWeather = await getCurrentWeather();
      List<WeatherData>? weeklyWeather = await getWeeklyWeather();
      if (todayWeatherData != null && currentWeather != null && eventData != null && weeklyWeather != null) {
        state = HomeStateSuccess(todayWeatherData, currentWeather, weeklyWeather, eventData);
      } else {
        state = HomeStateError('에러: 데이터를 불러올 수 없습니다.');
      }
    } catch (e) {
      state = HomeStateError('에러: $e');
    }
  }

  Future<TodayWeatherData?> getTodayWeatherData() async {
    try {
      final response = await repository.getTodayData(position.latitude, position.longitude);
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

  Future<EventData?> getEventData() async {
    try {
      final response = await repository.getEventData();
      return response;
    } on DioException catch (e) {
      print('Failed to load event data DioError: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }

  Future<RealTimeWeatherInfo?> getCurrentWeather() async {
    try {
      final response = await repository.getRealTimeData(position.latitude, position.longitude);
      return response;
    } on DioException catch (e) {
      print('Failed to load current weather data. DioError: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }

  Future<List<WeatherData>?> getWeeklyWeather() async {
    try {
      final response = await repository.getWeekData(position.latitude, position.longitude);
      return response;
    } on DioException catch (e) {
      print('Failed to load weekly weather data. DioError: ${e.message}');
      return null;
    } catch (e) {
      print('여기 ? Unexpected Error: $e');
      return null;
    }
    return null;

  }

  Future<Position> getCurrentLocation() async {
    try {
      Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return currentLocation;
    } catch (e) {
      print("Error getting current location: $e");
      rethrow;
    }
  }
}
