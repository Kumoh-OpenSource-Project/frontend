import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/search_post_entity.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:star_hub/community/view_model/search_post_viewmodel.dart';
import '../../model/repository/community_repository.dart';
import '../../model/service/search_service.dart';
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
    if (viewModel.searchList.isEmpty) searchList.clear();
    searchList.addAll(viewModel.searchList.where(
      (newItem) =>
          !searchList.any((existingItem) => existingItem.id == newItem.id),
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          cursorColor: Colors.white,
          focusNode: _searchFocusNode,
          onSubmitted: (text) {
            setState(() {
              page = 0;
              searchList.clear();
              viewModel.getNextPage(text, true, page++);
            });
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
                        _searchFocusNode.requestFocus(); // x 버튼 누를 때 커서 활성화
                        _animationController
                            .reverse(); // 검색창이 활성화된 상태에서 x 버튼 누를 때 애니메이션 역방향으로 실행
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
      body: _searchFocusNode.hasFocus
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
          // 검색창이 활성화된 상태일 때는 리스트뷰가 투명해지도록 설정
          child: child,
        );
      },
      child: searchList.isNotEmpty ? ListView.builder(
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
            writeDate: post.writeDate,
            level: post.level,
            likes: post.likes,
            clips: post.clips,
            comments: post.comments,
            onTap: () => viewModel.navigateToDetailPage(
                context, searchList[index].id, null, searchList[index].writerId)
          );
        },
      ): Center(child:Text("\"${_searchController.text}\" 에 대한 검색 결과가 없습니다.")),
    );
  }
}
