// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailPostEntity _$DetailPostEntityFromJson(Map<String, dynamic> json) =>
    DetailPostEntity(
      id: json['id'] as int,
      writerId: json['writerId'] as int,
      title: json['title'] as String,
      content: json['contextText'] as String,
      photos: (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
      nickName: json['writerNickName'] as String,
      writeDate: json['date'] as String,
      level: json['writerLevel'] as String,
      writerImage: json['writerImage'] as String,
      likes: json['like'] as int,
      clips: json['clipped'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLike: json['isLike'] as bool,
      isClipped: json['isClipped'] as bool,
    );

Map<String, dynamic> _$DetailPostEntityToJson(DetailPostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'writerId': instance.writerId,
      'writerNickName': instance.nickName,
      'writerLevel': instance.level,
      'writerImage': instance.writerImage,
      'title': instance.title,
      'contextText': instance.content,
      'date': instance.writeDate,
      'like': instance.likes,
      'clipped': instance.clips,
      'isLike': instance.isLike,
      'isClipped': instance.isClipped,
      'photo': instance.photos,
      'comments': instance.comments,
    };
