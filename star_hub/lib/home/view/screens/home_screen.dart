import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'STAR HUB',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded),
            onPressed: () {
              // handle the press
            },
          )
        ],
      ),
      body: Container(
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
            Center(
              child: Text("Home"),
            ),
            Center(
              child: Text("Community"),
            ),
            Center(
              child: Text("My Page"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "HOME",
        labels: const ["HOME", "COMMUNITY", "MY PAGE"],
        icons: const [Icons.home, Icons.speaker_notes_rounded, Icons.person],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.white,
        tabIconSize: 30.0,
        tabIconSelectedSize: 28.0,
        tabSelectedColor: Colors.white,
        tabIconSelectedColor: Colors.black,
        tabBarColor: Colors.black,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
