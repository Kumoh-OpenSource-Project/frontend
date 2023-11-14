import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:star_hub/auth/view/screens/social_login.dart';

class KakaoLogin {
  Future login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        final oauthToken = await UserApi.instance.loginWithKakaoTalk();
        log("kakaoToken: ${oauthToken.accessToken}");
        print(oauthToken.accessToken.toString());
      } catch (error) {
        print('뒤로가기');
      }
    } else {
      try {
        print('카카오계정으로 로그인 성공1');
        await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        print('카카오계정으로 로그인 실패1 $error');
      }
    }
  }

  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}
