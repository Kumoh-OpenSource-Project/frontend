import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
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

  ScopePostService(this.repository) : super(ScopeCommunityStateNone()) {
    getFullScopePosts(0);
  }

  Future getFullScopePosts(int offset) async {
    try {
      print("2222222222222222222222222222222222222222222");
      state = ScopeCommunityStateLoading();
      List<FullPostEntity> fullPosts = await repository.getFullScopePost(offset);
      state = ScopeCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = ScopeCommunityStateError(e.toString());
    }
  }

  Future deleteScopePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    getFullScopePosts(0);
  }

  Future updateScopePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    getFullScopePosts(0);
  }

  Future postScopePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    getFullScopePosts(0);
  }

}
