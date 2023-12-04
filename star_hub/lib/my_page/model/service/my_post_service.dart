import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/my_page/model/entity/my_clip_entity.dart';
import 'package:star_hub/my_page/model/entity/my_likes_entity.dart';
import 'package:star_hub/my_page/model/entity/my_post_entity.dart';
import 'package:star_hub/my_page/model/repository/my_page_repository.dart';

final myPostPostServiceProvider = Provider((ref) {
  final repository = ref.watch(myPageRepositoryProvider);
  return MyPostService(repository);
});

class MyPostService {
  final MyPageRepository repository;

  MyPostService(this.repository);

  Future<ResponseEntity<List<MyClipEntity>>> getClipPost() async {
    try {
      final List<MyClipEntity> post = await repository.getClipPost();
      return ResponseEntity.success(entity: post);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity<List<MyLikesEntity>>> getLikePost() async {
    try {
      final List<MyLikesEntity> post = await repository.getLikePost();
      return ResponseEntity.success(entity: post);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity<List<MyPostEntity>>> getMyPost() async {
    try {
      final List<MyPostEntity> post = await repository.getMyPost();
      return ResponseEntity.success(entity: post);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}