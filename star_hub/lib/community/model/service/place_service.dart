import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
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

  PlacePostService(this.repository) : super(PlaceCommunityStateLoading()) {
    getFullPlacePosts(0);
  }

  // Future getFullPlacePosts(int offset) async {
  //   try {
  //     state = PlaceCommunityStateLoading();
  //     List<PlaceFullPostEntity> fullPosts = await repository.getFullPlacePost(offset);
  //     state = PlaceCommunityStateSuccess(fullPosts);
  //   } catch (e) {
  //     state = PlaceCommunityStateError(e.toString());
  //   }
  // }

  Future<List<PlaceFullPostEntity>> getFullPlacePosts(int offset) async {
    try {
      final List<PlaceFullPostEntity> fullPosts = await repository.getFullPlacePost(offset);
      state = PlaceCommunityStateSuccess(fullPosts);
      return fullPosts;
    } catch (e) {
      _handleError(e);
    }
    return [];
  }
  Future<void> _handleError(dynamic error) async {
    // 여기서 더 나은 오류 처리 또는 로깅을 수행할 수 있습니다.
    print('Error in ScopePostService: $error');
    state = PlaceCommunityStateError(error.toString());
  }

  Future<void> deletePlacePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    await getFullPlacePosts(0);
  }

  Future<void> updatePlacePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await getFullPlacePosts(0);
  }

  Future<void> postPlacePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    await getFullPlacePosts(0);
  }


  // 포스트 삭제
  // Future deletePlacePost(DeleteArticleEntity entity) async {
  //   await repository.deletePost(entity);
  //   await getFullPlacePosts(0);
  // }
  //
  // Future updatePlacePost(UpdateArticleEntity entity) async {
  //   await repository.updateArticle(entity);
  //   await getFullPlacePosts(0);
  // }
  //
  // Future postPlacePost(PostArticleEntity entity) async {
  //   await repository.postArticle(entity);
  //   await getFullPlacePosts(0);
  // }
  //
  // Future refreshPosts() async {
  //   await getFullPlacePosts(0);
  // }
}
