import 'package:json_annotation/json_annotation.dart';
part 'comment_entity.g.dart';

@JsonSerializable()
class CommentEntity {
  @JsonKey(name: "contentText")
  String content;
  @JsonKey(name: "userNickName")
  String nickName;
  @JsonKey(name: "date")
  String writeDate;
  @JsonKey(name: "userLevel")
  String level;
  @JsonKey(name: "userId")
  int userId;
  @JsonKey(name: "id")
  int id;



  CommentEntity({
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.level,
    required this.id,
    required this.userId
  });

  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);

}