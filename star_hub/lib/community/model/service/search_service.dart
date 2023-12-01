import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/state/state.dart';

final searchPostServiceProvider =
    StateNotifierProvider<SearchService, CommunityState>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return SearchService(repository);
});

class SearchService extends StateNotifier<CommunityState> {
  final CommunityRepository repository;

  // offset 변수랑 값을 맞춰야 함.
  int searchPage = 0;

  //String previousWord = "";

  // 다음 페이지가 있는가.
  bool hasNextSearch = true;

  List<SearchPostEntity> searchList = [];
  List<SearchPostEntity> searchEntity = [];

  SearchService(this.repository)
      : searchList = [],
        searchEntity = [],
        super(SearchStateNone());

  Future searchArticles(String words, int offset) async {
    try {
      searchEntity.clear();
      state = SearchStateLoading();
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
      state = SearchStateSuccess(post);
      searchEntity.addAll(post);
    } catch (e) {
      _handleError(e);
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

  Future<void> _handleError(dynamic error) async {
    //todo : print 나중에 지워주세요!
    print('Error in SearchPostService: $error');
    state = SearchStateError(error.toString());
  }

  Future reset() async {
    searchList = [];
    searchEntity = [];
  }
}
