import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/service/scope_service.dart';
import 'package:star_hub/community/model/service/photo_service.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/model/state/state.dart';

final detailPostViewModelProvider =
    ChangeNotifierProvider((ref) => DetailPostViewModel(ref));

class DetailPostViewModel extends ChangeNotifier {
  Ref ref;
  late CommunityState state;
  late CommunityState scopeState;
  late CommunityState placeState;
  late CommunityState photoState;

  DetailPostEntity get detailPostEntity =>
      (state as DetailPostStateSuccess).data;

  DetailPostViewModel(this.ref) {
    state = ref.read(detailPostServiceProvider);
    scopeState = ref.read(scopePostServiceProvider);
    placeState = ref.read(placePostServiceProvider);
    photoState = ref.read(photoPostServiceProvider);
    ref.listen(detailPostServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
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

  // 게시물 삭제
  void deletePost(int type, int articleId) {
    if (type == 1) {
      ref
          .read(scopePostServiceProvider.notifier)
          .deleteScopePost(DeleteArticleEntity(articleId: articleId));
    } else if (type == 2) {
      ref
          .read(placePostServiceProvider.notifier)
          .deletePlacePost(DeleteArticleEntity(articleId: articleId));
    } else {
      ref
          .read(photoPostServiceProvider.notifier)
          .deletePhotoPost(DeleteArticleEntity(articleId: articleId));
    }
  }

  // 게시물 수정
  void updatePost(int type, int articleId, String content) {
    if (type == 1) {
      ref.read(scopePostServiceProvider.notifier).updateScopePost(
          UpdateArticleEntity(content: content, articleId: articleId));
    } else if (type == 2) {
      ref.read(placePostServiceProvider.notifier).updatePlacePost(
          UpdateArticleEntity(content: content, articleId: articleId));
    } else {
      ref.read(photoPostServiceProvider.notifier).updatePhotoPost(
          UpdateArticleEntity(content: content, articleId: articleId));
    }
  }

  // 댓글 작성
  void writeComment(int articleId, String content) {
    ref
        .read(detailPostServiceProvider.notifier)
        .writeComment(articleId, content);
  }

  // 댓글 삭제
  void deleteComment(int articleId, int commentId) {
    ref
        .read(detailPostServiceProvider.notifier)
        .deleteComment(articleId, commentId);
  }

  // 댓글 수정
  void updateComment(int type, int articleId, String content) {}
}
