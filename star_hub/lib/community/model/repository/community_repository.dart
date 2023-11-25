import 'package:star_hub/community/model/entity/comment_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';

class CommunityRepository {
  List<CommentEntity> scopeCommentList = [
    CommentEntity(
        content: 'content',
        nickName: 'nickName',
        writeDate: 'writeDate',
        level: 'level'),
    CommentEntity(
        content: 'content',
        nickName: 'nickName',
        writeDate: 'writeDate',
        level: 'level'),
    CommentEntity(
        content: 'content',
        nickName: 'nickName',
        writeDate: 'writeDate',
        level: 'level'),
  ];

  List<ScopeFullPostEntity> scopePostList = [
    ScopeFullPostEntity(
        id: 1,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3),
    ScopeFullPostEntity(
        id: 2,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    ScopeFullPostEntity(
        id: 3,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopeFullPostEntity(
        id: 4,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    ScopeFullPostEntity(
        id: 5,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 1),
    ScopeFullPostEntity(
        id: 6,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "비석진",
        writeDate: "58분 전",
        level: "지구",
        likes: 10,
        clips: 5,
        comments: 7),
  ];
  List<PlaceFullPostEntity> placePostList = [
    PlaceFullPostEntity(
        id: 7,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    PlaceFullPostEntity(
        id: 8,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 8),
    PlaceFullPostEntity(
        id: 9,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    PlaceFullPostEntity(
        id: 10,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 7),
    PlaceFullPostEntity(
        id: 11,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 1),
    PlaceFullPostEntity(
        id: 12,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "비석진",
        writeDate: "58분 전",
        level: "지구",
        likes: 10,
        clips: 5,
        comments: 0),
  ];
  List<PhotoFullPostEntity> photoPostList = [
    PhotoFullPostEntity(
        id: 13,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 4),
    PhotoFullPostEntity(
        id: 14,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    PhotoFullPostEntity(
        id: 15,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 1),
    PhotoFullPostEntity(
        id: 16,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 4),
    PhotoFullPostEntity(
        id: 17,
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 2),
    PhotoFullPostEntity(
      id: 18,
      title: "가나다",
      content:
          "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
      photo: '',
      nickName: "비석진",
      writeDate: "58분 전",
      level: "지구",
      likes: 10,
      clips: 5,
      comments: 5,
    )
  ];

  Future<bool> deletePost(int postId) async {
    var postToDelete = scopePostList.firstWhere(
      (post) => post.id == postId,
    );

    if (postToDelete != null) {
      scopePostList.remove(postToDelete);
      print(scopePostList);
      return true;
    } else {
      return false;
    }
  }


  Future<List<ScopeFullPostEntity>> getFullScopePost() async {
    return scopePostList;
  }

  Future<List<PlaceFullPostEntity>> getFullPlacePost() async {
    return placePostList;
  }

  Future<List<PhotoFullPostEntity>> getFullPhotoPost() async {
    return photoPostList;
  }
}
