import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

final photoPostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return PhotoPostService(repository);
});

class PhotoPostService {
  final CommunityRepository repository;
  bool hasNextPhoto = true;
  List<PhotoFullPostEntity> photoList = [];

  PhotoPostService(this.repository);

  bool isPhotoReset = false;
  int photoPage = 0;

  Future<ResponseEntity<List<PhotoFullPostEntity>>> getFullPhotoPosts(
      int offset) async {
    try {
      if (offset == 0) {
        photoList.clear();
        hasNextPhoto = true;
      }
      final List<PhotoFullPostEntity> fullPosts =
          await repository.getFullPhotoPost(offset);
      if (fullPosts.isEmpty) {
        hasNextPhoto = false;
      } else {
        hasNextPhoto = true;
        photoList.addAll(fullPosts);
      }
      photoPage = offset;
      if (offset == 0) {
        isPhotoReset = true;
      } else {
        isPhotoReset = false;
      }
      return ResponseEntity.success(entity: photoList);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      if (e.response?.statusCode == 404) {
        return ResponseEntity.error(message: "404");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  // vm에 NextPage 있는지 전달한다.(동기)
  bool returnPhotoPage() {
    return hasNextPhoto;
  }

  // DELETE photoPost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PhotoFullPostEntity>>> deletePhotoPost(
      DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    return getFullPhotoPosts(0);
  }

  // PATCH photoPost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PhotoFullPostEntity>>> updatePhotoPost(
      UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    return getFullPhotoPosts(0);
  }

  // POST photoPost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PhotoFullPostEntity>>> postPhotoPost(
      PostArticleEntity entity) async {
    await repository.postArticle(entity);
    return getFullPhotoPosts(0);
  }

  void makePhotoNonReset() {
    isPhotoReset = false;
  }
}
