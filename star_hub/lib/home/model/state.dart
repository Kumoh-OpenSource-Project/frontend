import 'home_entity.dart';

abstract class NoneState {}

abstract class LoadingState {}

abstract class SuccessState<T, D, Y> {
  T data;
  D data1;
  Y data2;

  SuccessState(this.data, this.data1, this.data2);
}

abstract class ErrorState {
  String message;

  ErrorState(this.message);
}

abstract class HomeState {}

class HomeStateNone extends NoneState implements HomeState {}

class HomeStateLoading extends LoadingState implements HomeState {}

class HomeStateSuccess extends SuccessState<TodayWeatherData,
    RealTimeWeatherInfo, List<WeatherData>> implements HomeState {
  HomeStateSuccess(
      TodayWeatherData data, RealTimeWeatherInfo data1, List<WeatherData> data2)
      : super(data, data1, data2);
}

class HomeStateError extends ErrorState implements HomeState {
  HomeStateError(String message) : super(message);
}
