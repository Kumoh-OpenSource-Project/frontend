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
  @override
  void initState() {
    super.initState();
    _checkLoginStatusAfterDelay();
  }

  Future<void> _checkLoginStatusAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
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
        Navigator.of(context).pushReplacement(_createLoginPageRoute());
      }
    } else {
      print("처음 로그인");
      Navigator.of(context).pushReplacement(_createLoginPageRoute());
    }
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

  MaterialPageRoute<dynamic> _createMainPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => const MainPage());
  }

  MaterialPageRoute<dynamic> _createLoginPageRoute() {
    return MaterialPageRoute<dynamic>(builder: (context) => const LoginPage());
  }
}
