// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPostEntity _$MyPostEntityFromJson(Map<String, dynamic> json) => MyPostEntity(
      articleId: json['id'] as int,
      categoryId: json['categoryId'] as int,
      writerId: json['writerId'] as int,
      title: json['title'] as String,
      writeDate: json['date'] as String,
      clips: json['clipped'] as int,
      content: json['contextText'] as String,
      likes: json['like'] as int,
    );

Map<String, dynamic> _$MyPostEntityToJson(MyPostEntity instance) =>
    <String, dynamic>{
      'id': instance.articleId,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'writerId': instance.writerId,
      'contextText': instance.content,
      'date': instance.writeDate,
      'like': instance.likes,
      'clipped': instance.clips,
    };
