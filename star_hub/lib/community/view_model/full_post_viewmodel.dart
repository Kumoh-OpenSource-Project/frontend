import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/value_state_util.dart';
import 'package:star_hub/community/model/entity/level_up_entity.dart';
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

  ScopeCommunityState scopeState = ScopeCommunityState();
  PlaceCommunityState placeState = PlaceCommunityState();
  PhotoCommunityState photoState = PhotoCommunityState();

  bool get scopeReset => scopePostService.isScopeReset;

  bool get placeReset => placePostService.isPlaceReset;

  bool get photoReset => photoPostService.isPhotoReset;

  List<ScopeFullPostEntity> get scopeList => scopePostService.scopeList;

  List<PlaceFullPostEntity> get placeList => placePostService.placeList;

  List<PhotoFullPostEntity> get photoList => photoPostService.photoList;

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;

  late LevelUpEntity? levelUpEntity;
  String? level = null;

  PostViewModel(this.ref) {
    scopePostService = ref.read(scopePostServiceProvider);
    photoPostService = ref.read(photoPostServiceProvider);
    placePostService = ref.read(placePostServiceProvider);
    detailPostService = ref.read(detailPostServiceProvider);
  }

  void makeNotLevelUp(){
    if(scopePostService.levelUpEntity != null) scopePostService.levelUpEntity!.isLevelUp = false;
    if(placePostService.levelUpEntity != null) placePostService.levelUpEntity!.isLevelUp = false;
    if(photoPostService.levelUpEntity != null) photoPostService.levelUpEntity!.isLevelUp = false;
  }

  bool isLevelUp() {
    if (scopePostService.levelUpEntity != null) {
      level = scopePostService.levelUpEntity!.level;
      if (scopePostService.levelUpEntity!.isLevelUp) {
        print("level");
        print(level);
        print("level");

        return true;
      }
      print("level2");
      print(level);
      print("level2");
    }
    if (placePostService.levelUpEntity != null) {
      level = placePostService.levelUpEntity!.level;

      if (placePostService.levelUpEntity!.isLevelUp) {
        return true;
      }
    }
    if (photoPostService.levelUpEntity != null) {
      level = photoPostService.levelUpEntity!.level;

      if (photoPostService.levelUpEntity!.isLevelUp) {
        return true;
      }
    }
    return false;
  }

  void getScopeReset() {
    scopeState.withResponse(scopePostService.getFullScopePosts(0));
  }

  void getPhotoReset() {
    photoState.withResponse(photoPostService.getFullPhotoPosts(0));
  }

  void getPlaceReset() {
    placeState.withResponse(placePostService.getFullPlacePosts(0));
  }

  void makeNotRecentScope() {
    scopePostService.makeScopeNonReset();
  }

  void makeNotRecentPlace() {
    placePostService.makePlaceNonReset();
  }

  void makeNotRecentPhoto() {
    photoPostService.makePhotoNonReset();
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
      hasNextScope = scopePostService.returnScopePage();
      if (page == 0) hasNextScope = true;
      if (page == 0) {
        scopeState.withResponse(scopePostService.getFullScopePosts(page));
      } else if (hasNextScope) {
        scopeState.withResponse(scopePostService.getFullScopePosts(page));
      }
      return false;
    } else if (type == "place") {
      hasNextPlace = placePostService.returnPlacePage();
      if (page == 0) hasNextPlace = true;
      if (page == 0) {
        placeState.withResponse(placePostService.getFullPlacePosts(page));
      } else if (hasNextPlace) {
        placeState.withResponse(placePostService.getFullPlacePosts(page));
      }
      return false;
    } else if (type == "photo") {
      hasNextPhoto = photoPostService.returnPhotoPage();
      if (page == 0) hasNextPhoto = true;
      if (page == 0) {
        photoState.withResponse(photoPostService.getFullPhotoPosts(page));
      } else if (hasNextPhoto) {
        photoState.withResponse(photoPostService.getFullPhotoPosts(page));
      }
      return false;
    } else {
      return false;
    }
  }
}
