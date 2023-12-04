import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/my_page/view_model/my_likes_viewmodel.dart';

class MyLikesPage extends ConsumerWidget {
  const MyLikesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(myLikeViewModelProvider);
    viewModel.getInfo();
    return ValueStateListener(
      successBuilder: (_, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('내가 좋아요한 글'),
        ),
        backgroundColor: Colors.black,
        body: ListView.builder(itemBuilder:(BuildContext context, int index) {
            final post = state.value![index];
            return GestureDetector(
              onTap: (){},
              child: Text("c"),
              //PostBox2(title: '', content: '', nickName: '', writeDate: '',
              //),
            );
          },),
        ), state: viewModel.state,
      );

  }
}
