import 'package:json_annotation/json_annotation.dart';
part 'full_post_entity.g.dart';

@JsonSerializable()
class FullPostEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "contentText")
  String content;
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
  @JsonKey(name: "photos")
  List<String> photos;
  @JsonKey(name: "isLike")
  bool isLike;
  @JsonKey(name: "isClipped")
  bool isClipped;

  FullPostEntity({
    required this.id,
    required this.title,
    required this.content,
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
    required this.writerId
  });
  Map<String, dynamic> toJson() => _$FullPostEntityToJson(this);

  factory FullPostEntity.fromJson(Map<String, dynamic> json) =>
      _$FullPostEntityFromJson(json);
}


