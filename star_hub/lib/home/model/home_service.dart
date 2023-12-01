import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_hub/common/local_storage/local_storage.dart';

import 'home_repository.dart';

class HomeService {
  static const String baseUrl =
      'http://ec2-3-39-84-165.ap-northeast-2.compute.amazonaws.com:3000';

  Future<Map<String, String>> _createHeaders() async {
    String? token = await LocalStorage().getAccessToken();
    //"kz7D-iGSZbsVGHiUUddOoXfQcO3JeXzS4LYKPXNNAAABjBZT1B3OkqTnJF629A";

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
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


  Future<TodayWeatherData> getTodayWeatherData() async {
    const url = '$baseUrl/home?type=today&lat=36.14578&lon=128.39394';

    final response = await http.get(
      Uri.parse(url),
      headers: await _createHeaders(),
    );

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
      final response = await http.get(
        Uri.parse(url),
        headers: await _createHeaders(),
      );

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
      final response = await http.get(
        url,
        headers: await _createHeaders(),
      );

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
