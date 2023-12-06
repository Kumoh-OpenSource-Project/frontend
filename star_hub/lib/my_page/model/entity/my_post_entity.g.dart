// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPostEntity _$MyPostEntityFromJson(Map<String, dynamic> json) => MyPostEntity(
      articleId: json['articleId'] as int,
      title: json['title'] as String,
      writeDate: json['writeDate'] as String,
      clips: json['clips'] as int,
      content: json['content'] as String,
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$MyPostEntityToJson(MyPostEntity instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'title': instance.title,
      'content': instance.content,
      'writeDate': instance.writeDate,
      'likes': instance.likes,
      'clips': instance.clips,
    };
