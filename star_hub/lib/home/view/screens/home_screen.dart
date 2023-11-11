import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late TodayWeatherData todayWeatherData;
  late List<WeatherData> dummyWeatherData;
  late RealTimeWeatherInfo dummyRealTimeWeatherInfo;
  late DateTime currentDate;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    currentDate = today;

    todayWeatherData = TodayWeatherData(
      sunrise: '오전 06:30',
      sunset: '오후 05:45',
      moonrise: '오전 08:00',
      moonset: '오후 07:30',
      weathers: [
        TodayWeatherInfo(
            fcstTime: '2200', icon: 'cloudy', temp: '15', humidity: '85'),
        TodayWeatherInfo(
            fcstTime: '2300', icon: 'cloudy', temp: '15', humidity: '85'),
        TodayWeatherInfo(
            fcstTime: '0000', icon: 'cloudy', temp: '14', humidity: '85'),
        TodayWeatherInfo(
            fcstTime: '0100', icon: 'cloudy', temp: '14', humidity: '90'),
        TodayWeatherInfo(
            fcstTime: '0200', icon: 'cloudy', temp: '15', humidity: '85'),
        TodayWeatherInfo(
            fcstTime: '0300', icon: 'cloudy', temp: '14', humidity: '85'),
      ],
    );

    dummyRealTimeWeatherInfo = RealTimeWeatherInfo(
      main: 'Clear',
      description: 'Clear sky',
      icon: '01d',
      temp: 25.5,
      feelsLike: 26.8,
      tempMin: 24.0,
      tempMax: 27.0,
      humidity: 55.0,
      windSpeed: 3.0,
      windDeg: 120.0,
      seeing: 3,
    );

    dummyWeatherData = [
      WeatherData(
        date: "2023-11-12",
        weathers: [
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "00:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "03:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "06:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "09:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "12:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "15:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "18:00"),
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "21:00"),
        ],
        sunrise: "오전 06:59",
        sunset: "오후 05:22",
        moonrise: "오전 04:35",
        moonset: "오후 04:07",
        seeing: 5,
      ),
      WeatherData(
        date: "2023-11-13",
        weathers: [
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "00:00"),
        ],
        sunrise: "오전 06:59",
        sunset: "오후 05:22",
        moonrise: "오전 04:35",
        moonset: "오후 04:07",
        seeing: 2,
      ),
      WeatherData(
        date: "2023-11-14",
        weathers: [
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "00:00"),
        ],
        sunrise: "오전 06:59",
        sunset: "오후 05:22",
        moonrise: "오전 04:35",
        moonset: "오후 04:07",
        seeing: 1,
      ),
      WeatherData(
        date: "2023-11-15",
        weathers: [
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "cloudy",
              temp: 3.36,
              time: "00:00"),
        ],
        sunrise: "오전 06:59",
        sunset: "오후 05:22",
        moonrise: "오전 04:35",
        moonset: "오후 04:07",
        seeing: 8,
      ),
      WeatherData(
        date: "2023-11-16",
        weathers: [
          WeekHourlyWeatherInfo(
              main: "Clouds",
              description: "튼구름",
              icon: "sunny",
              temp: 3.36,
              time: "00:00"),
        ],
        sunrise: "오전 06:59",
        sunset: "오후 05:22",
        moonrise: "오전 04:35",
        moonset: "오후 04:07",
        seeing: 7,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(imagePath: 'assets/moon.png'),
      _buildPage(title: '보름달'),
      _buildPage(title: 'D-DAY'),
    ];

    bool isToday = currentDate.isAtSameMomentAs(today);

    return SingleChildScrollView(
      child: Column(
        children: [
          DateNavigation(
            currentDate: currentDate,
            onDateSelected: (selectedDate) {
              setState(() {
                currentDate = selectedDate;
              });
            },
          ),
          ImageSlider(controller: controller, pages: pages),
          PageIndicator(controller: controller, pages: pages),
          isToday
              ? Description(realTimeWeatherInfo: dummyRealTimeWeatherInfo)
              : Description(
                  otherDayWeatherData: dummyWeatherData.firstWhere(
                    (data) =>
                        data.date ==
                        DateFormat('yyyy-MM-dd').format(currentDate),
                  ),
                ),
          if (isToday) SunMoonInfo(todayWeatherData: todayWeatherData),
          if (!isToday && dummyWeatherData.isNotEmpty)
            SunMoonInfo(
              weatherData: dummyWeatherData.firstWhere(
                (data) =>
                    data.date == DateFormat('yyyy-MM-dd').format(currentDate),
              ),
            ),
          if (isToday)
            WeatherInfo(realTimeWeatherData: dummyRealTimeWeatherInfo),
          isToday
              ? HourlyWeatherInfo(todayWeatherData: todayWeatherData)
              : HourlyWeatherInfo(
                  otherDayWeatherData: dummyWeatherData.firstWhere(
                    (data) =>
                        data.date ==
                        DateFormat('yyyy-MM-dd').format(currentDate),
                  ),
                ),
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
              ),
            ),
    );
  }
}
