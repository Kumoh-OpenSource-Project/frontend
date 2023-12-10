import 'package:json_annotation/json_annotation.dart';
part 'cancel_clip_entity.g.dart';

@JsonSerializable()
class CancelClipEntity {
  @JsonKey(name: "articleId")
  int articleId;

  CancelClipEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$CancelClipEntityToJson(this);

  factory CancelClipEntity.fromJson(Map<String, dynamic> json) =>
      _$CancelClipEntityFromJson(json);
}