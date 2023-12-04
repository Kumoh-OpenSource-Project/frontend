import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

final scopePostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return ScopePostService(repository);
});

class ScopePostService {
  final CommunityRepository repository;

  // 다음 페이지가 있는가.
  bool hasNextScope = true;

  List<ScopeFullPostEntity> scopeList = [];
  List<ScopeFullPostEntity> scopeEntity = [];

  ScopePostService(this.repository);

  bool isScopeReset = false;
  int scopePage = 0;

  // 전체 ScopePost 가져와서 변수에 저장한다.
  Future<ResponseEntity<List<ScopeFullPostEntity>>> getFullScopePosts(
      int offset, bool reset) async {
    try {
      scopeEntity.clear();
      if (offset == 0) {
        scopeList.clear();
        hasNextScope = true;
      }
      if (reset) {
        isScopeReset = true;
      } else {
        isScopeReset = false;
      }

      final List<ScopeFullPostEntity> fullPosts =
          await repository.getFullScopePost(offset);
      if (fullPosts.isEmpty) {
        hasNextScope = false;
      } else {
        hasNextScope = true;
        scopeEntity.addAll(fullPosts);
        scopeList.addAll(fullPosts);
      }
      scopePage = offset;
      return ResponseEntity.success(entity: fullPosts);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  // 페이지 초기화. (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> resetScopePage() async {
    print("초기화 좀...");
    return getFullScopePosts(0, true);
  }

  // vm에 NextPage 있는지 전달한다.(동기)
  bool returnScopePage() {
    return hasNextScope;
  }

  // vm에 ScopeEntity 전달한다.(동기)
  List<ScopeFullPostEntity> getScopeEntity() {
    return scopeEntity;
  }

  // DELETE scopePost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> deleteScopePost(
      DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    isScopeReset = true;
    return getFullScopePosts(0, true);
  }

  // PATCH scopePost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> updateScopePost(
      UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    isScopeReset = true;
    return getFullScopePosts(0, true);
  }

  // POST scopePost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<ScopeFullPostEntity>>> postScopePost(
      PostArticleEntity entity) async {
    await repository.postArticle(entity);
    isScopeReset = true;
    return getFullScopePosts(0, true);
  }
}
