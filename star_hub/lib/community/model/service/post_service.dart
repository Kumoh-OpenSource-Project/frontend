import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
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

final detailPostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return DetailPostService(repository);
});

class DetailPostService {
  final CommunityRepository repository;

  DetailPostService(this.repository);

  Future<ResponseEntity<DetailPostEntity>> getPosts(int postId) async {
    try {
      DetailPostEntity post = await repository.getDetailPost(postId);
      return ResponseEntity.success(entity: post);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      if (e.response?.statusCode == 404) {
        return ResponseEntity.error(message: "삭제된 게시물입니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다. $e");
    }
  }

  Future deletePosts(int? type, int postId) async {
    type == 1
        ? ScopePostService(repository)
            .deleteScopePost(DeleteArticleEntity(articleId: postId))
        : type == 2
            ? PlacePostService(repository)
                .deletePlacePost(DeleteArticleEntity(articleId: postId))
            : type == 3
                ? PhotoPostService(repository)
                    .deletePhotoPost(DeleteArticleEntity(articleId: postId))
                : print("type x");
  }

  Future deletePost(int postId) async {
    await repository.deletePost(DeleteArticleEntity(articleId: postId));
  }

  Future<ResponseEntity<DetailPostEntity>> updatePosts(
      int? type, int postId, String content) async {
    type == 1
        ? await ScopePostService(repository).updateScopePost(
            UpdateArticleEntity(content: content, articleId: postId))
        : type == 2
            ? await PlacePostService(repository).updatePlacePost(
                UpdateArticleEntity(content: content, articleId: postId))
            : type == 3
                ? await PhotoPostService(repository).updatePhotoPost(
                    UpdateArticleEntity(content: content, articleId: postId))
                : print("type x");
    return getPosts(postId);
  }

  Future<ResponseEntity<DetailPostEntity>> writeComment(
      int articleId, String content) async {
    await repository.writeComment(
        WriteCommentEntity(articleId: articleId, content: content));
    return getPosts(articleId);
  }

  Future<ResponseEntity<DetailPostEntity>> deleteComment(
      int articleId, int id) async {
    await repository.deleteComment(DeleteCommentEntity(id: id));
    return getPosts(articleId);
  }

  Future<ResponseEntity<DetailPostEntity>> addLike(int articleId) async {
    await repository.addLike(AddLikeEntity(articleId: articleId));
    return getPosts(articleId);
  }

  Future<ResponseEntity<DetailPostEntity>> cancelLike(int articleId) async {
    await repository.cancelLike(CancelLikeEntity(articleId: articleId));
    return getPosts(articleId);
  }

  Future<ResponseEntity<DetailPostEntity>> addClip(int articleId) async {
    await repository.addClip(AddClipEntity(articleId: articleId));
    return getPosts(articleId);
  }

  Future<ResponseEntity<DetailPostEntity>> cancelClip(int articleId) async {
    await repository.cancelClip(CancelClipEntity(articleId: articleId));
    return getPosts(articleId);
  }
}
