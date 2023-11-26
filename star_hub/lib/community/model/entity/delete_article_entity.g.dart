// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteArticleEntity _$DeleteArticleEntityFromJson(Map<String, dynamic> json) =>
    DeleteArticleEntity(
      content: json['content'] as String,
      articleId: json['articleId'] as int,
    );

Map<String, dynamic> _$DeleteArticleEntityToJson(
        DeleteArticleEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'articleId': instance.articleId,
    };
