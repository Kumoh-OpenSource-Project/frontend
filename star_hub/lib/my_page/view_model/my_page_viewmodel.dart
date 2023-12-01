import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/my_page/model/entity/user_info_entity.dart';
import 'package:star_hub/my_page/model/my_page_service.dart';
import 'package:star_hub/my_page/model/state.dart';

final myPageViewModelProvider =
ChangeNotifierProvider((ref) => MyPageViewModel(ref));

class MyPageViewModel extends ChangeNotifier {
  Ref ref;
  late MyPageState state;

  UserInfoEntity get entity =>
      (state as MyPageStateSuccess).data;


  MyPageViewModel(this.ref) {
    state = ref.read(myPageServiceProvider);
    ref.listen(myPageServiceProvider, (previous, next) {
      print('Scope State: $previous -> $next');

      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }


}
