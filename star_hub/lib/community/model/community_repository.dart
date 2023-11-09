import 'package:star_hub/community/FullPostEntity.dart';

class CommunityRepository {
  List<PostEntity> list = [
    PostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "니석진",
        writeDate: "10분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "디석진",
        writeDate: "21분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "리석진",
        writeDate: "30분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PostEntity(
        title: "가나다",
        content:
            "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "미석진",
        writeDate: "47분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 5),
    PostEntity(
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

  CommunityRepository();

  Future<List<PostEntity>> getFullPost(int type) async {
    return list;
  }
}
