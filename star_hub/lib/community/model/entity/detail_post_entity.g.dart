// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailPostEntity _$DetailPostEntityFromJson(Map<String, dynamic> json) =>
    DetailPostEntity(
      id: json['id'] as int,
      writerId: json['writerId'] as int,
      title: json['title'] as String,
      content: json['contentText'] as String,
      photos: (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
      nickName: json['writerNickName'] as String,
      writeDate: json['date'] as String,
      level: json['writerLevel'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLike: json['isLike'] as bool,
      isClipped: json['isClipped'] as bool,
    );

Map<String, dynamic> _$DetailPostEntityToJson(DetailPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentText': instance.content,
      'writerNickName': instance.nickName,
      'writerId': instance.writerId,
      'date': instance.writeDate,
      'writerLevel': instance.level,
      'like': instance.likes,
      'clipped': instance.clips,
      'photo': instance.photos,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
      'comments': instance.comments,
    };
