import 'package:json_annotation/json_annotation.dart';
part 'place_full_post_entity.g.dart';

@JsonSerializable()
class PlaceFullPostEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "contentText")
  String content;
  @JsonKey(name: "nickName")
  String nickName;
  @JsonKey(name: "writerId")
  int writerId;
  @JsonKey(name: "categoryId")
  int categoryId;
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "level")
  String level;
  @JsonKey(name: "like")
  int likes;
  @JsonKey(name: "clipped")
  int clips;
  @JsonKey(name: "comments")
  int comments;
  @JsonKey(name: "photos")
  List<String> photos;
  @JsonKey(name: "isLike")
  bool isLike;
  @JsonKey(name: "isClipped")
  bool isClipped;


  PlaceFullPostEntity({
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
  Map<String, dynamic> toJson() => _$PlaceFullPostEntityToJson(this);

  factory PlaceFullPostEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceFullPostEntityFromJson(json);
}


