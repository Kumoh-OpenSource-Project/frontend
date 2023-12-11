// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) =>
    CommentEntity(
      content: json['contextText'] as String,
      nickName: json['userNickName'] as String,
      writeDate: json['date'] as String,
      level: json['userLevel'] as String,
      id: json['id'] as int,
      userId: json['userId'] as int,
      userImage: json['userImage'] as String?,
    );

Map<String, dynamic> _$CommentEntityToJson(CommentEntity instance) =>
    <String, dynamic>{
      'contextText': instance.content,
      'userNickName': instance.nickName,
      'date': instance.writeDate,
      'userLevel': instance.level,
      'userImage': instance.userImage,
      'userId': instance.userId,
      'id': instance.id,
    };
