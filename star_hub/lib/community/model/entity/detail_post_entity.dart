import 'package:json_annotation/json_annotation.dart';
import 'package:star_hub/community/model/entity/comment_entity.dart';
part 'detail_post_entity.g.dart';

@JsonSerializable()
class DetailPostEntity {
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
  String content;
  @JsonKey(name: "date")
  String writeDate;
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
  @JsonKey(name: "comments")
  List<CommentEntity> comments;

  DetailPostEntity({
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
  Map<String, dynamic> toJson() => _$DetailPostEntityToJson(this);

  factory DetailPostEntity.fromJson(Map<String, dynamic> json) =>
      _$DetailPostEntityFromJson(json);
}


