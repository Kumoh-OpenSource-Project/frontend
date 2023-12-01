import 'package:json_annotation/json_annotation.dart';

part 'search_post_entity.g.dart';

@JsonSerializable()
class SearchPostEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "writerId")
  int writerId;
  @JsonKey(name: "writerNickName")
  String nickName;
  @JsonKey(name: "writerLevel")
  String level;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "contextText")
  String contentText;
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "commentCount")
  int comments;
  @JsonKey(name: "like")
  int likes;
  @JsonKey(name: "clipped")
  int clips;
  @JsonKey(name: "isLike")
  bool isLike;
  @JsonKey(name: "isClipped")
  bool isClipped;
  @JsonKey(name: "photo")
  List<String> photos;

  SearchPostEntity({
    required this.id,
    required this.writerId,
    required this.nickName,
    required this.level,
    required this.title,
    required this.contentText,
    required this.writeDate,
    required this.comments,
    required this.likes,
    required this.clips,
    required this.isClipped,
    required this.isLike,
    required this.photos,
  });

  Map<String, dynamic> toJson() => _$SearchPostEntityToJson(this);

  factory SearchPostEntity.fromJson(Map<String, dynamic> json) =>
      _$SearchPostEntityFromJson(json);
}