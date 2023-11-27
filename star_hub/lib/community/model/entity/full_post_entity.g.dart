// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullPostEntity _$FullPostEntityFromJson(Map<String, dynamic> json) =>
    FullPostEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['contentText'] as String,
      nickName: json['writerNickName'] as String,
      writeDate: json['date'] as String,
      level: json['writerLevel'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: json['commentCount'] as int,
      categoryId: json['categoryId'] as int,
      isClipped: json['isClipped'] as bool,
      isLike: json['isLike'] as bool,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      writerId: json['writerId'] as int,
    );

Map<String, dynamic> _$FullPostEntityToJson(FullPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentText': instance.content,
      'writerNickName': instance.nickName,
      'writerId': instance.writerId,
      'categoryId': instance.categoryId,
      'date': instance.writeDate,
      'writerLevel': instance.level,
      'like': instance.likes,
      'clipped': instance.clips,
      'commentCount': instance.comments,
      'photos': instance.photos,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
    };
