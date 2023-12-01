import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final scopePostServiceProvider =
    StateNotifierProvider<ScopePostService, CommunityState>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return ScopePostService(repository);
});

class ScopePostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  // offset 변수랑 값을 맞춰야 함.
  int scopePage = 0;

  // 다음 페이지가 있는가.
  bool hasNextScope = false;


  List<ScopeFullPostEntity> scopeList = [];
  List<ScopeFullPostEntity> scopeEntity = [];

  ScopePostService(this.repository) : super(ScopeCommunityStateLoading()) {
    getFullScopePosts(0);
  }

  // 전체 ScopePost 가져와서 변수에 저장한다.
  Future getFullScopePosts(int offset) async {
    try {
      scopeEntity.clear();
      state = ScopeCommunityStateLoading();
      if (offset == 0) {
        scopeList.clear();
        hasNextScope = true;
        scopePage = 0;
      }
      final List<ScopeFullPostEntity> fullPosts =
          await repository.getFullScopePost(offset);
      if (fullPosts.isEmpty) {
        hasNextScope = false;
      } else {
        hasNextScope = true;
        scopeList.addAll(fullPosts);
        scopePage++;
      }
      state = ScopeCommunityStateSuccess(fullPosts);
      scopeEntity.addAll(fullPosts);
    } catch (e) {
      _handleError(e);
    }
  }

  // 페이지 초기화. (비동기)
  Future<void> resetScopePage() async {
    await getFullScopePosts(0);
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
  Future<void> deleteScopePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    await getFullScopePosts(0);
  }

  // PATCH scopePost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<void> updateScopePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await getFullScopePosts(0);
  }

  // POST scopePost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<void> postScopePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    await getFullScopePosts(0);
  }

  Future<void> _handleError(dynamic error) async {
    //todo : print 나중에 지워주세요!
    print('Error in ScopePostService: $error');
    state = ScopeCommunityStateError(error.toString());
  }
}
