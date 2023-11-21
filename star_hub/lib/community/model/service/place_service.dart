import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final placePostServiceProvider = StateNotifierProvider<PlacePostService, CommunityState>(
        (ref) => PlacePostService(CommunityRepository()));

class PlacePostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  PlacePostService(this.repository) : super(PlaceCommunityStateNone()) {
    getFullPlacePosts();
  }

  Future getFullPlacePosts() async {
    try {
      state = PlaceCommunityStateLoading();
      List<PlaceFullPostEntity> fullPosts = await repository.getFullPlacePost();
      state = PlaceCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = PlaceCommunityStateError(e.toString());
    }
  }
}
