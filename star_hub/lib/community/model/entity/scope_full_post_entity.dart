import 'package:json_annotation/json_annotation.dart';
import 'package:star_hub/community/model/entity/comment_entity.dart';

part 'scope_full_post_entity.g.dart';

@JsonSerializable()
class ScopeFullPostEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "contextText")
  String contentText;
  @JsonKey(name: "writerNickName")
  String nickName;
  @JsonKey(name: "writerId")
  int writerId;
  @JsonKey(name: "categoryId")
  int categoryId;
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "writerLevel")
  String level;
  @JsonKey(name: "like")
  int likes;
  @JsonKey(name: "clipped")
  int clips;
  @JsonKey(name: "commentCount")
  int comments;
  @JsonKey(name: "photo")
  List<String> photos;
  @JsonKey(name: "isLike")
  bool isLike;
  @JsonKey(name: "isClipped")
  bool isClipped;

  ScopeFullPostEntity(
      {required this.id,
      required this.title,
      required this.contentText,
      required this.nickName,
      required this.writeDate,
      required this.level,
      required this.likes,
      required this.clips,
      required this.comments,
      required this.categoryId,
      required this.isClipped,
      required this.isLike,
      required this.photos,
      required this.writerId});

  Map<String, dynamic> toJson() => _$ScopeFullPostEntityToJson(this);

  factory ScopeFullPostEntity.fromJson(Map<String, dynamic> json) =>
      _$ScopeFullPostEntityFromJson(json);

  ScopeFullPostEntity copyWith({
    int? clips,
    int? comments,
    String? contentText,
    int? likes,
    String? title,
    int? id,
    String? nickName,
    String? writeDate,
    String? level,
    int? categoryId,
    bool? isClipped,
    bool? isLike,
    List<String>? photos,
    int? writerId,
  }) {
    return ScopeFullPostEntity(
      clips: clips ?? this.clips,
      comments: comments ?? this.comments,
      contentText: contentText ?? this.contentText,
      likes: likes ?? this.likes,
      title: title ?? this.title,
      id: id?? this.id,
      nickName: nickName?? this.nickName,
      writeDate: writeDate?? this.writeDate,
      level: level?? this.level,
      categoryId: categoryId?? this.categoryId,
      isClipped: isClipped?? this.isClipped,
      isLike: isLike?? this.isLike,
      photos: photos?? this.photos,
      writerId: writerId?? this.writerId,
    );
  }
}
