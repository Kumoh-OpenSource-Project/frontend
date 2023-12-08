// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_best_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceBestEntity _$PlaceBestEntityFromJson(Map<String, dynamic> json) =>
    PlaceBestEntity(
      title: json['title'] as String,
      id: json['id'] as int,
      like: json['like'] as int,
    );

Map<String, dynamic> _$PlaceBestEntityToJson(PlaceBestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'like': instance.like,
    };
