import 'package:flutter/material.dart';
import '../../model/home_repository.dart';
import '../widgets/description.dart';
import '../widgets/hourly_weather_info.dart';
import '../widgets/image_slider.dart';
import '../widgets/date_navigation.dart';
import '../widgets/page_indicator.dart';
import '../widgets/sun_moon_info.dart';
import '../widgets/weather_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(imagePath: 'assets/moon.png'),
      _buildPage(title: '보름달'),
      _buildPage(title: 'D-DAY'),
    ];

    final hourlyWeatherData = [
      HourlyWeather(hour: '1시', weather: 'cloudy', temperature: '20˚'),
      HourlyWeather(hour: '2시', weather: 'cloudy', temperature: '19˚'),
      HourlyWeather(hour: '3시', weather: 'cloudy', temperature: '18˚'),
      HourlyWeather(hour: '4시', weather: 'sunny', temperature: '18˚'),
      HourlyWeather(hour: '5시', weather: 'sunny', temperature: '17˚'),
      HourlyWeather(hour: '6시', weather: 'sunny', temperature: '16˚'),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const DateNavigation(),
          ImageSlider(controller: controller, pages: pages),
          PageIndicator(controller: controller, pages: pages),
          const Description(),
          SunMoonInfo(),
          const WeatherInfo(),
          HourlyWeatherInfo(hourlyWeatherData: hourlyWeatherData)
        ],
      ),
    );
  }

  Widget _buildPage({String? imagePath, String? title}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: imagePath != null
          ? Center(child: Image.asset(imagePath))
          : Center(
              child: Text(
              title ?? '',
              style: const TextStyle(fontSize: 28),
            )),
    );
  }
}
