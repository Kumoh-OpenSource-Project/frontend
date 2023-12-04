// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_likes_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyLikesEntity _$MyLikesEntityFromJson(Map<String, dynamic> json) =>
    MyLikesEntity(
      articleId: json['articleId'] as int,
      title: json['title'] as String,
      writeDate: json['writeDate'] as String,
      content: json['content'] as String,
      nickName: json['nickName'] as String,
    );

Map<String, dynamic> _$MyLikesEntityToJson(MyLikesEntity instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'title': instance.title,
      'content': instance.content,
      'writeDate': instance.writeDate,
      'nickName': instance.nickName,
    };
