import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_hub/common/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:star_hub/my_page/model/entity/my_clip_entity.dart';
import 'package:star_hub/my_page/model/entity/my_likes_entity.dart';
import 'package:star_hub/my_page/model/entity/my_post_entity.dart';
import 'package:star_hub/my_page/model/entity/user_info_entity.dart';

part 'my_page_repository.g.dart';

final myPageRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MyPageRepository(dio);
  //return CommunityRepositoryStub();
});

@RestApi()
abstract class MyPageRepository {
  factory MyPageRepository(Dio dio,
      {String? baseUrl}) = _MyPageRepository;

  @GET('user')
  @Headers({'accessToken': 'true'})
  Future<UserInfoEntity> getUserInfo();

  @GET('mypage?type=articles')
  @Headers({'accessToken': 'true'})
  Future<List<MyPostEntity>> getMyPost();

  @GET('mypage?type=likes')
  @Headers({'accessToken': 'true'})
  Future<List<MyLikesEntity>> getLikePost();

  @GET('mypage?type=clipping')
  @Headers({'accessToken': 'true'})
  Future<List<MyClipEntity>> getClipPost();
}