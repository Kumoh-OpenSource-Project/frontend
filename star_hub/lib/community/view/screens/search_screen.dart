import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/community/view_model/search_post_viewmodel.dart';
import '../../../common/value_state_listener.dart';
import '../widgets/post_box2.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with TickerProviderStateMixin {
  final searchPostViewModelProvider =
      ChangeNotifierProvider((ref) => SearchPostViewModel(ref));
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _searchScrollController = ScrollController();
  late final FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late final VoidCallback? onPressed;
  bool isInit = true;
  late SearchPostViewModel viewModel;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _searchScrollController.addListener(_searchScrollListener);
    _searchFocusNode = FocusNode();
    _searchFocusNode.requestFocus();
    _searchFocusNode.addListener(_onSearchFocusChanged);
    viewModel = ref.read(searchPostViewModelProvider);
    viewModel.searchState.addListener(_setState);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // if (!isInit) {
    //   ref.read(searchPostViewModelProvider.notifier).onTextFieldFocused();
    // }
    // isInit = false;
  }

  void _setState() => setState(() {});

  @override
  void dispose() {
    _searchScrollController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    viewModel.searchState.removeListener(_setState);
    super.dispose();
  }

  void _searchScrollListener() {
    if (_searchScrollController.position.pixels ==
        _searchScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  String formatTimeDifference(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    String formattedNow = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(now);
    DateTime nowDate = DateTime.parse(formattedNow);
    Duration difference = nowDate.difference(date);

    if (difference.inDays > 365) {
      return DateFormat('YYYY-MM-dd').format(date);
    } else if (difference.inDays > 0) {
      return DateFormat('MM-dd').format(date);
    } else if (difference.inHours > 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference.inMinutes > 0) {
      return DateFormat('HH:mm').format(date);
    } else {
      return DateFormat('HH:mm').format(date);
    }
  }

  List<SearchPostEntity> searchList = [];
  bool isSearching = false;

  Future<void> _loadMoreData() async {
    if (viewModel.getHasNext() == true &&
        _searchController.text.isNotEmpty &&
        !_searchFocusNode.hasFocus) {
      viewModel.getNextPage(_searchController.text, false, page++);
    }
  }

  void _onSearchFocusChanged() {
    setState(() {
      isSearching = _searchFocusNode.hasFocus;
    });
    if (isSearching) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.scopeReset) {
      searchList.clear();
      page = 1;
      print(viewModel.searchList);
      searchList.addAll(viewModel.searchList);
      viewModel.makeNotRecent();

      //_scopeScrollController.jumpTo(0.0);
    } else {
      searchList.addAll(viewModel.searchList.where(
        (newItem) =>
            !searchList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }
    // searchList.addAll(viewModel.searchList.where(
    //   (newItem) =>
    //       !searchList.any((existingItem) => existingItem.id == newItem.id),
    // ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          cursorColor: Colors.white,
          focusNode: _searchFocusNode,
          onSubmitted: (text) {
            if (text.trim().length < 2) {
              setState(() {
                page = 0;
                searchList.clear();
                viewModel.getNextPage(text, true, page++);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "최소 두 글자 이상 입력해주세요.",
                  ),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 500),
                ),
              );
            } else {
              setState(() {
                page = 0;
                searchList.clear();
                viewModel.getNextPage(text, true, page++);
              });
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.white,
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        print("클리어");
                        searchList.clear();
                        _searchFocusNode.requestFocus();
                        _animationController.reverse();
                      });
                    },
                  )
                : null,
            hintText: '검색어를 입력하세요.',
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: viewModel.searchState.isError == true
          ? _buildAnimatedNewTextWidget()
          : _searchFocusNode.hasFocus
              ? _buildAnimatedNewTextWidget()
              : _buildSearchResults(),
    );
  }

  Widget _buildAnimatedNewTextWidget() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.value,
          child: child,
        );
      },
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            SizedBox(
              height: 20,
            ),
            Text(
              '검색어를 입력하세요',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: 1.0 - _animationController.value,
          child: child,
        );
      },
      child: ValueStateListener(
        state: viewModel.searchState,
        loadingBuilder: (_, __) => searchList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _searchScrollController,
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  final post = searchList[index];
                  return PostBox2(
                      title: post.title,
                      content: post.contentText,
                      nickName: post.nickName,
                      writerId: post.writerId,
                      writeDate: formatTimeDifference(post.writeDate),
                      level: post.level,
                      likes: post.likes,
                      clips: post.clips,
                      comments: post.comments,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        4, post.id, post.writerId,
                                        word: _searchController.text,
                                        searchState: viewModel.searchState)))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              if (value is bool) {
                                viewModel.getInfo(_searchController.text, 0);
                              } else {
                                searchList[index] = post.copyWith(
                                  title: value.title,
                                  contentText: value.content,
                                  likes: value.likes,
                                  clips: value.clips,
                                  comments: value.comments.length,
                                );
                              }
                            });
                          }
                        });
                      });
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
        successBuilder: (_, state) => searchList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _searchScrollController,
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  final post = searchList[index];
                  return PostBox2(
                      title: post.title,
                      content: post.contentText,
                      nickName: post.nickName,
                      writerId: post.writerId,
                      writeDate: formatTimeDifference(post.writeDate),
                      level: post.level,
                      likes: post.likes,
                      clips: post.clips,
                      comments: post.comments,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        4, post.id, post.writerId,
                                        word: _searchController.text,
                                        searchState: viewModel.searchState)))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              if (value is bool) {
                                viewModel.getInfo(_searchController.text, 0);
                              } else {
                                searchList[index] = post.copyWith(
                                  title: value.title,
                                  contentText: value.content,
                                  likes: value.likes,
                                  clips: value.clips,
                                  comments: value.comments.length,
                                );
                              }
                            });
                          }
                        });
                      });
                },
              )
            : Center(
                child: Text("\"${_searchController.text}\" 에 대한 검색 결과가 없습니다.")),
      ),
    );
  }
}
