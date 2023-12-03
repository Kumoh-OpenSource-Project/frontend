// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:star_hub/auth/model/service/auth_service.dart';
// import 'package:star_hub/auth/model/state/auth_state.dart';
// import 'package:star_hub/auth/model/dto/login_request_dto.dart';
//
// final authViewModelProvider =
// ChangeNotifierProvider((ref) => AuthViewModel(ref));
//
// class AuthViewModel extends ChangeNotifier {
//   Ref ref;
//
//   late AuthState state;
//
//   LoginRequestDto get entity =>
//       (state as AuthStateSuccess).data;
//
//   AuthViewModel(this.ref) {
//     state = ref.read(authServiceProvider);
//     ref.listen(authServiceProvider, (previous, next) {
//       if (previous != next) {
//         state = next;
//         notifyListeners();
//       }
//     });
//   }
//
//   void login(String token){
//     ref.read(authServiceProvider.notifier).login(token);
//   }
// }
//
