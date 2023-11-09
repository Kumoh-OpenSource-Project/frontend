import 'package:star_hub/community/FullPostEntity.dart';
import 'package:star_hub/community/view/screens/full_post_screen.dart';

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


abstract class CommunityState {}

class CommunityStateNone extends NoneState implements CommunityState {}

class CommunityStateLoading extends LoadingState implements CommunityState {}

class CommunityStateSuccess extends SuccessState<List<PostEntity>> implements CommunityState {
  CommunityStateSuccess(super.data);
}

class CommunityStateError extends ErrorState implements CommunityState {
  CommunityStateError(super.message);
}