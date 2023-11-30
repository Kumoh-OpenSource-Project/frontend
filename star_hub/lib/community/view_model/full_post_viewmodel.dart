import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
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

  int scopePage = 1;
  int placePage = 1;
  int photoPage = 1;

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;

  void resetPageInt(int? type) {
    switch (type) {
      case 0:
        scopePage = 0;
        break;
      case 1:
        placePage = 0;
        break;
      case 2:
        photoPage = 0;
        break;
      default:
        scopePage = 0;
        placePage = 0;
        photoPage = 0;
        break;
    }
  }

  void resetPage(String? type) {
    switch (type) {
      case "scope":
        scopePage = 0;
        break;
      case "place":
        placePage = 0;
        break;
      case "photo":
        photoPage = 0;
        break;
      default:
        scopePage = 0;
        placePage = 0;
        photoPage = 0;
        break;
    }
  }

  // List<ScopeFullPostEntity> scopeList = ref;
  // List<PlaceFullPostEntity> placeList = [];
  // List<PhotoFullPostEntity> photoList = [];
  List<ScopeFullPostEntity> get scopeList => getScopeList();

  // 조회
  List<ScopeFullPostEntity> get scopeEntity =>
      (scopeState as ScopeCommunityStateSuccess).data;

  List<PlaceFullPostEntity> get placeEntity =>
      (placeState as PlaceCommunityStateSuccess).data;

  List<PhotoFullPostEntity> get photoEntity =>
      (photoState as PhotoCommunityStateSuccess).data;

  PostViewModel(this.ref) {
    state = ref.read(detailPostServiceProvider);
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

  void refreshDataInt(int? type) {
    resetPageInt(type);
    switch (type) {
      case 0:
        ref.read(scopePostServiceProvider.notifier).getFullScopePosts(0);
        break;
      case 1:
        ref.read(placePostServiceProvider.notifier).getFullPlacePosts(0);
        break;
      case 2:
        ref.read(photoPostServiceProvider.notifier).getFullPhotoPosts(0);
        break;
      default:
        ref.read(scopePostServiceProvider.notifier).getFullScopePosts(0);
        ref.read(placePostServiceProvider.notifier).getFullPlacePosts(0);
        ref.read(photoPostServiceProvider.notifier).getFullPhotoPosts(0);
        break;
    }
  }

  // 새로 고침
  void refreshData(String? type) {
    hasNextScope = true;
    hasNextPhoto = true;
    hasNextPhoto = true;
    resetPage(type);
    switch (type) {
      case "scope":
        ref.read(scopePostServiceProvider.notifier).getFullScopePosts(0);

        break;
      case "place":
        ref.read(placePostServiceProvider.notifier).getFullPlacePosts(0);

        break;
      case "photo":
        ref.read(photoPostServiceProvider.notifier).getFullPhotoPosts(0);
        break;
      default:
        ref.read(scopePostServiceProvider.notifier).getFullScopePosts(0);
        ref.read(placePostServiceProvider.notifier).getFullPlacePosts(0);
        ref.read(photoPostServiceProvider.notifier).getFullPhotoPosts(0);
        break;
    }
  }

  // 상세 페이지로 이동
  void navigateToDetailPage(BuildContext context, int postId, int type) {
    ref.read(detailPostServiceProvider.notifier).getPosts(postId);
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage(type)));
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
    return ref.read(scopePostServiceProvider.notifier).scopeList;
  }

  bool getNextPage(String type) {
    if(scopePage == 0 ) hasNextScope = true;
    if (type == "scope" && hasNextScope == true && scopePage < 5) {

      ref
          .read(scopePostServiceProvider.notifier)
          .getFullScopePosts(scopePage)
          .then((data) {
        hasNextScope = data.isNotEmpty;
        if (data.isNotEmpty) {
          scopePage++;
        }
        return data;
      });
    } else if (type == "place" && hasNextPlace == true) {
      ref
          .read(placePostServiceProvider.notifier)
          .getFullPlacePosts(scopePage)
          .then((data) {
        hasNextScope = data.isNotEmpty;
        return data;
      });
    } else {
      ref
          .read(photoPostServiceProvider.notifier)
          .getFullPhotoPosts(scopePage)
          .then((data) {
        if (data.isEmpty && hasNextPhoto == true) {
          hasNextPhoto = false;
        } else {
          photoPage++; // Increment the page number for the next request
        }
        return false;
      });
    }
    return false;
  }
}
