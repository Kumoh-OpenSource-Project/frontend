import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/FullPostEntity.dart';
import 'package:star_hub/community/model/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final postServiceProvider = StateNotifierProvider<PostService, CommunityState>(
    (ref) => PostService(CommunityRepository()));

class PostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  PostService(this.repository) : super(CommunityStateNone()) {
    getFullPosts(1);
  }

  Future getFullPosts(int type) async {
    try {
      state = CommunityStateLoading();
      List<PostEntity> fullPosts = await repository.getFullPost(type);
      state = CommunityStateSuccess(fullPosts);
    } catch (e) {
      state = CommunityStateError(e.toString());
    }
  }
}
