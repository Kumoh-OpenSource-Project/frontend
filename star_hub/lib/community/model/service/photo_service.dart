import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final photoPostServiceProvider =
    StateNotifierProvider<PhotoPostService, CommunityState>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return PhotoPostService(repository);
});

class PhotoPostService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  PhotoPostService(this.repository) : super(PhotoCommunityStateNone()) {
    getFullPhotoPosts(0);
  }

  Future getFullPhotoPosts(int offset) async {
    try {
      state = PhotoCommunityStateLoading();
      List<PhotoFullPostEntity> fullPosts = await repository.getFullPhotoPost(offset);
      state = PhotoCommunityStateSuccess(fullPosts);
    } catch (e) {
      state = PhotoCommunityStateError(e.toString());
    }
  }

  Future deletePhotoPost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
   await getFullPhotoPosts(0);
  }

  Future updatePhotoPost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await getFullPhotoPosts(0);
  }

  Future postPhotoPost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    getFullPhotoPosts(0);
  }
}
