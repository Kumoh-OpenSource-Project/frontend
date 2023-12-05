import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

import '../../../common/entity/response_entity.dart';

final searchPostServiceProvider = Provider((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return SearchService(repository);
});

class SearchService {
  final CommunityRepository repository;
  bool hasNextSearch = true;
  bool isSearchReset = false;
  int searchPage = 0;
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
      }
      final List<SearchPostEntity> post =
          await repository.searchArticle(words, offset);
      if (post.isEmpty) {
        hasNextSearch = false;
      } else {
        hasNextSearch = true;

        searchList.addAll(post);
      }
      searchPage = offset;
      if (offset == 0) {
        isSearchReset = true;
        print(searchList);
        print("서비스에서 리셋함");
      } else {
        isSearchReset = false;
      }
      return ResponseEntity.success(entity: searchList);
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



  void makeNonReset() {
    isSearchReset = false;
  }
  // DELETE photoPost : 글을 삭제한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<SearchPostEntity>>> deleteSearchPost(
      DeleteArticleEntity entity, String word) async {
    await repository.deletePost(entity);
    return getSearchArticles(word, 0);
  }

  // PATCH photoPost : 글을 수정한다. 페이지 초기화 진행 (비동기)
  Future<ResponseEntity<List<SearchPostEntity>>> updateSearchPost(
      UpdateArticleEntity entity, String word) async {
    await repository.updateArticle(entity);
    return getSearchArticles(word, 0);
  }
}
