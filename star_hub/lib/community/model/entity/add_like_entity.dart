import 'package:json_annotation/json_annotation.dart';
part 'add_like_entity.g.dart';

@JsonSerializable()
class AddLikeEntity {
  @JsonKey(name: "articleId")
  int articleId;

  AddLikeEntity({
    required this.articleId,
  });

  Map<String, dynamic> toJson() => _$AddLikeEntityToJson(this);

  factory AddLikeEntity.fromJson(Map<String, dynamic> json) =>
      _$AddLikeEntityFromJson(json);

}




