import 'package:json_annotation/json_annotation.dart';
part 'delete_comment_entity.g.dart';

@JsonSerializable()
class DeleteCommentEntity {
  @JsonKey(name: "commentId")
  int id;

  DeleteCommentEntity({
    required this.id,
  });

  Map<String, dynamic> toJson() => _$DeleteCommentEntityToJson(this);

  factory DeleteCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$DeleteCommentEntityFromJson(json);

}