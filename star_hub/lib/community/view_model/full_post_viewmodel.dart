import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
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
  late CommunityState scopeState;
  late CommunityState placeState;
  late CommunityState photoState;

  int scopePage = 1;
  int placePage = 1;
  int photoPage = 1;

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;

  List<ScopeFullPostEntity> scopeList = [];
  List<PlaceFullPostEntity> placeList = [];
  List<PhotoFullPostEntity> photoList = [];

  PostViewModel(this.ref) {
    scopeList = ref.read(scopePostServiceProvider.notifier).scopeList;
    placeList = ref.read(placePostServiceProvider.notifier).placeList;
    photoList = ref.read(photoPostServiceProvider.notifier).photoList;
    scopeState = ref.read(scopePostServiceProvider);
    placeState = ref.read(placePostServiceProvider);
    photoState = ref.read(photoPostServiceProvider);
    ref.listen(scopePostServiceProvider, (previous, next) {
      print('Scope State: $previous -> $next');
      if (previous != next) {
        scopeState = next;
        notifyListeners();
      }
    });
    ref.listen(placePostServiceProvider, (previous, next) {
      print('Place State: $previous -> $next');
      if (previous != next) {
        placeState = next;
        notifyListeners();
      }
    });
    ref.listen(photoPostServiceProvider, (previous, next) {
      print('Photo State: $previous -> $next');
      if (previous != next) {
        photoState = next;
        notifyListeners();
      }
    });
  }

  void refreshDataInt(int type) {
    switch (type) {
      case 0:
        ref.read(scopePostServiceProvider.notifier).resetScopePage();
        break;
      case 1:
        ref.read(placePostServiceProvider.notifier).resetPlacePage();
        break;
      case 2:
        ref.read(photoPostServiceProvider.notifier).resetPhotoPage();
        break;
      default:
        ref.read(scopePostServiceProvider.notifier).resetScopePage();
        ref.read(placePostServiceProvider.notifier).resetPlacePage();
        ref.read(photoPostServiceProvider.notifier).resetPhotoPage();
        break;
    }
  }

  // 새로 고침
  void refreshData(String? type) {
    // hasNextScope =
    //     ref.read(scopePostServiceProvider.notifier).returnScopePage();
    // hasNextPlace =
    //     ref.read(placePostServiceProvider.notifier).returnPlacePage();
    // hasNextPhoto =
    //     ref.read(photoPostServiceProvider.notifier).returnPhotoPage();
    switch (type) {
      case "scope":
        ref.read(scopePostServiceProvider.notifier).resetScopePage();
        break;
      case "place":
        ref.read(placePostServiceProvider.notifier).resetPlacePage();
        break;
      case "photo":
        ref.read(photoPostServiceProvider.notifier).resetPhotoPage();
        break;
      default:
        ref.read(scopePostServiceProvider.notifier).resetScopePage();
        ref.read(placePostServiceProvider.notifier).resetPlacePage();
        ref.read(photoPostServiceProvider.notifier).resetPhotoPage();
        break;
    }
  }

  //todo: 혹시 디테일에서 새로고침된 상태를 가져올 수 있을까?
  // 상세 페이지로 이동
  void navigateToDetailPage(BuildContext context, int postId, int type, int writerId) {
    ref.read(detailPostServiceProvider.notifier).getPosts(postId);
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(type, writerId)));
  }

  void postArticle(
      String type, String content, String title, List<String> photo) {
    if (type == "scope") {
      ref.read(scopePostServiceProvider.notifier).postScopePost(
          PostArticleEntity(
              content: content, title: title, type: type, photo: photo));
    } else if (type == "place") {
      ref.read(placePostServiceProvider.notifier).postPlacePost(
          PostArticleEntity(
              content: content, title: title, type: type, photo: photo));
    } else {
      ref.read(photoPostServiceProvider.notifier).postPhotoPost(
          PostArticleEntity(
              content: content, title: title, type: type, photo: photo));
    }
  }

  List<ScopeFullPostEntity> getScopeList() {
    return scopeList;
  }

  List<PlaceFullPostEntity> getPlaceList() {
    return placeList;
  }

  List<PhotoFullPostEntity> getPhotoList() {
    return photoList;
  }


  List<ScopeFullPostEntity> getScopeEntity(String type) {
    return ref.read(scopePostServiceProvider.notifier).scopeEntity;
  }

  List<PlaceFullPostEntity> getPlaceEntity(String type) {
    return ref.read(placePostServiceProvider.notifier).placeEntity;
  }

  List<PhotoFullPostEntity> getPhotoEntity(String type) {
    return ref.read(photoPostServiceProvider.notifier).photoEntity;
  }

  bool getHasNext(String type) {
    bool hasNext;
    type == "scope"
        ? hasNext = ref.read(scopePostServiceProvider.notifier).hasNextScope
        : type == "place"
            ? hasNext = ref.read(placePostServiceProvider.notifier).hasNextPlace
            : hasNext =
                ref.read(photoPostServiceProvider.notifier).hasNextPhoto;
    return hasNext;
  }

  bool getNextPage(String type) {
    if (type == "scope") {
      scopePage = ref.read(scopePostServiceProvider.notifier).scopePage;
      hasNextScope =
          ref.read(scopePostServiceProvider.notifier).returnScopePage();
      if (hasNextScope) {
        ref
            .read(scopePostServiceProvider.notifier)
            .getFullScopePosts(scopePage);
      }
      return false;
    } else if (type == "place") {
      placePage = ref.read(placePostServiceProvider.notifier).placePage;
      hasNextPlace =
          ref.read(placePostServiceProvider.notifier).returnPlacePage();
      if (hasNextPlace) {
        ref
            .read(placePostServiceProvider.notifier)
            .getFullPlacePosts(placePage);
      }
      return false;
    } else {
      photoPage = ref.read(photoPostServiceProvider.notifier).photoPage;
      hasNextPhoto =
          ref.read(photoPostServiceProvider.notifier).returnPhotoPage();
      if (hasNextPhoto) {
        ref
            .read(photoPostServiceProvider.notifier)
            .getFullPhotoPosts(photoPage);
      }
      return false;
    }
  }
}
