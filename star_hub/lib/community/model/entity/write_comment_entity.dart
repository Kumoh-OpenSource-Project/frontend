import 'package:json_annotation/json_annotation.dart';
part 'write_comment_entity.g.dart';

@JsonSerializable()
class WriteCommentEntity {
  @JsonKey(name: "articleId")
  int articleId;

  @JsonKey(name: "content")
  String content;

  WriteCommentEntity({required this.articleId, required this.content});

  Map<String, dynamic> toJson() => _$WriteCommentEntityToJson(this);

  factory WriteCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$WriteCommentEntityFromJson(json);
}
