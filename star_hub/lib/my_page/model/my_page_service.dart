import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/my_page/model/entity/user_info_entity.dart';
import 'package:star_hub/my_page/model/my_page_repository.dart';
import 'package:star_hub/my_page/model/state.dart';

final myPageServiceProvider =
    StateNotifierProvider<DetailPostService, MyPageState>((ref) {
  final repository = ref.watch(myPageRepositoryProvider);
  return DetailPostService(repository);
});

class DetailPostService extends StateNotifier<MyPageState> {
  final MyPageRepository repository;

  DetailPostService(this.repository) : super(MyPageStateNone());

  Future<UserInfoEntity> getUserInfo(int postId) async {
    state = MyPageStateStateLoading();
    UserInfoEntity userInfo = await repository.getUserInfo();
    state = MyPageStateSuccess(userInfo);
    return userInfo;
  }
}
