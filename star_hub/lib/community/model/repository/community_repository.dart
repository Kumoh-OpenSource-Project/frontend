import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';

class CommunityRepository {

  List<ScopePostEntity> scopePostList = [
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    ScopePostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "비석진",
        writeDate: "58분 전",
        level: "지구",
        likes: 10,
        clips: 5,
        comments: 2),
  ];
  List<PlacePostEntity> placePostList = [
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PlacePostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "비석진",
        writeDate: "58분 전",
        level: "지구",
        likes: 10,
        clips: 5,
        comments: 2),
  ];
  List<PhotoPostEntity> photoPostList = [
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PhotoPostEntity(
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        photo: '',
        nickName: "비석진",
        writeDate: "58분 전",
        level: "지구",
        likes: 10,
        clips: 5,
        comments: 2),
  ];

  Future<List<ScopePostEntity>> getFullScopePost() async {
    return scopePostList;
  }

  Future<List<PlacePostEntity>> getFullPlacePost() async {
    return placePostList;
  }

  Future<List<PhotoPostEntity>> getFullPhotoPost() async {
    return photoPostList;
  }
}
