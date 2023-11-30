import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
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

  // offset 변수랑 값을 맞춰야 함.
  int photoPage = 0;

  // 다음 페이지가 있는가.
  bool hasNextPhoto = true;


  List<PhotoFullPostEntity> photoList = [];
  List<PhotoFullPostEntity> photoEntity = [];
  
  PhotoPostService(this.repository) : super(PhotoCommunityStateNone()) {
    getFullPhotoPosts(0);
  }

  Future getFullPhotoPosts(int offset) async {
    try {
      photoEntity.clear();
      state = PhotoCommunityStateLoading();
      if (offset == 0) {
        photoList.clear();
        hasNextPhoto = true;
        photoPage = 0;
      }
      final List<PhotoFullPostEntity> fullPosts =
      await repository.getFullPhotoPost(offset);
      if (fullPosts.isEmpty) {
        hasNextPhoto = false;
      } else {
        hasNextPhoto = true;
        photoList.addAll(fullPosts);
        photoPage++;
      }
      state = PhotoCommunityStateSuccess(fullPosts);
      photoEntity.addAll(fullPosts);
    } catch (e) {
      _handleError(e);
    }
  }
  
  // 페이지 초기화. (비동기)
  Future<void> resetPhotoPage() async {
    await getFullPhotoPosts(0);
  }

  // vm에 NextPage 있는지 전달한다.(동기)
  bool returnPhotoPage() {
    return hasNextPhoto;
  }

  // vm에 PhotoEntity 전달한다.(동기)
  List<PhotoFullPostEntity> getPhotoEntity() {
    return photoEntity;
  }

  // DELETE photoPost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<void> deletePhotoPost(DeleteArticleEntity entity) async {
    await repository.deletePost(entity);
    await getFullPhotoPosts(0);
  }

  // PATCH photoPost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<void> updatePhotoPost(UpdateArticleEntity entity) async {
    await repository.updateArticle(entity);
    await getFullPhotoPosts(0);
  }

  // POST photoPost : 글을 올린다. 페이지 초기화 진행 (비동기)
  Future<void> postPhotoPost(PostArticleEntity entity) async {
    await repository.postArticle(entity);
    await getFullPhotoPosts(0);
  }

  Future<void> _handleError(dynamic error) async {
    //todo : print 나중에 지워주세요!
    print('Error in PhotoPostService: $error');
    state = PhotoCommunityStateError(error.toString());
  }
}
