import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          title: const Text('내가 스크랩한 글'),
        ),
        backgroundColor: Colors.black,
        body: ValueStateListener(
            state: viewModel.state,
            loadingBuilder: (_, __) => const CircularProgressIndicator(color: Colors.white,),
            successBuilder: (_, state) => state.value!.isEmpty
                ? const Center(
                    child: Text(
                      '스크랩한 글이 없습니다.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.entity.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = viewModel.entity[index];
                      return GestureDetector(
                        onTap: () {},
                        child: PostBox(
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
                  )));
  }
}
