import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';
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

class ScopeCommunityStateNone extends NoneState implements CommunityState {}

class ScopeCommunityStateLoading extends LoadingState implements CommunityState {}

class ScopeCommunityStateSuccess extends SuccessState<List<FullPostEntity>> implements CommunityState {
  ScopeCommunityStateSuccess(super.data);
}

class ScopeCommunityStateError extends ErrorState implements CommunityState {
  ScopeCommunityStateError(super.message);
}

////
class PhotoCommunityStateNone extends NoneState implements CommunityState {}

class PhotoCommunityStateLoading extends LoadingState implements CommunityState {}

class PhotoCommunityStateSuccess extends SuccessState<List<FullPostEntity>> implements CommunityState {
  PhotoCommunityStateSuccess(super.data);
}

class PhotoCommunityStateError extends ErrorState implements CommunityState {
  PhotoCommunityStateError(super.message);
}

////x
class PlaceCommunityStateNone extends NoneState implements CommunityState {}

class PlaceCommunityStateLoading extends LoadingState implements CommunityState {}

class PlaceCommunityStateSuccess extends SuccessState<List<FullPostEntity>> implements CommunityState {
  PlaceCommunityStateSuccess(super.data);
}

class PlaceCommunityStateError extends ErrorState implements CommunityState {
  PlaceCommunityStateError(super.message);
}

class DetailPostStateNone extends NoneState implements CommunityState {}

class DetailPostStateLoading extends LoadingState implements CommunityState {}

class DetailPostStateSuccess extends SuccessState<DetailPostEntity> implements CommunityState {
  DetailPostStateSuccess(super.data);
}
class DetailPostStateError extends ErrorState implements CommunityState {
  DetailPostStateError(super.message);
}