// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'package:star_hub/auth/view/screens/social_login.dart';
// import 'package:star_hub/common/const.dart';
//
// class MainViewModel  {
//   final SocialLogin _socialLogin;
//   bool isLogined = false;
//
//   User? user;
//
//   MainViewModel(this._socialLogin);
//
//   Future login() async {
//     isLogined = await _socialLogin.login();
//     if(isLogined){
//       user = await UserApi.instance.me();
//     }
//   }
//
//   Future logout() async{
//     await _socialLogin.logout();
//     isLogined = false;
//     user = null;
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/model/auth_service.dart';
import 'package:star_hub/auth/model/auth_state.dart';
import 'package:star_hub/auth/model/login_request_dto.dart';

final authViewModelProvider =
ChangeNotifierProvider((ref) => AuthViewModel(ref));

class AuthViewModel extends ChangeNotifier {
  Ref ref;

  late AuthState state;

  LoginRequestDto get entity =>
      (state as AuthStateSuccess).data;

  AuthViewModel(this.ref) {
    state = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}