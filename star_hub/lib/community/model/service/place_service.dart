import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final placePostServiceProvider =
    StateNotifierProvider<PlacePostService, CommunityState>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return PlacePostService(repository);
});

class PlacePostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  PlacePostService(this.repository) : super(PlaceCommunityStateNone()) {
    getFullPlacePosts(0);
  }

  Future getFullPlacePosts(int offset) async {
    try {
      state = PlaceCommunityStateLoading();
      List<FullPostEntity> fullPosts = await repository.getFullPlacePost(offset);
      state = PlaceCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = PlaceCommunityStateError(e.toString());
    }
  }

  // 포스트 삭제
  Future deletePlacePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    getFullPlacePosts(0);
  }

  Future updatePlacePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    getFullPlacePosts(0);
  }

  Future postPlacePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    getFullPlacePosts(0);
  }
}
