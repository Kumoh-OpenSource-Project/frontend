import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/service/search_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';

final searchPostViewModelProvider =
    ChangeNotifierProvider((ref) => SearchPostViewModel(ref));

class SearchPostViewModel extends ChangeNotifier {
  Ref ref;
  late final SearchService searchService;
  late final DetailPostService detailPostService;
  SearchState searchState = SearchState();
  DetailPostState detailPostState = DetailPostState();
  int searchPage = 0;
  bool hasNextSearch = false;
  String previousWord = "";

  List<SearchPostEntity> get searchList => searchService.searchList;

  SearchPostViewModel(this.ref) {
    searchService = ref.read(searchPostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void getInfo(String word, int offset) =>
      searchState.withResponse(searchService.getSearchArticles(word, offset));

  void onTextFieldFocused() {
    print("reset");
    searchService.reset();
  }

  void navigateToDetailPage(BuildContext context, int postId, int? type, int writerId) {
    detailPostState.withResponse(detailPostService.getPosts(postId));
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(type, postId, writerId)));
  }

  List<SearchPostEntity> getSearchList() {
    return searchList;
  }

  List<SearchPostEntity> getSearchEntity() {
    return searchService.searchEntity;
  }

  bool getHasNext() {
    bool hasNext;
    hasNext = searchService.hasNextSearch;
    return hasNext;
  }

  bool getNextPage(String words, bool isNew, int page) {
    hasNextSearch = searchService.returnSearchPage() ||
        (previousWord != words || (isNew == true && previousWord == words));
    print(isNew);
    if (hasNextSearch) {
      searchState
          .withResponse(searchService.getSearchArticles(words, page));
    }
    return false;
  }
}
