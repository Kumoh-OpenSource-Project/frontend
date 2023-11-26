import 'package:json_annotation/json_annotation.dart';
part 'comment_entity.g.dart';

@JsonSerializable()
class CommentEntity {
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "nickName")
  String nickName;
  @JsonKey(name: "writeDate")
  String writeDate;
  @JsonKey(name: "level")
  String level;

  CommentEntity({
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.level,
  });

  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);

}