import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/model/state/auth_state.dart';
import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/auth/model/repository/auth_repository.dart';
import 'package:star_hub/common/const.dart';

final authServiceProvider =
StateNotifierProvider<AuthService, AuthState>((ref) => AuthService());

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository repository = AuthRepository(dio);


  AuthService() : super(AuthStateNone());

  Future login(String token) async {
    try {
      LoginRequestDto authInfo = await repository.login('Bearer $token');
      state = AuthStateSuccess(authInfo);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }
}
