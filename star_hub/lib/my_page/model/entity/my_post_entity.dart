import 'package:json_annotation/json_annotation.dart';

part 'my_post_entity.g.dart';

@JsonSerializable()
class MyPostEntity {
  @JsonKey(name: "id")
  int articleId;
  @JsonKey(name: "categoryId")
  int categoryId;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "writerId")
  int writerId;
  @JsonKey(name: "contextText")
  String content;
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "like")
  int likes;
  @JsonKey(name: "clipped")
  int clips;

  MyPostEntity(
      {required this.articleId,
      required this.categoryId,
      required this.writerId,
      required this.title,
      required this.writeDate,
      required this.clips,
      required this.content,
      required this.likes});

  Map<String, dynamic> toJson() => _$MyPostEntityToJson(this);

  factory MyPostEntity.fromJson(Map<String, dynamic> json) =>
      _$MyPostEntityFromJson(json);
}
