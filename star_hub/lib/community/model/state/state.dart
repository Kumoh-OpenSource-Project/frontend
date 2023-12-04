import 'package:star_hub/common/value_state.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/my_page/model/entity/my_likes_entity.dart';


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

class ScopeCommunityStateSuccess extends SuccessState<List<ScopeFullPostEntity>> implements CommunityState {
  ScopeCommunityStateSuccess(super.data);
}

class ScopeCommunityStateError extends ErrorState implements CommunityState {
  ScopeCommunityStateError(super.message);
}

////
class PhotoCommunityStateNone extends NoneState implements CommunityState {}

class PhotoCommunityStateLoading extends LoadingState implements CommunityState {}

class PhotoCommunityStateSuccess extends SuccessState<List<PhotoFullPostEntity>> implements CommunityState {
  PhotoCommunityStateSuccess(super.data);
}

class PhotoCommunityStateError extends ErrorState implements CommunityState {
  PhotoCommunityStateError(super.message);
}

////x
class PlaceCommunityStateNone extends NoneState implements CommunityState {}

class PlaceCommunityStateLoading extends LoadingState implements CommunityState {}

class PlaceCommunityStateSuccess extends SuccessState<List<PlaceFullPostEntity>> implements CommunityState {
  PlaceCommunityStateSuccess(super.data);
}

class PlaceCommunityStateError extends ErrorState implements CommunityState {
  PlaceCommunityStateError(super.message);
}

class DetailPostState extends ValueStateNotifier<DetailPostEntity> {}

class ScopeCommunityState extends ValueStateNotifier<List<ScopeFullPostEntity>> {}

class PlaceCommunityState extends ValueStateNotifier<List<PlaceFullPostEntity>> {}

class PhotoCommunityState extends ValueStateNotifier<List<PhotoFullPostEntity>> {}

class SearchState extends ValueStateNotifier<List<SearchPostEntity>> {}

class MyPostLikeState extends ValueStateNotifier<List<MyLikesEntity>> {}

class SearchStateNone extends NoneState implements CommunityState {}

class SearchStateLoading extends LoadingState implements CommunityState {}

class SearchStateSuccess extends SuccessState<List<SearchPostEntity>> implements CommunityState {
  SearchStateSuccess(super.data);
}
class SearchStateError extends ErrorState implements CommunityState {
  SearchStateError(super.message);
}