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
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';

final detailPostViewModelProvider =
    ChangeNotifierProvider((ref) => DetailPostViewModel(ref));

class DetailPostViewModel extends ChangeNotifier {
  Ref ref;
  late final DetailPostService detailPostService;
  late final ScopePostService scopePostService;

  late final PlacePostService placePostService;
  late final PhotoPostService photoPostService;

  ScopeCommunityState scopeState = ScopeCommunityState();
  DetailPostState state = DetailPostState();
  PlaceCommunityState placeState = PlaceCommunityState();
  PhotoCommunityState photoState = PhotoCommunityState();

  DetailPostViewModel(this.ref) {
    detailPostService = ref.read(detailPostServiceProvider);
    scopePostService = ref.read(scopePostServiceProvider);
    photoPostService = ref.read(photoPostServiceProvider);
    placePostService = ref.read(placePostServiceProvider);
  }

  void getInfo(int postId) =>
      state.withResponse(detailPostService.getPosts(postId));

  // 게시물 삭제
  void deletePost(int? type, int articleId) {
    if (type == 1) {
      scopeState.withResponse(scopePostService
          .deleteScopePost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 2) {
      placeState.withResponse(placePostService
          .deletePlacePost(DeleteArticleEntity(articleId: articleId)));
    } else if (type == 3) {
      photoState.withResponse(photoPostService
          .deletePhotoPost(DeleteArticleEntity(articleId: articleId)));
    } else {
      print("리셋 필요 x");
    }
  }

  // 게시물 수정
  void updatePost(int? type, int articleId, String content) {
    if (type == 1) {
      scopeState.withResponse(scopePostService.updateScopePost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 2) {
      placeState.withResponse(placePostService.updatePlacePost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else if (type == 3) {
      photoState.withResponse(photoPostService.updatePhotoPost(
          UpdateArticleEntity(content: content, articleId: articleId)));
    } else {
      print('리셋 필요 x');
    }
  }

  // 댓글 작성
  void writeComment(int articleId, String content) {
    state.withResponse(detailPostService.writeComment(articleId, content));
  }

  // 댓글 삭제
  void deleteComment(int type, int articleId, int commentId) {
    state.withResponse(detailPostService.deleteComment(articleId, commentId));
  }

  void addLike(int articleId) {
    state.withResponse(detailPostService.addLike(articleId));
  }

  void cancelLike(int articleId) {
    state.withResponse(detailPostService.addLike(articleId));
  }

  void addClip(int articleId) {
    state.withResponse(detailPostService.addClip(articleId));
  }

  void cancelClip(int articleId) {
    state.withResponse(detailPostService.cancelClip(articleId));
  }
}
