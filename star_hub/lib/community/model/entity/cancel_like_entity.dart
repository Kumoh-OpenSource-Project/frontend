import 'package:json_annotation/json_annotation.dart';
part 'cancel_like_entity.g.dart';

@JsonSerializable()
class CancelLikeEntity {
  @JsonKey(name: "articleId")
  int articleId;

  CancelLikeEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$CancelLikeEntityToJson(this);

  factory CancelLikeEntity.fromJson(Map<String, dynamic> json) =>
      _$CancelLikeEntityFromJson(json);
}