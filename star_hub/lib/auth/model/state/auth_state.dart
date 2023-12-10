import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/community/model/state/state.dart';

abstract class AuthState {}

class AuthStateNone extends NoneState implements AuthState {}
class AuthStateLoading extends LoadingState implements AuthState {}
class AuthStateSuccess extends SuccessState<LoginRequestDto> implements AuthState {
  AuthStateSuccess(super.data);
}
class AuthStateError extends ErrorState implements AuthState {
  AuthStateError(super.message);
}
