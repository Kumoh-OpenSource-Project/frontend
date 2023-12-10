// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostArticleEntity _$PostArticleEntityFromJson(Map<String, dynamic> json) =>
    PostArticleEntity(
      content: json['content'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      photo: (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostArticleEntityToJson(PostArticleEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'photo': instance.photo,
    };
