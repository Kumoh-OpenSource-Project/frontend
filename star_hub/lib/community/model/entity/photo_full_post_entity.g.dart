// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_full_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoFullPostEntity _$PhotoFullPostEntityFromJson(Map<String, dynamic> json) =>
    PhotoFullPostEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['contentText'] as String,
      nickName: json['nickName'] as String,
      writeDate: json['date'] as String,
      level: json['level'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: json['comments'] as int,
      categoryId: json['categoryId'] as int,
      isClipped: json['isClipped'] as bool,
      isLike: json['isLike'] as bool,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      writerId: json['writerId'] as int,
    );

Map<String, dynamic> _$PhotoFullPostEntityToJson(
        PhotoFullPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentText': instance.content,
      'nickName': instance.nickName,
      'writerId': instance.writerId,
      'categoryId': instance.categoryId,
      'date': instance.writeDate,
      'level': instance.level,
      'like': instance.likes,
      'clipped': instance.clips,
      'comments': instance.comments,
      'photos': instance.photos,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
    };
