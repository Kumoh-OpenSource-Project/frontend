import 'package:json_annotation/json_annotation.dart';

part 'photo_best_entity.g.dart';

@JsonSerializable()
class PhotoBestEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "like")
  int like;

  PhotoBestEntity({
    required this.title,
    required this.id,
    required this.like,
  });

  Map<String, dynamic> toJson() => _$PhotoBestEntityToJson(this);

  factory PhotoBestEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoBestEntityFromJson(json);
}
