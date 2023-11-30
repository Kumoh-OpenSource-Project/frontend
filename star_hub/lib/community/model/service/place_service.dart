import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
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

  // offset 변수랑 값을 맞춰야 함.
  int placePage = 0;

  // 다음 페이지가 있는가.
  bool hasNextPlace = true;

  List<PlaceFullPostEntity> placeList = [];
  List<PlaceFullPostEntity> placeEntity = [];

  PlacePostService(this.repository) : super(PlaceCommunityStateLoading()) {
    getFullPlacePosts(0);
  }

  // 전체 PlacePost 가져와서 변수에 저장한다.
  Future getFullPlacePosts(int offset) async {
    try {
      placeEntity.clear();
      state = PlaceCommunityStateLoading();
      if (offset == 0) {
        placeList.clear();
        hasNextPlace = true;
        placePage = 0;
      }
      final List<PlaceFullPostEntity> fullPosts =
          await repository.getFullPlacePost(offset);
      if (fullPosts.isEmpty) {
        hasNextPlace = false;
      } else {
        hasNextPlace = true;
        placeList.addAll(fullPosts);
        placePage++;
      }
      state = PlaceCommunityStateSuccess(fullPosts);
      placeEntity.addAll(fullPosts);
    } catch (e) {
      _handleError(e);
    }
  }

  // 페이지 초기화. (비동기)
  Future<void> resetPlacePage() async {
    await getFullPlacePosts(0);
  }

  // vm에 NextPage 있는지 전달한다.(동기)
  bool returnPlacePage() {
    return hasNextPlace;
  }

  // vm에 PlaceEntity 전달한다.(동기)
  List<PlaceFullPostEntity> getPlaceEntity() {
    return placeEntity;
  }

  // DELETE placePost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<void> deletePlacePost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    await getFullPlacePosts(0);
  }

  // PATCH placePost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<void> updatePlacePost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await getFullPlacePosts(0);
  }

  // POST placePost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<void> postPlacePost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    await getFullPlacePosts(0);
  }

  Future<void> _handleError(dynamic error) async {
    //todo : print 나중에 지워주세요!
    print('Error in PlacePostService: $error');
    state = PlaceCommunityStateError(error.toString());
  }
}
