import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
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

  ScopePostService(this.repository) : super(ScopeCommunityStateLoading()) {
    _getFullScopePosts(0);
  }

  Future<void> _getFullScopePosts(int offset) async {
    try {
      final List<ScopeFullPostEntity> fullPosts = await repository.getFullScopePost(offset);
      state = ScopeCommunityStateSuccess(fullPosts);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _handleError(dynamic error) async {
    // 여기서 더 나은 오류 처리 또는 로깅을 수행할 수 있습니다.
    print('Error in ScopePostService: $error');
    state = ScopeCommunityStateError(error.toString());
  }

  Future<void> deleteScopePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    await _getFullScopePosts(0);
  }

  Future<void> updateScopePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await _getFullScopePosts(0);
  }

  Future<void> postScopePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    await _getFullScopePosts(0);
  }
}

