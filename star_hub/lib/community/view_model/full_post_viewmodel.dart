import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/service/scope_service.dart';
import 'package:star_hub/community/model/service/photo_service.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';

final postViewModelProvider =
    ChangeNotifierProvider((ref) => PostViewModel(ref));

class PostViewModel extends ChangeNotifier {
  Ref ref;
  late CommunityState state;
  late CommunityState scopeState;
  late CommunityState placeState;
  late CommunityState photoState;

  List<FullPostEntity> get scopeEntity =>
      (scopeState as ScopeCommunityStateSuccess).data;

  List<FullPostEntity> get placeEntity =>
      (placeState as PlaceCommunityStateSuccess).data;

  List<FullPostEntity> get photoEntity =>
      (photoState as PhotoCommunityStateSuccess).data;

  PostViewModel(this.ref) {
    state = ref.read(detailPostServiceProvider);
    scopeState = ref.read(scopePostServiceProvider);
    placeState = ref.read(placePostServiceProvider);
    photoState = ref.read(photoPostServiceProvider);
    ref.listen(scopePostServiceProvider, (previous, next) {
      if (previous != next) {
        scopeState = next;
        notifyListeners();
      }
    });
    ref.listen(placePostServiceProvider, (previous, next) {
      if (previous != next) {
        placeState = next;
        notifyListeners();
      }
    });
    ref.listen(photoPostServiceProvider, (previous, next) {
      if (previous != next) {
        photoState = next;
        notifyListeners();
      }
    });
  }

  void navigateToDetailPage(BuildContext context, int postId) {
    ref.read(detailPostServiceProvider.notifier).getPosts(postId);
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage()));
  }
}
