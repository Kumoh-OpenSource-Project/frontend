// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateArticleEntity _$UpdateArticleEntityFromJson(Map<String, dynamic> json) =>
    UpdateArticleEntity(
      content: json['content'] as String,
      articleId: json['articleId'] as int,
    );

Map<String, dynamic> _$UpdateArticleEntityToJson(
        UpdateArticleEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'articleId': instance.articleId,
    };
