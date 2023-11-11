import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final photoPostServiceProvider = StateNotifierProvider<PhotoPostService, CommunityState>(
        (ref) => PhotoPostService(CommunityRepository()));

class PhotoPostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  PhotoPostService(this.repository) : super(PhotoCommunityStateNone()) {
    getFullPhotoPosts();
  }

  Future getFullPhotoPosts() async {
    try {
      state = PhotoCommunityStateLoading();
      List<PhotoPostEntity> fullPosts = await repository.getFullPhotoPost();
      state = PhotoCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = PhotoCommunityStateError(e.toString());
    }
  }
}
