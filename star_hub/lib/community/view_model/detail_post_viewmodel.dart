import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/service/scope_service.dart';
import 'package:star_hub/community/model/service/photo_service.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/model/service/search_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:star_hub/my_page/model/service/my_post_service.dart';

final detailPostViewModelProvider =
    ChangeNotifierProvider((ref) => DetailPostViewModel(ref));

class DetailPostViewModel extends ChangeNotifier {
  Ref ref;
  late final DetailPostService detailPostService;
  late final ScopePostService scopePostService;
  late final SearchService searchService;
  late final PlacePostService placePostService;
  late final PhotoPostService photoPostService;
  late final MyPostService myPostService;

  bool get isLiked => ref.read(detailPostServiceProvider).isLike;

  DetailPostState state = DetailPostState();

  DetailPostViewModel(this.ref) {
    detailPostService = ref.read(detailPostServiceProvider);
    scopePostService = ref.read(scopePostServiceProvider);
    photoPostService = ref.read(photoPostServiceProvider);
    placePostService = ref.read(placePostServiceProvider);
    searchService = ref.read(searchPostServiceProvider);
    myPostService = ref.read(myPostPostServiceProvider);
  }

  void getInfo(int postId) =>
      state.withResponse(detailPostService.getPosts(postId));

  DetailPostEntity? getPost() {
    return ref.read(detailPostServiceProvider).entity;
  }

  void resetPost() {
    ref.read(detailPostServiceProvider).reset();
  }

  // 게시물 삭제
  void deletePost(
    int? type,
    int articleId, {
    String? word,
    SearchState? searchState,
    MyPostState? myPostState,
    MyPostLikeState? myPostLikeState,
    MyPostClipState? myPostClipState,
    ScopeCommunityState? scopeCommunityState,
    PlaceCommunityState? placeCommunityState,
    PhotoCommunityState? photoCommunityState,
  }) {
    if (type == 1) {
      scopeCommunityState!.withResponse(scopePostService
          .deleteScopePost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 2) {
      placeCommunityState!.withResponse(placePostService
          .deletePlacePost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 3) {
      photoCommunityState!.withResponse(photoPostService
          .deletePhotoPost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 4) {
      searchState!.withResponse(searchService.deleteSearchPost(
          DeleteArticleEntity(articleId: articleId), word!));
    } else if (type == 5) {
      myPostState!.withResponse(myPostService
          .deleteMyPost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 6) {
      myPostLikeState!.withResponse(myPostService
          .deleteLikePost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 7) {
      myPostClipState!.withResponse(myPostService
          .deleteClipPost(DeleteArticleEntity(articleId: articleId)));
    }
  }

  // 게시물 수정
  void updatePost(
    int? type,
    int articleId,
    String content, {
    String? word,
    SearchState? searchState,
    MyPostState? myPostState,
    MyPostLikeState? myPostLikeState,
    MyPostClipState? myPostClipState,
    ScopeCommunityState? scopeCommunityState,
    PlaceCommunityState? placeCommunityState,
    PhotoCommunityState? photoCommunityState,
  }) {
    if (type == 1) {
      scopeCommunityState!.withResponse(scopePostService.updateScopePost(
        UpdateArticleEntity(content: content, articleId: articleId),
      ));
    } else if (type == 2) {
      placeCommunityState!.withResponse(placePostService.updatePlacePost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 3) {
      photoCommunityState!.withResponse(photoPostService.updatePhotoPost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 4) {
      searchState!.withResponse(searchService.updateSearchPost(
          UpdateArticleEntity(content: content, articleId: articleId), word!));
    } else if (type == 5) {
      myPostState!.withResponse(myPostService.updateMyPost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 6) {
      myPostLikeState!.withResponse(myPostService.updateLikePost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 7) {
      myPostClipState!.withResponse(myPostService.updateClipPost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    }
  }

  // 댓글 작성
  void writeComment(int articleId, String content) {
    state.withResponse(detailPostService.writeComment(articleId, content));
  }

  // 댓글 삭제
  void deleteComment(int articleId, int commentId) {
    state.withResponse(detailPostService.deleteComment(articleId, commentId));
  }

  void addLike(int articleId) {
    state.withResponse(detailPostService.addLike(articleId));
  }

  void cancelLike(int articleId) {
    state.withResponse(detailPostService.cancelLike(articleId));
  }

  void addClip(int articleId) {
    state.withResponse(detailPostService.addClip(articleId));
  }

  void cancelClip(int articleId) {
    state.withResponse(detailPostService.cancelClip(articleId));
  }
}
