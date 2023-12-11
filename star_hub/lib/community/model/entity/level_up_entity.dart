import 'package:json_annotation/json_annotation.dart';
part 'level_up_entity.g.dart';

@JsonSerializable()
class LevelUpEntity {
  @JsonKey(name: "userId")
  int id;
  @JsonKey(name: "userLevel")
  String level;
  @JsonKey(name: "isLevelUp")
  bool isLevelUp;

  LevelUpEntity({
    required this.level,
    required this.id,
    required this.isLevelUp,
  });

  Map<String, dynamic> toJson() => _$LevelUpEntityToJson(this);

  factory LevelUpEntity.fromJson(Map<String, dynamic> json) =>
      _$LevelUpEntityFromJson(json);
}
