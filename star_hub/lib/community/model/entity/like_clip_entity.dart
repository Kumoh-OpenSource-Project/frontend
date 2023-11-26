import 'package:json_annotation/json_annotation.dart';
part 'like_clip_entity.g.dart';

@JsonSerializable()
class ToggledLikeClipEntity {
  @JsonKey(name: "articleId")
  int articleId;

  ToggledLikeClipEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$ToggledLikeClipEntityToJson(this);

  factory ToggledLikeClipEntity.fromJson(Map<String, dynamic> json) =>
      _$ToggledLikeClipEntityFromJson(json);

}