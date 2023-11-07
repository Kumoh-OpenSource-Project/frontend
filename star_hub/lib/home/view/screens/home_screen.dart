import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateNavigation(),
          _buildImageSlider(pages),
          _buildPageIndicator(pages),
          _buildDescription(),
          _buildSunMoonInfo(),
          _buildWeatherInfo(),
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

  Widget _buildDateNavigation() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          const Column(
            children: [
              Text(
                'Wednesday',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '10월 18일',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(List<Widget> pages) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        itemBuilder: (_, index) {
          return pages[index % pages.length];
        },
      ),
    );
  }

  Widget _buildPageIndicator(List<Widget> pages) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SmoothPageIndicator(
        controller: controller,
        count: pages.length,
        effect: const WormEffect(
          activeDotColor: Colors.black45,
          dotHeight: 8,
          dotWidth: 8,
          type: WormType.thinUnderground,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        '현재 구름이 적고 대기가 맑아\n천체를 관측하기 매우 좋습니다',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildSunMoonInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconWithText(WeatherIcons.sunrise, '오전\n05:50'),
          _buildIconWithText(WeatherIcons.sunset, '오후\n06:30'),
          _buildIconWithText(WeatherIcons.moonrise, '오전\n05:30'),
          _buildIconWithText(WeatherIcons.moonset, '오후\n06:15'),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(left: 35),
                child: Text(
                  '9˚',
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 40,
                  ),
                ),
                Text(
                  '9˚',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 32,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                  ),
                ),
                Text(
                  '6˚',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Container(
          width: 170,
          height: 110,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.white,
                width: 1.3,
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '체감 기온 7˚',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '현재 습도 66%',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '바람 세기 3.65km/h',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '바람 방향 북서풍',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconWithText(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
