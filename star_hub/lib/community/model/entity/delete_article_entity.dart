import 'package:json_annotation/json_annotation.dart';
part 'delete_article_entity.g.dart';

@JsonSerializable()
class DeleteArticleEntity {
  @JsonKey(name: "articleId")
  int articleId;

  DeleteArticleEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$DeleteArticleEntityToJson(this);

  factory DeleteArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$DeleteArticleEntityFromJson(json);

}