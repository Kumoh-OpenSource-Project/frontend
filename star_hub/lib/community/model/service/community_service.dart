import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final scopePostServiceProvider = StateNotifierProvider<ScopePostService, CommunityState>(
    (ref) => ScopePostService(CommunityRepository()));

class ScopePostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  ScopePostService(this.repository) : super(ScopeCommunityStateNone()) {
    getFullScopePosts();
  }

  Future getFullScopePosts() async {
    try {
      state = ScopeCommunityStateLoading();
      List<ScopePostEntity> fullPosts = await repository.getFullScopePost();
      state = ScopeCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = ScopeCommunityStateError(e.toString());
    }
  }
}
