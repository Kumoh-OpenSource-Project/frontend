import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/const/tabs.dart';
import 'package:star_hub/community/view/screens/write_post_screen.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:intl/intl.dart';

class FullPostPage extends ConsumerStatefulWidget {
  const FullPostPage({super.key});

  @override
  ConsumerState<FullPostPage> createState() => _FullPostPageState();
}

class _FullPostPageState extends ConsumerState<FullPostPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scopeScrollController = ScrollController();
  final ScrollController _placeScrollController = ScrollController();
  final ScrollController _photoScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scopeScrollController.addListener(_scopeScrollListener);
    _placeScrollController.addListener(_placeScrollListener);
    _photoScrollController.addListener(_photoScrollListener);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void _scopeScrollListener() {
    if (_scopeScrollController.position.pixels ==
        _scopeScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  void _placeScrollListener() {
    if (_placeScrollController.position.pixels ==
        _placeScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  void _photoScrollListener() {
    if (_photoScrollController.position.pixels ==
        _photoScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  String formatTimeDifference(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();

    Duration difference = now.difference(date);

    if (difference.inDays > 0) {
      return DateFormat('yyyy-MM-dd').format(date);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  Future<void> _loadMoreData() async {
    final viewModel = ref.read(postViewModelProvider);
    String selectedCategory = tabs[_tabController.index].label;
    switch (selectedCategory) {
      case "관측도구":
        if (viewModel.getHasNext("scope") == true) {
          viewModel.getNextPage("scope");
        }
        break;
      case "관측장소":
        if (viewModel.getHasNext("place") == true) {
          viewModel.getNextPage("place");
        }
        break;
      case "사진자랑":
        if (viewModel.getHasNext("photo") == true) {
          viewModel.getNextPage("photo");
        }
        break;
      default:
        break;
    }
  }

  Future<void> _refreshScope() async {
    final viewModel = ref.read(postViewModelProvider);
    viewModel.refreshData("scope");
    return Future.value();
  }

  Future<void> _refreshPlace() async {
    final viewModel = ref.read(postViewModelProvider);
    viewModel.refreshData("place");
    return Future.value();
  }

  Future<void> _refreshPhoto() async {
    final viewModel = ref.read(postViewModelProvider);
    viewModel.refreshData("photo");
    return Future.value();
  }

  final scopeList = [];
  final placeList = [];
  final photoList = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(postViewModelProvider);

    if (viewModel.getScopeList().isEmpty) scopeList.clear();
    if (viewModel.getPlaceList().isEmpty) placeList.clear();
    if (viewModel.getPhotoList().isEmpty) photoList.clear();
    scopeList.addAll(viewModel.getScopeEntity("scope").where(
          (newItem) =>
              !scopeList.any((existingItem) => existingItem.id == newItem.id),
        ));
    placeList.addAll(viewModel.getPlaceEntity("place").where(
          (newItem) =>
              !placeList.any((existingItem) => existingItem.id == newItem.id),
        ));
    photoList.addAll(viewModel.getPhotoEntity("photo").where(
          (newItem) =>
              !photoList.any((existingItem) => existingItem.id == newItem.id),
        ));

    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.only(bottom: 15.0),
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              tabs: tabs
                  .map(
                    (e) => Tab(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(tabs.indexOf(e));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(e.icon),
                                const SizedBox(width: 10),
                                Text(e.label, style: kTextContentStyleSmall),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  scopeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshScope,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            controller: _scopeScrollController,
                            children: [
                              for (int index = 0;
                                  index < scopeList.length;
                                  index++)
                                PostBox2(
                                  title: scopeList[index].title,
                                  content: scopeList[index].contentText,
                                  nickName: scopeList[index].nickName,
                                  writerId: scopeList[index].writerId,
                                  writeDate: formatTimeDifference(
                                      scopeList[index].writeDate),
                                  level: scopeList[index].level,
                                  likes: scopeList[index].likes,
                                  clips: scopeList[index].clips,
                                  comments: scopeList[index].comments,
                                  onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    scopeList[index].id,
                                    scopeList[index].categoryId,
                                    scopeList[index].writerId,
                                  ),
                                ),
                              if (viewModel.getHasNext("scope"))
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              else
                                Container(),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  placeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPlace,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            controller: _scopeScrollController,
                            children: [
                              for (int index = 0;
                                  index < placeList.length;
                                  index++)
                                PostBox2(
                                  title: placeList[index].title,
                                  content: placeList[index].contentText,
                                  nickName: placeList[index].nickName,
                                  writerId: placeList[index].writerId,
                                  writeDate: formatTimeDifference(
                                      placeList[index].writeDate),
                                  level: placeList[index].level,
                                  likes: placeList[index].likes,
                                  clips: placeList[index].clips,
                                  comments: placeList[index].comments,
                                  onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    placeList[index].id,
                                    placeList[index].categoryId,
                                    placeList[index].writerId,
                                  ),
                                ),
                              if (viewModel.getHasNext("place"))
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              else
                                Container(),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  photoList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPhoto,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 5열
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: photoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final post = photoList[index];
                              return GestureDetector(
                                onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    post.id,
                                    post.categoryId,
                                    post.writerId),
                                child: Image.network(
                                  post.photos[0],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Container(
                                        color:
                                            Colors.grey[300]?.withOpacity(0.1),
                                        width: double.infinity,
                                        height: double.infinity,
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showWritePostPage(context, viewModel);
        },
        child: Icon(
          PhosphorIcons.pencilSimpleLine(
            PhosphorIconsStyle.duotone,
          ),
          size: 32.0,
        ),
      ),
    );
  }

  void _showWritePostPage(BuildContext context, PostViewModel viewModel) {
    int selectedIndex = _tabController.index;

    String selectedCategory = tabs[selectedIndex].label;

    Map<String, String> categoryMap = {
      '관측도구': 'scope',
      '관측장소': 'place',
      '사진자랑': 'photo',
    };

    selectedCategory = categoryMap[selectedCategory] ?? selectedCategory;

    Navigator.of(context).push(_createRoute(selectedCategory, viewModel));
  }

  Route _createRoute(String selectedCategory, PostViewModel viewModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WritePostPage(
          selectedCategory: selectedCategory, viewModel: viewModel),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
