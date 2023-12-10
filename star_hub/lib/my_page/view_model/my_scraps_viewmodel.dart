import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/my_page/model/entity/my_clip_entity.dart';
import 'package:star_hub/my_page/model/entity/my_likes_entity.dart';
import 'package:star_hub/my_page/model/service/my_post_service.dart';

final myClipViewModelProvider =
    ChangeNotifierProvider((ref) => MyClipViewModel(ref));

class MyClipViewModel extends ChangeNotifier {
  Ref ref;
  late final MyPostService myPostService;
  MyPostClipState state = MyPostClipState();

  MyClipViewModel(this.ref) {
    myPostService = ref.read(myPostPostServiceProvider);
  }
  List<MyClipEntity> get entity => myPostService.clipEntity;


  void getInfo() => state.withResponse(myPostService.getClipPost());
}
