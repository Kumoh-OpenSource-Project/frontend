// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WriteCommentEntity _$WriteCommentEntityFromJson(Map<String, dynamic> json) =>
    WriteCommentEntity(
      articleId: json['articleId'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$WriteCommentEntityToJson(WriteCommentEntity instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'content': instance.content,
    };
