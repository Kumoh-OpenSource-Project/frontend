import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/my_page/view/widgets/post_box_widget.dart';
import 'package:star_hub/my_page/view_model/my_scraps_viewmodel.dart';

class MyScrapsPage extends ConsumerStatefulWidget {
  const MyScrapsPage({super.key});

  @override
  ConsumerState<MyScrapsPage> createState() => _MyScrapsPageState();
}

class _MyScrapsPageState extends ConsumerState<MyScrapsPage> {
  late MyClipViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(myClipViewModelProvider)..getInfo();
    viewModel.state.addListener(_setState);
  }

  @override
  void dispose() {
    viewModel.state.removeListener(_setState);
    super.dispose();
  }

  void _setState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Text(
              '내가 스크랩한 글 ',
              style: kTextContentStyleLarge,
            ),
            viewModel.state.isSuccess
                ? Text(
                    viewModel.state.value!.length.toString(),
                    style:
                        kTextContentStyleMiddle.copyWith(color: Colors.yellow),
                  )
                : Container()
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
              child: Image.asset(
                'assets/back2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ValueStateListener(
              state: viewModel.state,
              loadingBuilder: (_, __) => Center(
                      child: Image.asset(
                    'assets/gif/space.gif',
                    height: 50.0,
                    width: 50.0,
                  )),
              successBuilder: (_, state) => state.value!.isEmpty
                  ? const Center(
                      child: Text(
                        '스크랩한 글이 없습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: viewModel.entity.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == viewModel.entity.length) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        }
                        final post = viewModel.entity[index];
                        return GestureDetector(
                          onTap: () {},
                          child: PostBox(
                              categoryId: post.categoryId,
                              title: post.title,
                              content: post.content,
                              nickName: post.nickName,
                              writeDate: post.writeDate,
                              likes: null,
                              clips: null,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              7,
                                              post.articleId,
                                              null,
                                              myPostClipState: viewModel.state,
                                            ))).then((value) {
                                  viewModel.getInfo();
                                });
                              }),
                        );
                      },
                    ))
        ],
      ),
    );
  }
}
