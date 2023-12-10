import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/auth/model/repository/auth_repository.dart';
import 'package:star_hub/auth/model/service/auth_service.dart';
import 'package:star_hub/auth/viewmodel/main_view_model.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/pages/main_screen.dart';
import 'package:star_hub/community/model/state/state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final authService;

  Future<void> _handleKakaoLogin() async {
    // print(await KakaoSdk.origin);
    bool isInstalled = await isKakaoTalkInstalled();
    OAuthToken? token;

    try {
      token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      debugPrint(isInstalled ? '카카오톡으로 로그인 성공' : '카카오계정으로 로그인 성공');
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      if (isInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          debugPrint('loginWithKaKaoAccount로 다시 시도 성공');
        } catch (error) {
          debugPrint('loginWithKaKaoAccount로 다시 시도 실패 $error');
        }
      } else {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }

    if (token != null) {
      authService = AuthService(token.accessToken);
      await _saveTokensToLocalStorage(token.accessToken, token.refreshToken);

      print(token);
      try {
        await authService.login(token.accessToken);
        debugPrint("로그인 성공");
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      } catch (error) {
        debugPrint("로그인 실패: $error");
      }
    }
  }

  Future<void> _saveTokensToLocalStorage(
      String accessToken, String? refreshToken) async {
    try {
      final localStorage = ref.read(localStorageProvider);
      await localStorage.saveTokens(accessToken, refreshToken);
      debugPrint('토큰 저장 성공');
    } catch (error) {
      debugPrint('토큰 저장 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/galaxy.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Text(
                    "천체의\n조각을 한데 얽다",
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _handleKakaoLogin();
              },
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
              child: Image.asset('assets/kakaotalk.png'),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
