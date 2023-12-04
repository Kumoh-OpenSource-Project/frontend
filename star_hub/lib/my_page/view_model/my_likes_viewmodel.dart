// final searchPostViewModelProvider =
// ChangeNotifierProvider((ref) => SearchPostViewModel(ref));
//
// class SearchPostViewModel extends ChangeNotifier {
//   Ref ref;
//   late final SearchService searchService;
//   late final DetailPostService detailPostService;
//   SearchState searchState = SearchState();
//   DetailPostState detailPostState = DetailPostState();
//   int searchPage = 0;
//   bool hasNextSearch = false;
//   //List<SearchPostEntity> searchList = [];
//   String previousWord = "";
//
//   List<SearchPostEntity> get searchList => searchService.searchList;
//
//   SearchPostViewModel(this.ref) {
//     searchService = ref.read(searchPostServiceProvider);
//     detailPostService = ref.read(detailPostServiceProvider);
//   }
//
//   void getInfo(String word, int offset) =>
//       searchState.withResponse(searchService.getSearchArticles(word, offset));
//
//   void navigateToDetailPage(BuildContext context, int postId, int? type, int writerId) {
//     detailPostState.withResponse(detailPostService.getPosts(postId));
//     FocusManager.instance.primaryFocus?.unfocus();
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => DetailPage(type, postId, writerId)));
//   }
// }
