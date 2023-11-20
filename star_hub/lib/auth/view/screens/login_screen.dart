import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:star_hub/auth/model/auth_service.dart';
import 'package:star_hub/auth/model/login_request_dto.dart';
import 'package:star_hub/auth/model/repository/auth_repository.dart';
import 'package:star_hub/auth/viewmode/main_view_model.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/view/screens/full_post_screen.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/home/view/screens/main_screen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  Future<void> saveTokensToLocalStorage(String accessToken, String? refreshToken) async {
    try {
      final localStorage = ref.read(localStorageProvider);

      await localStorage.saveTokens(accessToken, refreshToken);
      debugPrint('토큰이 안전하게 저장되었습니다.');
    } catch (error) {
      debugPrint('토큰 저장 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository(dio);
    final viewModel = ref.watch(authViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 200,),
            const SizedBox(
              height: 250,
              child: Text('Star Hub', style: kTextContentStyleLargeLogo,),
            ),

            ElevatedButton(
                onPressed: () async {
                  print(await KakaoSdk.origin);
                  bool isInstalled = await isKakaoTalkInstalled();
                  OAuthToken? token;
                  AuthService authService = AuthService();
                  if (isInstalled) {
                    try {
                      token = await UserApi.instance.loginWithKakaoTalk();
                      debugPrint('카카오톡으로 로그인 성공');
                    } catch (error) {
                      debugPrint('카카오톡으로 로그인 실패 $error');
                      if (error is PlatformException &&
                          error.code == 'CANCELED') {
                        return;
                      }
                      try {
                        token = await UserApi.instance.loginWithKakaoAccount();
                        debugPrint('카카오계정으로 로그인 성공');
                      } catch (error) {
                        debugPrint('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      token = await UserApi.instance.loginWithKakaoAccount();
                      debugPrint('카카오계정으로 로그인 성공');
                    } catch (error) {
                      debugPrint('카카오계정으로 로그인 실패 $error');
                    }
                  }
                  if (token != null) {
                    // 여기 추가하고 싶음.
                    print('ㄱㄱㄱㄱㄱ');
                    await saveTokensToLocalStorage(token.accessToken, token.refreshToken);
                    try {
                      LoginRequestDto loginResponse = await authRepository.login('Bearer ${token.accessToken}');
                      print("로그인 성공: ${loginResponse.toJson()}");
                    } catch (error) {
                      print("로그인 실패: $error");
                    }
                    try {
                      LoginRequestDto loginResponse = await authRepository.getUser('Bearer ${token.accessToken}');
                      print("로그인 성공: ${loginResponse.toJson()}");
                    } catch (error) {
                      print("로그인 실패: $error");
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                child: Image.asset('assets/kakaotalk.png')),
          ],
        ),
      ),
    );
  }
}
