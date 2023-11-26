import 'package:json_annotation/json_annotation.dart';
part 'update_article_entity.g.dart';

@JsonSerializable()
class UpdateArticleEntity {
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "articleId")
  int articleId;

  UpdateArticleEntity({
    required this.content,
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$UpdateArticleEntityToJson(this);

  factory UpdateArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateArticleEntityFromJson(json);

}