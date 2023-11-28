import 'package:dio/src/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/community/model/entity/comment_entity.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/full_post_entity.dart';
import 'package:star_hub/community/model/entity/like_clip_entity.dart';
import 'package:star_hub/community/model/entity/photo_full_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_full_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/entity/post_article_entity.dart';
import 'package:star_hub/community/model/entity/scope_full_post_entity.dart';
import 'package:star_hub/community/model/entity/scope_post_entity.dart';
import 'package:star_hub/community/model/entity/update_article_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';

class CommunityRepositoryStub implements CommunityRepository{
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
  List<FullPostEntity> fullPostList = [
    FullPostEntity(
        id: 50,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 1),
    FullPostEntity(
        id: 51,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 2),
    FullPostEntity(
        id: 52,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 3),
    FullPostEntity(
        id: 53,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 4),
    FullPostEntity(
        id: 54,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 5),
    FullPostEntity(
        id: 55,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 6),
    FullPostEntity(
        id: 56,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 7),
    FullPostEntity(
        id: 57,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 8),
    FullPostEntity(
        id: 58,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 9),
    FullPostEntity(
        id: 59,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 10),
    FullPostEntity(
        id: 60,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 11),
    FullPostEntity(
        id: 61,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 12),
    FullPostEntity(
        id: 62,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 13),
    FullPostEntity(
        id: 63,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 14),
    FullPostEntity(
        id: 64,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 15),
    FullPostEntity(
        id: 65,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 16),
    FullPostEntity(
        id: 66,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 17),
    FullPostEntity(
        id: 67,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 18),
    FullPostEntity(
        id: 68,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 19),
    FullPostEntity(
        id: 69,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 20),
    FullPostEntity(
        id: 70,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 1,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 21),
    FullPostEntity(
        id: 22,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 1),
    FullPostEntity(
        id: 23,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 2),
    FullPostEntity(
        id: 24,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 3),
    FullPostEntity(
        id: 25,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 4),
    FullPostEntity(
        id: 26,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 5),
    FullPostEntity(
        id: 27,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 6),
    FullPostEntity(
        id: 28,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 7),
    FullPostEntity(
        id: 29,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 8),
    FullPostEntity(
        id: 30,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 9),
    FullPostEntity(
        id: 31,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 10),
    FullPostEntity(
        id: 32,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 11),
    FullPostEntity(
        id: 33,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 12),
    FullPostEntity(
        id: 34,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 13),
    FullPostEntity(
        id: 35,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 14),
    FullPostEntity(
        id: 36,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 15),
    FullPostEntity(
        id: 37,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 16),
    FullPostEntity(
        id: 38,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 17),
    FullPostEntity(
        id: 39,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 18),
    FullPostEntity(
        id: 40,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 19),
    FullPostEntity(
        id: 41,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 20),
    FullPostEntity(
        id: 42,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 2,
        isClipped: true,
        isLike: false,
        photos: [],
        writerId: 21),
    FullPostEntity(
        id: 1,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?moon",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 1),
    FullPostEntity(
        id: 2,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 2),
    FullPostEntity(
        id: 3,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: ["https://source.unsplash.com/random/?sky"],
        writerId: 3),
    FullPostEntity(
        id: 4,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?stars",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 4),
    FullPostEntity(
        id: 5,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?moon",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 5),
    FullPostEntity(
        id: 6,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?orb",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 6),
    FullPostEntity(
        id: 7,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 7),
    FullPostEntity(
        id: 8,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 8),
    FullPostEntity(
        id: 9,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 9),
    FullPostEntity(
        id: 10,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 10),
    FullPostEntity(
        id: 11,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 11),
    FullPostEntity(
        id: 12,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 12),
    FullPostEntity(
        id: 13,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 13),
    FullPostEntity(
        id: 14,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 14),
    FullPostEntity(
        id: 15,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 15),
    FullPostEntity(
        id: 16,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 16),
    FullPostEntity(
        id: 17,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 17),
    FullPostEntity(
        id: 18,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 18),
    FullPostEntity(
        id: 19,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 19),
    FullPostEntity(
        id: 20,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 20),
    FullPostEntity(
        id: 21,
        title: "가나다",
        content:
        "Row, Column 은 기본적으로 자식 요소들을 '나열'만 하기 때문에, mainAxisAlignment 설정 안하면 자식 요소들이 다닥다닥 붙어서 나온다. 그래서 Row, Column을 쓸때는 보통 mainAxisAlignment 속성을 꼭 설정하는 편이다.",
        nickName: "기석진",
        writeDate: "1분 전",
        level: "지구",
        likes: 5,
        clips: 5,
        comments: 3,
        categoryId: 3,
        isClipped: true,
        isLike: false,
        photos: [
          "https://source.unsplash.com/random/?star",
          "https://source.unsplash.com/random/?orb"
        ],
        writerId: 21),
  ];

  @override
  Future deletePost(DeleteArticleEntity entity) async {
    var postToDelete = fullPostList.firstWhere(
          (post) => post.id == entity.articleId,
    );

    if (postToDelete != null) {
      fullPostList.remove(postToDelete);
      print(fullPostList);
    } else {}
  }

  @override
  Future addLike(ToggledLikeClipEntity entity) async {
    var post = fullPostList.firstWhere(
          (post) => post.id == entity.articleId,
    );
    post.isLike = true;
  }

  @override
  Future cancelLike(ToggledLikeClipEntity entity) async {
    var post = fullPostList.firstWhere(
          (post) => post.id == entity.articleId,
    );
    post.isLike = false;
  }

  @override
  Future addClip(ToggledLikeClipEntity entity) async {
    var post = fullPostList.firstWhere(
          (post) => post.id == entity.articleId,
    );
    post.isClipped = true;
  }

  @override
  Future cancelClip(ToggledLikeClipEntity entity) async {
    var post = fullPostList.firstWhere(
          (post) => post.id == entity.articleId,
    );
    post.isClipped = false;
  }

  @override
  Future<List<FullPostEntity>> getFullScopePost(int offset) async {
    return fullPostList.where((post) => post.categoryId == 1).toList(); // scope
  }

  @override
  Future<List<FullPostEntity>> getFullPlacePost(int offset) async {
    return fullPostList.where((post) => post.categoryId == 2).toList(); // place
  }

  @override
  Future<List<FullPostEntity>> getFullPhotoPost(int offset) async {
    return fullPostList.where((post) => post.categoryId == 3).toList(); // photo
  }

  @override
  Future<DetailPostEntity> getDetailPost(int id) async {
    var detailPost = fullPostList.firstWhere(
          (post) => post.id == id,
    );
    return DetailPostEntity(
        id: detailPost.id,
        writerId: detailPost.writerId,
        title: detailPost.title,
        content: detailPost.content,
        photos: detailPost.photos,
        nickName: detailPost.nickName,
        writeDate: detailPost.writeDate,
        level: detailPost.level,
        likes: detailPost.likes,
        clips: detailPost.clips,
        comments: scopeCommentList,
        isLike: detailPost.isLike,
        isClipped: detailPost.isClipped);
  }

  @override
  Future postArticle(PostArticleEntity entity) async {

  }

  @override
  Future updateArticle(UpdateArticleEntity entity) async {

  }

  @override
  Future<List<FullPostEntity>> searchArticle(String words, int offset) {
    // TODO: implement searchArticle
    throw UnimplementedError();
  }

}
