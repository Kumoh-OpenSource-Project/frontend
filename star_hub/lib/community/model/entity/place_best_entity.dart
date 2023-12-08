import 'package:json_annotation/json_annotation.dart';

part 'place_best_entity.g.dart';

@JsonSerializable()
class PlaceBestEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "like")
  int like;

  PlaceBestEntity({
    required this.title,
    required this.id,
    required this.like,
  });

  Map<String, dynamic> toJson() => _$PlaceBestEntityToJson(this);

  factory PlaceBestEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceBestEntityFromJson(json);
}
