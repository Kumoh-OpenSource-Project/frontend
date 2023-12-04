import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/my_page/model/entity/user_info_entity.dart';
import 'package:star_hub/my_page/model/repository/my_page_repository.dart';
import 'package:star_hub/my_page/model/state.dart';

final myPageServiceProvider =
StateNotifierProvider<MyPageService, MyPageState>((ref) {
  final repository = ref.watch(myPageRepositoryProvider);
  return MyPageService(repository);
});

class MyPageService extends StateNotifier<MyPageState> {
  final MyPageRepository repository;

  MyPageService(this.repository) : super(MyPageStateStateLoading()){
    getUserInfo();
  }

  Future getUserInfo() async {
    state = MyPageStateStateLoading();
    UserInfoEntity userInfo = await repository.getUserInfo();
    state = MyPageStateSuccess(userInfo);
  }
}