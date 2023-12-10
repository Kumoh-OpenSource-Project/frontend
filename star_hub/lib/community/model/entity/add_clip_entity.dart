import 'package:json_annotation/json_annotation.dart';
part 'add_clip_entity.g.dart';

@JsonSerializable()
class AddClipEntity {
  @JsonKey(name: "articleId")
  int articleId;

  AddClipEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$AddClipEntityToJson(this);

  factory AddClipEntity.fromJson(Map<String, dynamic> json) =>
      _$AddClipEntityFromJson(json);

}