import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
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
  late final ScopePostService scopePostService;
  late final PlacePostService placePostService;
  late final PhotoPostService photoPostService;
  late final DetailPostService detailPostService;

  bool isScopeReset = false;
  bool isPlaceReset = false;
  bool isPhotoReset = false;

  ScopeCommunityState scopeState = ScopeCommunityState();
  PlaceCommunityState placeState = PlaceCommunityState();
  PhotoCommunityState photoState = PhotoCommunityState();

  List<ScopeFullPostEntity> get scopeEntity => scopePostService.scopeEntity;

  List<PlaceFullPostEntity> get placeEntity => placePostService.placeEntity;

  List<PhotoFullPostEntity> get photoEntity => photoPostService.photoEntity;

  List<ScopeFullPostEntity> get scopeList => scopePostService.scopeList;

  List<PlaceFullPostEntity> get placeList => placePostService.placeList;

  List<PhotoFullPostEntity> get photoList => photoPostService.photoList;

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;


  // List<ScopeFullPostEntity> scopeList = [];
  // List<PlaceFullPostEntity> placeList = [];
  // List<PhotoFullPostEntity> photoList = [];

  PostViewModel(this.ref) {
    scopePostService = ref.read(scopePostServiceProvider);
    photoPostService = ref.read(photoPostServiceProvider);
    placePostService = ref.read(placePostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void refreshDataInt(int type) {
    switch (type) {
      case 0:
        scopePostService.resetScopePage();
        break;
      case 1:
        placePostService.resetPlacePage();
        break;
      case 2:
        photoPostService.resetPhotoPage();
        break;
      default:
        scopePostService.resetScopePage();
        placePostService.resetPlacePage();
        photoPostService.resetPhotoPage();

        break;
    }
  }

  // 새로 고침
  void refreshData(String? type, int page) {
    switch (type) {
      case "scope":
        scopePostService.resetScopePage();

        isScopeReset = true;
        break;
      case "place":
        placePostService.resetPlacePage();

        isPlaceReset = true;
        break;
      case "photo":
        photoPostService.resetPhotoPage();

        isPhotoReset = true;
        break;
      default:
        scopePostService.resetScopePage();
        placePostService.resetPlacePage();
        photoPostService.resetPhotoPage();

        isScopeReset = true;
        isPlaceReset = true;
        isPhotoReset = true;
        break;
    }
  }

  // TODO: 혹시 디테일에서 새로고침된 상태를 가져올 수 있을까?
  // 상세 페이지로 이동
  void navigateToDetailPage(BuildContext context, int postId, int type, int writerId) {
    //detailPostService.getPosts(postId);
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(type, postId, writerId)));
  }

  void postArticle(
      String type, String content, String title, List<String> photo) {
    if (type == "scope") {
      scopeState.withResponse(scopePostService.postScopePost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));
      isScopeReset = true;
    } else if (type == "place") {
      placeState.withResponse(placePostService.postPlacePost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));

      isPlaceReset = true;
    } else {
      photoState.withResponse(photoPostService.postPhotoPost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));

      isPhotoReset = true;
    }
  }

  // List<ScopeFullPostEntity> getScopeList() {
  //   scopeList = scopePostService.scopeList;
  //   return scopeList;
  // }
  //
  // List<PlaceFullPostEntity> getPlaceList() {
  //   placeList = placePostService.placeList;
  //   return placeList;
  // }
  //
  // List<PhotoFullPostEntity> getPhotoList() {
  //   photoList = photoPostService.photoList;
  //   return photoList;
  // }

  List<ScopeFullPostEntity> getScopeEntity(String type) {
    return scopePostService.scopeEntity;
  }

  List<PlaceFullPostEntity> getPlaceEntity(String type) {
    return placePostService.placeEntity;
  }

  List<PhotoFullPostEntity> getPhotoEntity(String type) {
    return photoPostService.photoEntity;
  }

  bool getHasNext(String type) {
    bool hasNext;
    type == "scope"
        ? hasNext = scopePostService.hasNextScope
        : type == "place"
            ? hasNext = placePostService.hasNextPlace
            : hasNext = photoPostService.hasNextPhoto;
    return hasNext;
  }

  bool getNextPage(String type, int page) {
    isScopeReset = false;
    isPlaceReset = false;
    isPhotoReset = false;
    if (type == "scope") {

      hasNextScope = scopePostService.returnScopePage();
      if (page == 0) hasNextScope = true;
      if (hasNextScope) {
        scopeState.withResponse(scopePostService.getFullScopePosts(page));
        print(scopePostService.scopeList);
      }
      return false;
    } else if (type == "place") {

      hasNextPlace = placePostService.returnPlacePage();
      if (page == 0) hasNextPlace = true;
      if (hasNextPlace) {
        placeState.withResponse(placePostService.getFullPlacePosts(page));
      }
      return false;
    } else {
      hasNextPhoto = photoPostService.returnPhotoPage();
      if (page == 0) hasNextPhoto = true;
      if (hasNextPhoto) {
        photoState.withResponse(photoPostService.getFullPhotoPosts(page));
      }
      return false;
    }
  }
}
