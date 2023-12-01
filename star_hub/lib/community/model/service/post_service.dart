import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/add_clip_entity.dart';
import 'package:star_hub/community/model/entity/cancel_clip_entity.dart';
import 'package:star_hub/community/model/entity/cancel_like_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/delete_comment_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/add_like_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/entity/write_comment_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/service/photo_service.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/model/service/scope_service.dart';
import 'package:star_hub/community/model/state/state.dart';

final detailPostServiceProvider =
    StateNotifierProvider<DetailPostService, CommunityState>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return DetailPostService(repository);
});

class DetailPostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  DetailPostService(this.repository) : super(DetailPostStateNone());

  Future<DetailPostEntity> getPosts(int postId) async {
    state = DetailPostStateLoading();
    DetailPostEntity post = await repository.getDetailPost(postId);
    state = DetailPostStateSuccess(post);
    return post;
  }

  Future deletePosts(int type, int postId) async {
    type == 1
        ? ScopePostService(repository)
            .deleteScopePost(DeleteArticleEntity(articleId: postId))
        : type == 2
            ? PlacePostService(repository)
                .deletePlacePost(DeleteArticleEntity(articleId: postId))
            : PhotoPostService(repository)
                .deletePhotoPost(DeleteArticleEntity(articleId: postId));
  }

  Future updatePosts(int type, int postId, String content) async {
    type == 1
        ? ScopePostService(repository).updateScopePost(
            UpdateArticleEntity(content: content, articleId: postId))
        : type == 2
            ? PlacePostService(repository).updatePlacePost(
                UpdateArticleEntity(content: content, articleId: postId))
            : PhotoPostService(repository).updatePhotoPost(
                UpdateArticleEntity(content: content, articleId: postId));
  }



  Future writeComment(int articleId, String content) async {
    await repository.writeComment(
        WriteCommentEntity(articleId: articleId, content: content));
    getPosts(articleId);
  }

  Future deleteComment(int articleId, int id) async {
    await repository.deleteComment(DeleteCommentEntity(id: id));
    getPosts(articleId);
  }

  Future addLike(int articleId) async {
    await repository.addLike(AddLikeEntity(articleId: articleId));
    getPosts(articleId);
  }
  Future cancelLike(int articleId) async {
    await repository.cancelLike(CancelLikeEntity(articleId: articleId));
    getPosts(articleId);
  }
  Future addClip(int articleId) async {
    await repository.addClip(AddClipEntity(articleId: articleId));
    getPosts(articleId);
  }
  Future cancelClip(int articleId) async {
    await repository.cancelClip(CancelClipEntity(articleId: articleId));
    getPosts(articleId);
  }
}
