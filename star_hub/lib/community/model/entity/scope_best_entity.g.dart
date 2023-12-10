// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scope_best_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScopeBestEntity _$ScopeBestEntityFromJson(Map<String, dynamic> json) =>
    ScopeBestEntity(
      title: json['title'] as String,
      id: json['id'] as int,
      like: json['like'] as int,
    );

Map<String, dynamic> _$ScopeBestEntityToJson(ScopeBestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'like': instance.like,
    };
