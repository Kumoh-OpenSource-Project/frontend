import 'package:json_annotation/json_annotation.dart';

part 'scope_best_entity.g.dart';

@JsonSerializable()
class ScopeBestEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "like")
  int like;

  ScopeBestEntity({
    required this.title,
    required this.id,
    required this.like,
  });

  Map<String, dynamic> toJson() => _$ScopeBestEntityToJson(this);

  factory ScopeBestEntity.fromJson(Map<String, dynamic> json) =>
      _$ScopeBestEntityFromJson(json);
}
