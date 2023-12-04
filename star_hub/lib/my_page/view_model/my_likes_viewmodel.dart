import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/my_page/model/service/my_post_service.dart';

final myLikeViewModelProvider =
    ChangeNotifierProvider((ref) => MyLikeViewModel(ref));

class MyLikeViewModel extends ChangeNotifier {
  Ref ref;
  late final MyPostService myPostService;
  late final DetailPostService detailPostService;
  MyPostLikeState state = MyPostLikeState();
  DetailPostState detailPostState = DetailPostState();

  MyLikeViewModel(this.ref) {
    myPostService = ref.read(myPostPostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void getInfo() =>
      state.withResponse(myPostService.getLikePost());

  void navigateToDetailPage(
      BuildContext context, int postId, int? type, int writerId) {
    detailPostState.withResponse(detailPostService.getPosts(postId));
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(type, postId, writerId)));
  }
}
