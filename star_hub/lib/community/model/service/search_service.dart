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

  SearchService(this.repository) : super(SearchStateNone());


  Future<List<SearchPostEntity>> searchArticles(String words, int offset) async {
    state = SearchStateLoading();
    List<SearchPostEntity> post = await repository.searchArticle(words, offset);
    state = SearchStateSuccess(post);
    return post;
  }
}