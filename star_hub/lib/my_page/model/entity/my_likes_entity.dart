import 'package:json_annotation/json_annotation.dart';

part 'my_likes_entity.g.dart';

@JsonSerializable()
class MyLikesEntity {
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

  MyLikesEntity(
      {required this.categoryId,
      required this.articleId,
      required this.title,
      required this.writeDate,
      required this.content,
      required this.nickName});

  Map<String, dynamic> toJson() => _$MyLikesEntityToJson(this);

  factory MyLikesEntity.fromJson(Map<String, dynamic> json) =>
      _$MyLikesEntityFromJson(json);
}
