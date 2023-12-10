import 'package:json_annotation/json_annotation.dart';
import 'package:star_hub/community/model/entity/comment_entity.dart';
part 'place_post_entity.g.dart';

@JsonSerializable()
class PlacePostEntity {
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
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "level")
  String level;
  @JsonKey(name: "like")
  int likes;
  @JsonKey(name: "clipped")
  int clips;
  @JsonKey(name: "photos")
  List<String> photos;
  @JsonKey(name: "isLike")
  bool isLike;
  @JsonKey(name: "isClipped")
  bool isClipped;
  @JsonKey(name: "comments")
  List<CommentEntity> comments;

  PlacePostEntity({
    required this.id,
    required this.writerId,
    required this.title,
    required this.content,
    required this.photos,
    required this.nickName,
    required this.writeDate,
    required this.level,
    required this.likes,
    required this.clips,
    required this.comments,
    required this.isLike,
    required this.isClipped
  });
  Map<String, dynamic> toJson() => _$PlacePostEntityToJson(this);

  factory PlacePostEntity.fromJson(Map<String, dynamic> json) =>
      _$PlacePostEntityFromJson(json);
}


