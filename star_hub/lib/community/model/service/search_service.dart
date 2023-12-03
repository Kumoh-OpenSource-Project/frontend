import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

import '../../../common/entity/response_entity.dart';

final searchPostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return SearchService(repository);
});

class SearchService {
  final CommunityRepository repository;

  // offset 변수랑 값을 맞춰야 함.
  int searchPage = 0;

  // 다음 페이지가 있는가.
  bool hasNextSearch = true;

  List<SearchPostEntity> searchList = [];
  List<SearchPostEntity> searchEntity = [];

  SearchService(this.repository);

  Future<ResponseEntity<List<SearchPostEntity>>> getSearchArticles(
      String words, int offset) async {
    try {
      searchEntity.clear();
      if (offset == 0) {
        searchList.clear();
        hasNextSearch = true;
        searchPage = 0;
      }
      final List<SearchPostEntity> post =
          await repository.searchArticle(words, offset);
      if (post.isEmpty) {
        hasNextSearch = false;
      } else {
        hasNextSearch = true;

        searchList.addAll(post);
        searchPage++;
      }
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

  // vm에 NextPage 있는지 전달한다.(동기)
  bool returnSearchPage() {
    return hasNextSearch;
  }

  // vm에 SearchEntity 전달한다.(동기)
  List<SearchPostEntity> getSearchEntity() {
    return searchEntity;
  }

  Future reset() async {
    searchList = [];
    searchEntity = [];
  }
}
