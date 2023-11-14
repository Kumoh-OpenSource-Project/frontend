import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_repository.dart';

class HomeService {
  static const String baseUrl = 'https://starhub.fly.dev';

  Future<TodayWeatherData> getTodayWeatherData() async {
    const url = '$baseUrl/home?type=today&lat=36.14578&lon=128.39394';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final todayWeatherData = TodayWeatherData.fromJson(jsonData);
      return todayWeatherData;
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  Future<RealTimeWeatherInfo> getCurrentWeather() async {
    const url = '$baseUrl/home?type=current&lat=36.14578&lon=128.39394';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return RealTimeWeatherInfo.fromJson(data);
      } else {
        throw Exception('Failed to load current weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<WeatherData>> getWeeklyWeather() async {
    final url = Uri.parse('$baseUrl/home?type=week&lat=36.14578&lon=128.39394');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => WeatherData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load weekly weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
