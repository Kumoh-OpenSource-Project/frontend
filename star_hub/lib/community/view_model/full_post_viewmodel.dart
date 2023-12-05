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

  bool get scopeReset => scopePostService.isScopeReset;
  List<ScopeFullPostEntity> get scopeList => scopePostService.scopeList;

  List<PlaceFullPostEntity> get placeEntity => placePostService.placeEntity;

  List<PhotoFullPostEntity> get photoEntity => photoPostService.photoEntity;

 // List<ScopeFullPostEntity> scopeList = [];
  List<PlaceFullPostEntity> placeList = [];
  List<PhotoFullPostEntity> photoList = [];

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;

  PostViewModel(this.ref) {
    scopePostService = ref.read(scopePostServiceProvider);
    photoPostService = ref.read(photoPostServiceProvider);
    placePostService = ref.read(placePostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void getScopeReset() {
    //scopeList = [];
    isScopeReset = true;
    scopeState.withResponse(scopePostService.getFullScopePosts(0));
    //scopeList = scopePostService.scopeList;

  }

  void getPhotoReset() {
    isPhotoReset = true;
    photoList = [];
    photoState.withResponse(photoPostService.getFullPhotoPosts(0));
    photoList = photoPostService.photoList;
  }

  void getPlaceReset() {
    isPlaceReset = true;
    placeList = [];
    placeState.withResponse(placePostService.getFullPlacePosts(0));
    placeList = placePostService.placeList;
  }

  void makeNotRecentScope() {
    scopePostService.makeScopeNonReset();
  }

  void makeNotRecentPlace() {
    isPlaceReset = false;
  }

  void makeNotRecentPhoto() {
    isPhotoReset = false;
  }

  void refreshDataInt(int type) {
    switch (type) {
      case 0:
        isScopeReset = true;
        getScopeReset();
        break;
      case 1:
        isPlaceReset = true;
        getPlaceReset();
        break;
      case 2:
        isPhotoReset = true;
        getPhotoReset();
        break;
      default:
        getScopeReset();
        getPlaceReset();
        getPhotoReset();
        isScopeReset = true;
        isPlaceReset = true;
        isPhotoReset = true;
        break;
    }
  }

  // 새로 고침
  void refreshData(String? type, int page) {
    switch (type) {
      case "scope":
        getScopeReset();
        break;
      case "place":
        getPlaceReset();
        break;
      case "photo":
        getPhotoReset();
        break;
      default:
        getScopeReset();
        getPlaceReset();
        getPhotoReset();
        break;
    }
  }

  void postArticle(
      String type, String content, String title, List<String> photo,
      {ScopeCommunityState? scopeCommunityState,
      PlaceCommunityState? placeCommunityState,
      PhotoCommunityState? photoCommunityState}) {
    if (type == "scope") {
      scopeState.withResponse(scopePostService.postScopePost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));
    } else if (type == "place") {
      placeState.withResponse(placePostService.postPlacePost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));
    } else {
      photoState.withResponse(photoPostService.postPhotoPost(PostArticleEntity(
          content: content, title: title, type: type, photo: photo)));
    }
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
    if (type == "scope") {
      isScopeReset = false;
      hasNextScope = scopePostService.returnScopePage();
      if (page == 0) hasNextScope = true;
      if (page == 0) {
        scopeState.withResponse(scopePostService.getFullScopePosts(page));
   //     scopeList = scopePostService.scopeList;
      } else if (hasNextScope) {
        scopeState.withResponse(scopePostService.getFullScopePosts(page));
     //   scopeList = scopePostService.scopeList;
      }
      return false;
    } else if (type == "place") {
      isPlaceReset = false;
      hasNextPlace = placePostService.returnPlacePage();
      if (page == 0) hasNextPlace = true;
      if (page == 0) {
        placeState.withResponse(placePostService.getFullPlacePosts(page));
        placeList = placePostService.placeList;
      } else if (hasNextPlace) {
        placeState.withResponse(placePostService.getFullPlacePosts(page));
        placeList = placePostService.placeList;
      }
      return false;
    } else {
      isPhotoReset = false;
      hasNextPhoto = photoPostService.returnPhotoPage();
      if (page == 0) hasNextPhoto = true;
      if (page == 0) {
        photoState.withResponse(photoPostService.getFullPhotoPosts(page));
        photoList = photoPostService.photoList;
      } else if (hasNextPhoto) {
        photoState.withResponse(photoPostService.getFullPhotoPosts(page));
        photoList = photoPostService.photoList;
      }
      return false;
    }
  }
}
