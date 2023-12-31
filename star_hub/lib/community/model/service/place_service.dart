import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/level_up_entity.dart';
import 'package:star_hub/community/model/entity/place_best_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

final placePostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return PlacePostService(repository);
});

class PlacePostService {
  final CommunityRepository repository;
  bool hasNextPlace = true;
  List<PlaceFullPostEntity> placeList = [];
  PlacePostService(this.repository);
  bool isPlaceReset = false;
  int placePage = 0;
  late PlaceBestEntity placeBestEntity;
  String level = "수성";
  bool isLevelUp = false;
  LevelUpEntity? levelUpEntity = null;

  // 전체 PlacePost 가져와서 변수에 저장한다.
  Future<ResponseEntity<List<PlaceFullPostEntity>>> getFullPlacePosts(
      int offset) async {
    try {
      if (offset == 0) {
        placeList.clear();
        hasNextPlace = true;
      }
      final List<PlaceFullPostEntity> fullPosts =
          await repository.getFullPlacePost(offset);
      if (fullPosts.isEmpty) {
        hasNextPlace = false;
      } else {
        hasNextPlace = true;
        placeList.addAll(fullPosts);
      }
      placePage = offset;
      if (offset == 0) {
        isPlaceReset = true;
      } else {
        isPlaceReset = false;
      }
      return ResponseEntity.success(entity: placeList);
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
  bool returnPlacePage() {
    return hasNextPlace;
  }

  // DELETE placePost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PlaceFullPostEntity>>> deletePlacePost(
      DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    return getFullPlacePosts(0);
  }

  // PATCH placePost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PlaceFullPostEntity>>> updatePlacePost(
      UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    return getFullPlacePosts(0);
  }

  // POST placePost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<PlaceFullPostEntity>>> postPlacePost(
      PostArticleEntity entity) async {
    levelUpEntity = await repository.postArticle(entity);
    print("place $levelUpEntity levelUpEntity");

    level = levelUpEntity!.level;
    isLevelUp = levelUpEntity!.isLevelUp;
    return getFullPlacePosts(0);
  }

  void makePlaceNonReset() {
    isPlaceReset = false;
  }

  void notLevelUp() {
    levelUpEntity!.isLevelUp = false;

  }

  Future<ResponseEntity<PlaceBestEntity>> getPlaceBestPost() async {
    try {
      final PlaceBestEntity bestPost = await repository.getPlaceBestPost();
      placeBestEntity = bestPost;
      return ResponseEntity.success(entity: bestPost);
    } on DioException catch (e) {
      return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}
