// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPostEntity _$SearchPostEntityFromJson(Map<String, dynamic> json) =>
    SearchPostEntity(
      id: json['id'] as int,
      writerId: json['writerId'] as int,
      nickName: json['writerNickName'] as String,
      level: json['writerLevel'] as String,
      title: json['title'] as String,
      contentText: json['contextText'] as String,
      writeDate: json['date'] as String,
      comments: json['commentCount'] as int,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      isClipped: json['isClipped'] as bool,
      isLike: json['isLike'] as bool,
      photos: (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SearchPostEntityToJson(SearchPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'writerId': instance.writerId,
      'writerNickName': instance.nickName,
      'writerLevel': instance.level,
      'title': instance.title,
      'contextText': instance.contentText,
      'date': instance.writeDate,
      'commentCount': instance.comments,
      'like': instance.likes,
      'clipped': instance.clips,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
      'photo': instance.photos,
    };
