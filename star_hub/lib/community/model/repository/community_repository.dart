import 'package:dio/src/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:star_hub/common/dio.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/delete_comment_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/like_clip_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:star_hub/community/model/entity/write_comment_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.stub.dart';
part 'community_repository.g.dart';

final communityRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  //return CommunityRepository(dio);
  return CommunityRepositoryStub();
});

@RestApi()
abstract class CommunityRepository {
  factory CommunityRepository(Dio dio, {String? baseUrl}) = _CommunityRepository;

  @POST('/articles/like')
  @Headers({'accessToken': 'true'})
  Future addLike(@Body() ToggledLikeClipEntity entity);

  @DELETE('/articles/like')
  @Headers({'accessToken': 'true'})
  Future cancelLike(@Body() ToggledLikeClipEntity entity);

  @POST('/articles/clipping')
  @Headers({'accessToken': 'true'})
  Future addClip(@Body() ToggledLikeClipEntity entity);

  @DELETE('/articles/clipping')
  @Headers({'accessToken': 'true'})
  Future cancelClip(@Body() ToggledLikeClipEntity entity);

  @GET('/articles?type=scope&offset={offset}')
  @Headers({'accessToken': 'true'})
  Future<List<FullPostEntity>> getFullScopePost(@Path("offset") int offset);

  @GET('/articles?type=scope&offset={offset}')
  @Headers({'accessToken': 'true'})
  Future<List<FullPostEntity>> getFullPlacePost(@Path("offset") int offset);

  @GET('/articles?type=scope&offset={offset}')
  @Headers({'accessToken': 'true'})
  Future<List<FullPostEntity>> getFullPhotoPost(@Path("offset") int offset);

  @GET('/articles/{id}')
  @Headers({'accessToken': 'true'})
  Future<DetailPostEntity> getDetailPost(@Path("id") int id);

  @POST('/articles')
  @Headers({'accessToken': 'true'})
  Future postArticle(@Body() PostArticleEntity entity);

  @PATCH('/articles')
  @Headers({'accessToken': 'true'})
  Future updateArticle(@Body() UpdateArticleEntity entity);

  @DELETE('/articles')
  @Headers({'accessToken': 'true'})
  Future deletePost(@Body() DeleteArticleEntity entity);

  @POST('/comment')
  @Headers({'accessToken': 'true'})
  Future writeComment(@Body() WriteCommentEntity entity);

  // @PATCH('/articles')
  // @Headers({'accessToken': 'true'})
  // Future updateComment(@Body() Update entity);

  //검색

  @DELETE('/articles')
  @Headers({'accessToken': 'true'})
  Future deleteComment(@Body() DeleteCommentEntity entity);

}
