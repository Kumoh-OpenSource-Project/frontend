import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/const/tabs.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_best_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/community/view/screens/write_post_screen.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:intl/intl.dart';
import '../../../my_page/model/state.dart';
import '../../../my_page/view_model/my_page_viewmodel.dart';
import '../../model/entity/scope_best_entity.dart';
import '../../model/service/scope_service.dart';
import '../widgets/icon_num.dart';

const limit = "수성";

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
  late PostViewModel viewModel;
  late final bestScopePost2;
  late final bestPlacePost2;
  late ScopeBestEntity bestScopePost;
  late PlaceBestEntity bestPlacePost;
  int scopePage = 0;
  int placePage = 0;
  int photoPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchBestScopePost();
    _fetchBestPlacePost();
    _scopeScrollController.addListener(_scopeScrollListener);
    _placeScrollController.addListener(_placeScrollListener);
    _photoScrollController.addListener(_photoScrollListener);
    _tabController = TabController(length: tabs.length, vsync: this);
    viewModel = ref.read(postViewModelProvider)
      ..getNextPage("scope", scopePage++)
      ..getNextPage("place", placePage++)
      ..getNextPage("photo", photoPage++);
    print("init");
    print(photoPage);
    viewModel.scopeState.addListener(_setState);
    viewModel.placeState.addListener(_setState);
    viewModel.photoState.addListener(_setState);
  }

  Future<void> _fetchBestScopePost() async {
    bestScopePost2 = await ref
        .read(scopePostServiceProvider)
        .getScopeBestPost()
        .then((value) {
      bestScopePost = ref.read(scopePostServiceProvider).scopeBestEntity;
    });
  }

  Future<void> _fetchBestPlacePost() async {
    bestPlacePost2 = await ref
        .read(placePostServiceProvider)
        .getPlaceBestPost()
        .then((value) {
      bestPlacePost = ref.read(placePostServiceProvider).placeBestEntity;
    });
  }

  @override
  void dispose() {
    viewModel.scopeState.removeListener(_setState);
    viewModel.placeState.removeListener(_setState);
    viewModel.photoState.removeListener(_setState);
    super.dispose();
  }

  void _scopeScrollListener() {
    if (_scopeScrollController.position.pixels ==
        _scopeScrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _placeScrollListener() {
    if (_placeScrollController.position.pixels ==
        _placeScrollController.position.maxScrollExtent) {
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
    String formattedNow = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(now);
    DateTime nowDate = DateTime.parse(formattedNow);
    Duration difference = nowDate.difference(date);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years년 전';
    } else if (difference.inDays > 0) {
      return DateFormat('MM-dd').format(date);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  Future<void> _loadMoreData() async {
    String selectedCategory = tabs[_tabController.index].label;
    switch (selectedCategory) {
      case "관측도구":
        if (viewModel.getHasNext("scope") == true) {
          viewModel.getNextPage("scope", scopePage++);
        }
        break;
      case "관측장소":
        if (viewModel.getHasNext("place") == true) {
          viewModel.getNextPage("place", placePage++);
        }
        break;
      case "사진자랑":
        if (viewModel.getHasNext("photo") == true) {
          viewModel.getNextPage("photo", photoPage++);
          print(photoPage);
        }
        break;
      default:
        break;
    }
  }

  Future<void> _refreshScope() async {
    viewModel.getScopeReset();
    return Future.value();
  }

  Future<void> _refreshPlace() async {
    placePage = 0;
    viewModel.refreshData("place", placePage++);
    return Future.value();
  }

  Future<void> _refreshPhoto() async {
    photoPage = 0;
    viewModel.refreshData("photo", photoPage++);
    return Future.value();
  }

  void _setState() => setState(() {});

  List<ScopeFullPostEntity> scopeList = [];
  List<PlaceFullPostEntity> placeList = [];
  List<PhotoFullPostEntity> photoList = [];

  @override
  Widget build(BuildContext context) {
    final userViewmodel = ref.watch(myPageViewModelProvider);

    if (userViewmodel.state is MyPageStateSuccess) {
      print(userViewmodel.entity.level);
    }
    if (viewModel.scopeReset) {
      scopeList.clear();
      scopePage = 1;
      scopeList.addAll(viewModel.scopeList);
      viewModel.makeNotRecentScope();
    } else {
      scopeList.addAll(viewModel.scopeList.where(
        (newItem) =>
            !scopeList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }
    if (viewModel.placeReset) {
      placeList.clear();
      placePage = 1;
      placeList.addAll(viewModel.placeList);
      viewModel.makeNotRecentPlace();
    } else {
      placeList.addAll(viewModel.placeList.where(
        (newItem) =>
            !placeList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }
    if (viewModel.photoReset) {
      photoList.clear();
      photoPage = 1;
      photoList.addAll(viewModel.photoList);
      viewModel.makeNotRecentScope();
    } else {
      photoList.addAll(viewModel.photoList.where(
        (newItem) =>
            !photoList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
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
                            if (e.label == "관측장소" &&
                                userViewmodel.state is MyPageStateSuccess &&
                                userViewmodel.entity.level == limit) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "금성 레벨 이상이어야 관측장소를 열람할 수 있습니다.",
                                  ),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height -
                                              250),
                                ),
                              );
                              return;
                            }

                            _tabController.animateTo(tabs.indexOf(e));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: e.label == "관측장소" &&
                                        userViewmodel.state
                                            is MyPageStateSuccess &&
                                        userViewmodel.entity.level == limit
                                    ? Colors.grey
                                    : Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? Icons.lock
                                      : e.icon,
                                  color: e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? Colors.grey
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  e.label,
                                  style: e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? kTextContentStyleSmall.copyWith(
                                          color: Colors.grey)
                                      : kTextContentStyleSmall,
                                ),
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
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  scopeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshScope,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _scopeScrollController,
                            itemCount: scopeList.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          1,
                                          bestScopePost.id,
                                          null,
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {
                                        bestScopePost.like = value.likes;
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.local_fire_department),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 15.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  bestScopePost.title ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconWithNumber(
                                                  icon: FontAwesomeIcons.heart,
                                                  number:
                                                      bestScopePost.like ?? 0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (index == scopeList.length + 1) {
                                return viewModel.getHasNext("scope")
                                    ? Center(
                                        child: Image.asset(
                                        'assets/gif/star55.gif',
                                        height: 125.0,
                                        width: 125.0,
                                      ))
                                    : Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.white24,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      );
                              } else {
                                int scopeIndex = index - 1;
                                return PostBox2(
                                  title: scopeList[scopeIndex].title,
                                  content: scopeList[scopeIndex].contentText,
                                  nickName: scopeList[scopeIndex].nickName,
                                  writerId: scopeList[scopeIndex].writerId,
                                  writeDate: formatTimeDifference(
                                      scopeList[scopeIndex].writeDate),
                                  level: scopeList[scopeIndex].level,
                                  likes: scopeList[scopeIndex].likes,
                                  clips: scopeList[scopeIndex].clips,
                                  comments: scopeList[scopeIndex].comments,
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          scopeList[scopeIndex].categoryId,
                                          scopeList[scopeIndex].id,
                                          scopeList[scopeIndex].writerId,
                                          scopeCommunityState:
                                              viewModel.scopeState,
                                        ),
                                      ),
                                    ).then((value) {
                                      print("아무거나");
                                      if (value != null) {
                                        if (value is bool) {
                                          _scopeScrollController.jumpTo(0.0);
                                        } else {
                                          print("아무거나1");
                                          setState(() {
                                            scopeList[scopeIndex] =
                                                scopeList[scopeIndex].copyWith(
                                              title: value.title,
                                              contentText: value.content,
                                              likes: value.likes,
                                              clips: value.clips,
                                              comments: value.comments.length,
                                              isClipped: value.isClipped,
                                              isLike: value.isLike,
                                            );
                                          });
                                        }
                                      }
                                    });
                                  },
                                );
                              }
                            },
                          ))
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  placeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPlace,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _placeScrollController,
                            itemCount: placeList.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          2,
                                          bestPlacePost.id,
                                          null,
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {
                                        bestPlacePost.like = value.likes;
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.local_fire_department),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 15.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  bestPlacePost.title ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconWithNumber(
                                                  icon: FontAwesomeIcons.heart,
                                                  number:
                                                      bestPlacePost.like ?? 0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (index == placeList.length + 1) {
                                return viewModel.getHasNext("place")
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white))
                                    : Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.white24,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      );
                              } else {
                                int placeIndex = index - 1;
                                return PostBox2(
                                  title: placeList[placeIndex].title,
                                  content: placeList[placeIndex].contentText,
                                  nickName: placeList[placeIndex].nickName,
                                  writerId: placeList[placeIndex].writerId,
                                  writeDate: formatTimeDifference(
                                      placeList[placeIndex].writeDate),
                                  level: placeList[placeIndex].level,
                                  likes: placeList[placeIndex].likes,
                                  clips: placeList[placeIndex].clips,
                                  comments: placeList[placeIndex].comments,
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          placeList[placeIndex].categoryId,
                                          placeList[placeIndex].id,
                                          placeList[placeIndex].writerId,
                                          placeCommunityState:
                                              viewModel.placeState,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        if (value is bool) {
                                          _placeScrollController.jumpTo(0.0);
                                        } else {
                                          setState(() {
                                            placeList[placeIndex] =
                                                placeList[placeIndex].copyWith(
                                              title: value.title,
                                              contentText: value.content,
                                              likes: value.likes,
                                              clips: value.clips,
                                              comments: value.comments.length,
                                              isClipped: value.isClipped,
                                              isLike: value.isLike,
                                            );
                                          });
                                        }
                                      }
                                    });
                                  },
                                );
                              }
                            },
                          ))
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  photoList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPhoto,
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: _photoScrollController,
                            slivers: [
                              // SliverToBoxAdapter(
                              //   child: Container(
                              //     color: Colors.tealAccent,
                              //     alignment: Alignment.center,
                              //     height: 200,
                              //     child: const Text('This is Container'),
                              //   ),
                              // ),
                              SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 5열
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              photoList[index].categoryId,
                                              photoList[index].id,
                                              photoList[index].writerId,
                                              photoCommunityState:
                                                  viewModel.photoState,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        photoList[index].photos[0],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Container(
                                              color: Colors.grey[300]
                                                  ?.withOpacity(0.1),
                                              width: double.infinity,
                                              height: double.infinity,
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                  childCount: photoList.length,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
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

    Navigator.of(context)
        .push(_createRoute(selectedCategory, viewModel))
        .then((value) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      if (selectedCategory == "scope") {
        _scopeScrollController.jumpTo(0.0);
      } else if (selectedCategory == "place") {
        print("1");
        _placeScrollController.jumpTo(0.0);
      } else {
        _photoScrollController.jumpTo(0.0);
      }
    });
  }

  Route _createRoute(String selectedCategory, PostViewModel viewModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WritePostPage(
        selectedCategory: selectedCategory,
        viewModel: viewModel,
        userLevel:
            (ref.watch(myPageViewModelProvider).state is MyPageStateSuccess)
                ? ref.watch(myPageViewModelProvider).entity.level
                : null,
      ),
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
