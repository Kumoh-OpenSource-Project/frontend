import 'home_entity.dart';

abstract class NoneState {}

abstract class LoadingState {}

abstract class SuccessState<T, D, Y, E> {
  T data;
  D data1;
  Y data2;
  E eventData;

  SuccessState(this.data, this.data1, this.data2, this.eventData);
}

abstract class ErrorState {
  String message;

  ErrorState(this.message);
}

abstract class HomeState {}

class HomeStateNone extends NoneState implements HomeState {}

class HomeStateLoading extends LoadingState implements HomeState {}

class HomeStateSuccess extends SuccessState<TodayWeatherData,
    RealTimeWeatherInfo, List<WeatherData>, EventData> implements HomeState {
  HomeStateSuccess(TodayWeatherData data, RealTimeWeatherInfo data1,
      List<WeatherData> data2, EventData eventData)
      : super(data, data1, data2, eventData);
}

class HomeStateError extends ErrorState implements HomeState {
  HomeStateError(String message) : super(message);
}
