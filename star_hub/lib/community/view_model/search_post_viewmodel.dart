import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/service/search_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';

final searchPostViewModelProvider =
    ChangeNotifierProvider((ref) => SearchPostViewModel(ref));

class SearchPostViewModel extends ChangeNotifier {
  Ref ref;
  late CommunityState state;
  int searchPage = 0;
  bool hasNextSearch = false;
  List<SearchPostEntity> searchList = [];
  String previousWord = "";

  List<SearchPostEntity> get entity => (state as SearchStateSuccess).data;

  SearchPostViewModel(this.ref) {
    searchList = ref.read(searchPostServiceProvider.notifier).searchList;
    state = ref.read(searchPostServiceProvider);
    ref.listen(searchPostServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }

  void onTextFieldFocused() {
    print("reset");
    ref.read(searchPostServiceProvider.notifier).reset();
  }

  void navigateToDetailPage(BuildContext context, int postId, int type) {
    ref.read(detailPostServiceProvider.notifier).getPosts(postId);
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(type)));
  }

  List<SearchPostEntity> getSearchList() {
    return searchList;
  }

  List<SearchPostEntity> getSearchEntity() {
    return ref.read(searchPostServiceProvider.notifier).searchEntity;
  }

  bool getHasNext() {
    bool hasNext;
    hasNext = ref.read(searchPostServiceProvider.notifier).hasNextSearch;
    return hasNext;
  }

  bool getNextPage(String words, bool isNew) {
    searchPage = ref.read(searchPostServiceProvider.notifier).searchPage;
    hasNextSearch =
        ref.read(searchPostServiceProvider.notifier).returnSearchPage() ||
            (previousWord != words || (isNew == true && previousWord == words ));
    print(isNew);
    if (previousWord != words || (isNew == true && previousWord == words )) searchPage = 0;
    previousWord = words;
    if (hasNextSearch) {
      ref
          .read(searchPostServiceProvider.notifier)
          .searchArticles(words, searchPage);
    }
    return false;
  }
}
