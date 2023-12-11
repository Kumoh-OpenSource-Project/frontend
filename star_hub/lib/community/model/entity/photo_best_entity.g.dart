// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_best_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoBestEntity _$PhotoBestEntityFromJson(Map<String, dynamic> json) =>
    PhotoBestEntity(
      title: json['title'] as String,
      id: json['id'] as int,
      like: json['like'] as int,
    );

Map<String, dynamic> _$PhotoBestEntityToJson(PhotoBestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'like': instance.like,
    };
