import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/home_repository.dart';
import '../../model/home_service.dart';
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
  final HomeService homeService = HomeService();
  late TodayWeatherData todayWeatherData;
  late List<WeatherData> dummyWeatherData;
  late RealTimeWeatherInfo dummyRealTimeWeatherInfo;
  late RealTimeWeatherInfo dummyRealTimeWeatherInfo2;
  late DateTime currentDate;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    currentDate = today;

    fetchData();
    fetchData2();
    fetchData3();
  }

  Future<TodayWeatherData> fetchData() async {
    try {
      setState(() {
        todayWeatherData = TodayWeatherData(
          sunrise: '오전 00:00',
          sunset: '오후 00:00',
          moonrise: '오전 00:00',
          moonset: '오후 00:00',
          weathers: [
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
            TodayWeatherInfo(
                fcstTime: '0000', icon: '01d', temp: '00', humidity: '00'),
          ],
        );
      });

      todayWeatherData = await homeService.getTodayWeatherData();
      setState(() {
        todayWeatherData = todayWeatherData;
      });
    } catch (e) {
      // 에러 처리
    }
    return todayWeatherData;
  }

  Future<RealTimeWeatherInfo> fetchData2() async {
    try {
      setState(() {
        dummyRealTimeWeatherInfo = RealTimeWeatherInfo(
          main: 'Clear',
          description: 'Clear sky',
          icon: '01d',
          temp: 00.00,
          feelsLike: 00.00,
          tempMin: 00.00,
          tempMax: 00.00,
          humidity: 00,
          windSpeed: 0.00,
          windDeg: 0,
          seeing: 9,
          lunAge: 0,
        );
      });
      dummyRealTimeWeatherInfo = await homeService.getCurrentWeather();
      setState(() {
        dummyRealTimeWeatherInfo = dummyRealTimeWeatherInfo;
      });
    } catch (e) {
      // Handle errors
    }
    return dummyRealTimeWeatherInfo;
  }

  Future<void> fetchData3() async {
    try {
      setState(() {
        dummyWeatherData = List.generate(
          5,
          (index) {
            final nextDate = today.add(Duration(days: index + 1));
            return WeatherData(
              date: DateFormat('yyyy-MM-dd').format(nextDate),
              weathers: List.generate(
                8,
                (hour) => WeekHourlyWeatherInfo(
                  main: "Clouds",
                  description: "튼구름",
                  icon: "01d",
                  temp: 0.00,
                  time: "${(hour * 3).toString().padLeft(2, '0')}:00",
                ),
              ),
              sunrise: "오전 00:00",
              sunset: "오후 00:00",
              moonrise: "오전 00:00",
              moonset: "오후 00:00",
              seeing: 9,
              lunAge: 0,
            );
          },
        );
      });

      dummyWeatherData = await homeService.getWeeklyWeather();
      setState(() {
        dummyWeatherData = dummyWeatherData;
      });
    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isToday = currentDate.isAtSameMomentAs(today);

    final pages = [
      _buildPage(
          imagePath: isToday
              ? 'assets/moon/${dummyRealTimeWeatherInfo.lunAge + 1}.png'
              : 'assets/moon/${dummyWeatherData.firstWhere((data) => data.date == DateFormat('yyyy-MM-dd').format(currentDate)).lunAge + 1}.png'),
      _buildPage(title: '보름달'),
      _buildPage(title: 'D-DAY'),
    ];

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
              ? HourlyWeatherInfo(
                  todayWeatherData: todayWeatherData,
                  realTimeWeatherData: dummyRealTimeWeatherInfo)
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
