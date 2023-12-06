import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/my_page/model/entity/my_post_entity.dart';
import 'package:star_hub/my_page/model/service/my_post_service.dart';


final myPostViewModelProvider =
ChangeNotifierProvider((ref) => MyPostViewModel(ref));

class MyPostViewModel extends ChangeNotifier {
  Ref ref;
  late final MyPostService myPostService;
  MyPostState state = MyPostState();
  ValueNotifier<List<MyPostEntity>> _entityNotifier =
  ValueNotifier<List<MyPostEntity>>([]);

  MyPostViewModel(this.ref) {
    myPostService = ref.read(myPostPostServiceProvider);
    _entityNotifier.addListener(() {
      getInfo();
    });
  }

  List<MyPostEntity> get entity => myPostService.postEntity;

  void getInfo() =>
      state.withResponse(myPostService.getMyPost());
}