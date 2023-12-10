// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_up_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelUpEntity _$LevelUpEntityFromJson(Map<String, dynamic> json) =>
    LevelUpEntity(
      level: json['userLevel'] as String,
      id: json['userId'] as int,
      isLevelUp: json['isLevelUp'] as bool,
    );

Map<String, dynamic> _$LevelUpEntityToJson(LevelUpEntity instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'userLevel': instance.level,
      'isLevelUp': instance.isLevelUp,
    };
