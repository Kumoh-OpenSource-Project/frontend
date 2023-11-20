import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/view/screens/login_screen.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/home/view/screens/main_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), checkLoginStatus);
  }

  Future<void> checkLoginStatus() async {
    final accessToken = await ref.read(localStorageProvider).getAccessToken();

    // Navigator를 이용하여 화면 전환
    if (accessToken != null && accessToken.isNotEmpty) {
      Navigator.of(context).pushReplacement(_createMainPageRoute());
    } else {
      Navigator.of(context).pushReplacement(_createLoginPageRoute());
    }
  }

  MaterialPageRoute<dynamic> _createMainPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => MainPage());
  }

  MaterialPageRoute<dynamic> _createLoginPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/starhub_letter.png',
                height: MediaQuery.of(context).size.height / 2,
              ),
              const SizedBox(height: 16.0),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
