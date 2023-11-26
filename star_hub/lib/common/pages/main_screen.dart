import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/view/screens/full_post_screen.dart';
import 'package:star_hub/home/view/screens/home_screen.dart';
import 'package:star_hub/my_page/view/screens/my_page_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../community/view/screens/search_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

//

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: _currentIndex,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildTabBarView(),
      bottomNavigationBar: buildMotionTabBar(),
    );
  }

  void showLunarCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black26,
          content: Container(
            width: 300,
            height: 400,
            child: Center(
              child: TableCalendar(
                availableCalendarFormats: const {CalendarFormat.month: 'month'},
                focusedDay: DateTime.now(),
                firstDay: DateTime(2000),
                lastDay: DateTime(2050),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontSize: 20),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '🌕',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${date.day}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                  todayBuilder: (context, date, _) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '🌕',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${date.day}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    String title = "STAR HUB";
    Widget? actions;

    if (_currentIndex == 0) {
      actions = IconButton(
        icon: const Icon(Icons.calendar_today_rounded),
        onPressed: () => showLunarCalendar(context),
      );
    } else if (_currentIndex == 1) {
      actions = IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          );
        },
      );
    }

    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Text(title, style: kTextContentStyleSmallLogo),
      actions: actions != null ? [actions] : null,
    );
  }

  Container buildTabBarView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(0, 5),
          colors: [Colors.black, Colors.white],
        ),
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: const <Widget>[
          Center(child: HomePage()),
          Center(child: FullPostPage()),
          Center(child: MyPageScreen()),
        ],
      ),
    );
  }

  MotionTabBar buildMotionTabBar() {
    return MotionTabBar(
      controller: _motionTabBarController,
      initialSelectedTab: "HOME",
      labels: const ["HOME", "COMMUNITY", "MY PAGE"],
      icons: const [Icons.home, Icons.speaker_notes_rounded, Icons.person],
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: _currentIndex != 0
          ? const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )
          : const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      tabIconColor: _currentIndex != 0 ? Colors.black : Colors.white,
      tabIconSize: 30.0,
      tabIconSelectedSize: 28.0,
      tabSelectedColor: _currentIndex != 0 ? Colors.black : Colors.white,
      tabIconSelectedColor: _currentIndex != 0 ? Colors.white : Colors.black,
      tabBarColor: _currentIndex != 0 ? Colors.white : Colors.black,
      onTabItemSelected: (int value) {
        setState(() {
          _motionTabBarController!.index = value;
          _currentIndex = value;
        });
      },
    );
  }
}
