// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePostEntity _$PlacePostEntityFromJson(Map<String, dynamic> json) =>
    PlacePostEntity(
      id: json['id'] as int,
      writerId: json['writerId'] as int,
      title: json['title'] as String,
      content: json['contentText'] as String,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      nickName: json['nickName'] as String,
      writeDate: json['date'] as String,
      level: json['level'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLike: json['isLike'] as bool,
      isClipped: json['isClipped'] as bool,
    );

Map<String, dynamic> _$PlacePostEntityToJson(PlacePostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentText': instance.content,
      'nickName': instance.nickName,
      'writerId': instance.writerId,
      'date': instance.writeDate,
      'level': instance.level,
      'like': instance.likes,
      'clipped': instance.clips,
      'photos': instance.photos,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
      'comments': instance.comments,
    };
