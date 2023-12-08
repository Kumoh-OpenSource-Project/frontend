import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:star_hub/home/model/state.dart';
import 'package:star_hub/home/view_model/home_viewmodel.dart';

import '../../model/home_entity.dart';
import '../widgets/description.dart';
import '../widgets/hourly_weather_info.dart';
import '../widgets/image_slider.dart';
import '../widgets/date_navigation.dart';
import '../widgets/page_indicator.dart';
import '../widgets/sun_moon_info.dart';
import '../widgets/weather_info.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;
  List<String> messages = [
    "달 따오는 중",
    "달 따오는 중 .",
    "달 따오는 중 . .",
    "달 따오는 중 . . ."
  ];
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late TodayWeatherData todayWeatherData;
  late List<WeatherData> dummyWeatherData;
  late RealTimeWeatherInfo dummyRealTimeWeatherInfo;
  late RealTimeWeatherInfo dummyRealTimeWeatherInfo2;
  late DateTime currentDate;
  late DateTime today;
  late Timer _timer;

  void startTimer() {
    const halfSecond = Duration(milliseconds: 500);
    _timer = Timer.periodic(halfSecond, (timer) {
      // Update the index every 0.5 seconds
      setState(() {
        currentIndex = (currentIndex + 1) % messages.length;
      });
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    currentDate = today;
    fetchData();
    fetchData2();
    fetchData3();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  TodayWeatherData fetchData() {
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

    return todayWeatherData;
  }

  RealTimeWeatherInfo fetchData2() {
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

    return dummyRealTimeWeatherInfo;
  }

  void fetchData3() {
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
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(homeViewModelProvider);
    bool isToday = currentDate.isAtSameMomentAs(today);
    if (viewModel.homeState is HomeStateSuccess) {
      stopTimer();
    }
    final pages = [
      _buildPage(
          imagePath: viewModel.homeState is HomeStateSuccess
              ? isToday
                  ? 'assets/moon/${viewModel.realTimeData.lunAge + 1}.png'
                  : 'assets/moon/${viewModel.weekData.firstWhere((data) => data.date == DateFormat('yyyy-MM-dd').format(currentDate)).lunAge + 1}.png'
              : isToday
                  ? 'assets/moon/${dummyRealTimeWeatherInfo.lunAge + 1}.png'
                  : 'assets/moon/${dummyWeatherData.firstWhere((data) => data.date == DateFormat('yyyy-MM-dd').format(currentDate)).lunAge + 1}.png'),
      _buildPage(
          lunAge: viewModel.homeState is HomeStateSuccess
              ? isToday
                  ? viewModel.realTimeData.lunAge + 1
                  : viewModel.weekData
                          .firstWhere((data) =>
                              data.date ==
                              DateFormat('yyyy-MM-dd').format(currentDate))
                          .lunAge +
                      1
              : isToday
                  ? dummyRealTimeWeatherInfo.lunAge + 1
                  : dummyWeatherData
                          .firstWhere((data) =>
                              data.date ==
                              DateFormat('yyyy-MM-dd').format(currentDate))
                          .lunAge +
                      1),
    ];

    if (isToday && viewModel.homeState is HomeStateSuccess) {
      pages.add(
        _buildPage(
          title: 'D-DAY',
          widget: EventDdayWidget(
            title: viewModel.eventData.title,
            date: viewModel.eventData.date,
            dDay: viewModel.eventData.dDay,
          ),
        ),
      );
    }

    isToday = currentDate.isAtSameMomentAs(today);
    return viewModel.homeState is HomeStateSuccess
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                    ? Description(realTimeWeatherInfo: viewModel.realTimeData)
                    : Description(
                        otherDayWeatherData: viewModel.weekData.firstWhere(
                          (data) =>
                              data.date ==
                              DateFormat('yyyy-MM-dd').format(currentDate),
                        ),
                      ),
                if (isToday) SunMoonInfo(todayWeatherData: viewModel.todayData),
                if (!isToday && viewModel.weekData.isNotEmpty)
                  SunMoonInfo(
                    weatherData: viewModel.weekData.firstWhere(
                      (data) =>
                          data.date ==
                          DateFormat('yyyy-MM-dd').format(currentDate),
                    ),
                  ),
                if (isToday)
                  WeatherInfo(realTimeWeatherData: viewModel.realTimeData),
                isToday
                    ? HourlyWeatherInfo(
                        todayWeatherData: viewModel.todayData,
                        realTimeWeatherData: viewModel.realTimeData)
                    : HourlyWeatherInfo(
                        otherDayWeatherData: viewModel.weekData.firstWhere(
                          (data) =>
                              data.date ==
                              DateFormat('yyyy-MM-dd').format(currentDate),
                        ),
                      ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/gif/moon.gif',
                  height: 250.0,
                  width: 250.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(messages[currentIndex],
                    style: const TextStyle(
                      fontFamily: "Gaegu-Regular",
                      fontSize: 18,
                    )),
              ],
            )),
          );
  }

  Widget _buildPage(
      {String? imagePath, String? title, int? lunAge, Widget? widget}) {
    if (widget != null) {
      return widget;
    }

    if (imagePath != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Center(child: Image.asset(imagePath)),
      );
    } else if (lunAge != null) {
      String moonPhase;
      if (lunAge == 16 || lunAge == 17) {
        moonPhase = '보름달';
      } else if (lunAge == 1 || lunAge == 2 || lunAge == 30) {
        moonPhase = '삭';
      } else if (lunAge > 17 && lunAge < 23) {
        moonPhase = '하현달';
      } else if (lunAge > 2 && lunAge < 8) {
        moonPhase = '초승달';
      } else if (lunAge > 8 && lunAge < 15) {
        moonPhase = '상현달';
      } else if (lunAge > 22 && lunAge < 30) {
        moonPhase = '그믐달';
      } else {
        moonPhase = '';
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
          child: Text(
            moonPhase,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
          child: Text(
            title ?? '',
            style: const TextStyle(fontSize: 28),
          ),
        ),
      );
    }
  }
}

class EventDdayWidget extends StatelessWidget {
  final String title;
  final String date;
  final int dDay;

  EventDdayWidget({
    required this.title,
    required this.date,
    required this.dDay,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'D-$dDay',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '$title 가능',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
