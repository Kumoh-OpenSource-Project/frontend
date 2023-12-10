import 'package:json_annotation/json_annotation.dart';

part 'post_article_entity.g.dart';

@JsonSerializable()
class PostArticleEntity {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "photo")
  List<String> photo;

  PostArticleEntity({
    required this.content,
    required this.title,
    required this.type,
    required this.photo,
  });

  Map<String, dynamic> toJson() => _$PostArticleEntityToJson(this);

  factory PostArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$PostArticleEntityFromJson(json);
}
