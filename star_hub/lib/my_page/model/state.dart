import 'package:star_hub/my_page/model/entity/user_info_entity.dart';

abstract class NoneState {}

abstract class LoadingState {}

abstract class SuccessState<T> {
  T data;

  SuccessState(this.data);
}

abstract class ErrorState {
  String message;

  ErrorState(this.message);
}

abstract class MyPageState {}

class MyPageStateNone extends NoneState implements MyPageState {}

class MyPageStateStateLoading extends LoadingState implements MyPageState {}

class MyPageStateSuccess extends SuccessState<UserInfoEntity>
    implements MyPageState {
  MyPageStateSuccess(super.data);
}

class MyPageStateError extends ErrorState implements MyPageState {
  MyPageStateError(super.message);
}
