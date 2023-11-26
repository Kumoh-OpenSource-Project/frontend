// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) =>
    CommentEntity(
      content: json['content'] as String,
      nickName: json['nickName'] as String,
      writeDate: json['writeDate'] as String,
      level: json['level'] as String,
    );

Map<String, dynamic> _$CommentEntityToJson(CommentEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'nickName': instance.nickName,
      'writeDate': instance.writeDate,
      'level': instance.level,
    };
