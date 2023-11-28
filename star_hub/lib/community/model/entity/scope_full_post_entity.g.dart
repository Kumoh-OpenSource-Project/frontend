// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scope_full_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScopeFullPostEntity _$ScopeFullPostEntityFromJson(Map<String, dynamic> json) =>
    ScopeFullPostEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      contentText: json['contextText'] as String,
      nickName: json['writerNickName'] as String,
      writeDate: json['date'] as String,
      level: json['writerLevel'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: json['commentCount'] as int,
      categoryId: json['categoryId'] as int,
      isClipped: json['isClipped'] as bool,
      isLike: json['isLike'] as bool,
      photos: (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
      writerId: json['writerId'] as int,
    );

Map<String, dynamic> _$ScopeFullPostEntityToJson(
        ScopeFullPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contextText': instance.contentText,
      'writerNickName': instance.nickName,
      'writerId': instance.writerId,
      'categoryId': instance.categoryId,
      'date': instance.writeDate,
      'writerLevel': instance.level,
      'like': instance.likes,
      'clipped': instance.clips,
      'commentCount': instance.comments,
      'photo': instance.photos,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
    };
