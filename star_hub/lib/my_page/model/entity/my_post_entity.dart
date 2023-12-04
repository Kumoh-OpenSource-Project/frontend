import 'package:json_annotation/json_annotation.dart';
part 'my_post_entity.g.dart';

@JsonSerializable()
class MyPostEntity {
  @JsonKey(name: "articleId")
  int articleId;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "writeDate")
  String writeDate;
  @JsonKey(name: "likes")
  int likes;
  @JsonKey(name: "clips")
  int clips;

  MyPostEntity(
      {required this.articleId,
      required this.title,
      required this.writeDate,
      required this.clips,
      required this.content,
      required this.likes});

  Map<String, dynamic> toJson() => _$MyPostEntityToJson(this);

  factory MyPostEntity.fromJson(Map<String, dynamic> json) =>
      _$MyPostEntityFromJson(json);
}
