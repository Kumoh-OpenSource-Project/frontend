import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/auth/model/repository/auth_repository.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';

class AuthService {
  final AuthRepository repository = AuthRepository(dio);
  final LocalStorage localStorage = LocalStorage();
  final String token;

  AuthService(this.token) {
    login(token);
  }

  Future login(String token) async {
    LoginRequestDto authInfo = await repository.login('Bearer $token');
    localStorage.saveUserId(authInfo.id.toString());
    await localStorage.getUserId();
  }
}
