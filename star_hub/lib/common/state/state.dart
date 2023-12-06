import 'package:star_hub/home/model/home_entity.dart';

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

abstract class MainState {}

class MainStateNone extends NoneState implements MainState {}

class MainStateLoading extends LoadingState implements MainState {}

class MainStateSuccess extends SuccessState<List<LunarData>>
    implements MainState {
  MainStateSuccess(List<LunarData> data) : super(data);
}

class MainStateError extends ErrorState implements MainState {
  MainStateError(String message) : super(message);
}
