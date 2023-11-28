import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/model/state/auth_state.dart';
import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/auth/model/repository/auth_repository.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';

final authServiceProvider =
StateNotifierProvider<AuthService, AuthState>((ref) => AuthService());

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository repository = AuthRepository(dio);
  final LocalStorage localStorage = LocalStorage();

  AuthService() : super(AuthStateNone());

  Future login(String token) async {
    try {
      state = AuthStateLoading();
      LoginRequestDto authInfo = await repository.login('Bearer $token');
      localStorage.saveUserId(authInfo.id.toString());
      state = AuthStateSuccess(authInfo);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }
}
