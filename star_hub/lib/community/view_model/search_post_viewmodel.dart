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
  bool hasNextSearch = false;
  String previousWord = "";

  List<SearchPostEntity> get searchList => searchService.searchList;

  bool get searchReset => searchService.isSearchReset;

  bool isSearchReset = false;

  //List<SearchPostEntity> get  => searchService.searchList;
  void getScopeReset(String string) {
    isSearchReset = true;
    searchState.withResponse(searchService.getSearchArticles(string, 0));
  }

  SearchPostViewModel(this.ref) {
    searchService = ref.read(searchPostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void getInfo(String word, int offset) {
    searchState.withResponse(searchService.getSearchArticles(word, offset));
  }

  void onTextFieldFocused() {
    searchService.reset();
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
  void makeNotRecent() {
    searchService.makeNonReset();
  }

  bool getNextPage(String words, bool isNew, int page) {
    isSearchReset = false;
    hasNextSearch = searchService.returnSearchPage() ||
        (previousWord != words || (isNew == true && previousWord == words));
    if (page == 0) hasNextSearch = true;
    if (page == 0) {
      searchState.withResponse(searchService.getSearchArticles(words, page));
    } else if (hasNextSearch) {
      searchState.withResponse(searchService.getSearchArticles(words, page));
    }
    return false;
  }
}
