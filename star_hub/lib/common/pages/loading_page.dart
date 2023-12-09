// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/model/service/auth_service.dart';
import 'package:star_hub/auth/view/screens/login_screen.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/pages/main_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  double _opacity = 0.0; // Initial opacity value

  @override
  void initState() {
    super.initState();
    _checkLoginStatusAfterDelay();
  }

  Future<void> _checkLoginStatusAfterDelay() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _opacity = 1.0);
    await Future.delayed(const Duration(seconds: 3));
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final accessToken = await ref.read(localStorageProvider).getAccessToken();

    if (!mounted) return;
    if (accessToken != null && accessToken.isNotEmpty) {
      final authService = AuthService(accessToken);
      try {
        await authService.login(accessToken);
        print("로그인 시도");
        Navigator.of(context).pushReplacement(_createMainPageRoute());
        print("로그인 성공");
      } catch (error) {
        print("액세스 토큰 만료, 다시 로그인");
        _showSnackbar("Error: Unable to communicate with the server.");
        Navigator.of(context).pushReplacement(_createLoginPageRoute());
      }
    } else {
      print("처음 로그인");
      Navigator.of(context).pushReplacement(_createLoginPageRoute());
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'STAR HUB',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                    fontFamily: "JustAnotherHand-Regular",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: const Text(
                  '우주를 기억하는 법',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                      fontFamily: "Dovemayo_gothic"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialPageRoute<dynamic> _createMainPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => const MainPage());
  }

  MaterialPageRoute<dynamic> _createLoginPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => const LoginPage());
  }
}
