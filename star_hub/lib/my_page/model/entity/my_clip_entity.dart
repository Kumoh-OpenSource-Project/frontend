import 'package:json_annotation/json_annotation.dart';

part 'my_clip_entity.g.dart';

@JsonSerializable()
class MyClipEntity {
  @JsonKey(name: "articleId")
  int articleId;
  @JsonKey(name: "category")
  int categoryId;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "writeDate")
  String writeDate;
  @JsonKey(name: "nickName")
  String nickName;

  MyClipEntity(
      {required this.categoryId,
      required this.articleId,
      required this.title,
      required this.writeDate,
      required this.content,
      required this.nickName});

  Map<String, dynamic> toJson() => _$MyClipEntityToJson(this);

  factory MyClipEntity.fromJson(Map<String, dynamic> json) =>
      _$MyClipEntityFromJson(json);
}
