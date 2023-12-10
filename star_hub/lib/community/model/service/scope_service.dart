import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/level_up_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

import '../entity/scope_best_entity.dart';

final scopePostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return ScopePostService(repository);
});


class ScopePostService {
  final CommunityRepository repository;
  bool hasNextScope = true;
  List<ScopeFullPostEntity> scopeList = [];
  ScopePostService(this.repository);
  bool isScopeReset = false;
  int scopePage = 0;
  late ScopeBestEntity scopeBestEntity;

  String level = "수성";
  bool isLevelUp = false;
  LevelUpEntity? levelUpEntity = null;

  // 전체 ScopePost 가져와서 변수에 저장한다.
  Future<ResponseEntity<List<ScopeFullPostEntity>>> getFullScopePosts(
      int offset) async {
    try {
      if (offset == 0) {
        scopeList.clear();
        hasNextScope = true;
      }
      final List<ScopeFullPostEntity> fullPosts =
          await repository.getFullScopePost(offset);
      if (fullPosts.isEmpty) {
        hasNextScope = false;
      } else {
        hasNextScope = true;
        scopeList.addAll(fullPosts);
      }
      scopePage = offset;
      if (offset == 0) {
        isScopeReset = true;
      } else {
        isScopeReset = false;
      }
      return ResponseEntity.success(entity: scopeList);
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
  bool returnScopePage() {
    return hasNextScope;
  }

  // DELETE scopePost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> deleteScopePost(
      DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    return getFullScopePosts(0);
  }

  // PATCH scopePost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> updateScopePost(
      UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    return getFullScopePosts(0);
  }

  // POST scopePost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> postScopePost(
      PostArticleEntity entity) async {
    levelUpEntity = await repository.postArticle(entity);
        print("scope $levelUpEntity levelUpEntity");
    print("scope ${levelUpEntity!.level} levelUpEntity");
    level = levelUpEntity!.level;
    isLevelUp = levelUpEntity!.isLevelUp;
    return getFullScopePosts(0);
  }

  void makeScopeNonReset() {
    isScopeReset = false;
  }

  void notLevelUp() {
    isLevelUp = false;
  }

  Future<ResponseEntity<ScopeBestEntity>> getScopeBestPost() async {
    try {
      final ScopeBestEntity bestPost = await repository.getScopeBestPost();
      scopeBestEntity = bestPost;
      return ResponseEntity.success(entity: bestPost);
    } on DioException catch (e) {
      return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}
