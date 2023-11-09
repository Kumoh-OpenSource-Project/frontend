import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/FullPostEntity.dart';
import 'package:star_hub/community/model/community_service.dart';
import 'package:star_hub/community/model/state/state.dart';

final postViewModelProvider =
ChangeNotifierProvider((ref) => PostViewModel(ref));

class PostViewModel extends ChangeNotifier {
  Ref ref;
  late CommunityState state;

  List<PostEntity> get entity => (state as CommunityStateSuccess).data;

  PostViewModel(this.ref){
    state = ref.read(postServiceProvider);
    ref.listen(postServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}
