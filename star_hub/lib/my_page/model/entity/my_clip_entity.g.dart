// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_clip_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyClipEntity _$MyClipEntityFromJson(Map<String, dynamic> json) => MyClipEntity(
      categoryId: json['category'] as int,
      articleId: json['articleId'] as int,
      title: json['title'] as String,
      writeDate: json['writeDate'] as String,
      content: json['content'] as String,
      nickName: json['nickName'] as String,
    );

Map<String, dynamic> _$MyClipEntityToJson(MyClipEntity instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'category': instance.categoryId,
      'title': instance.title,
      'content': instance.content,
      'writeDate': instance.writeDate,
      'nickName': instance.nickName,
    };
