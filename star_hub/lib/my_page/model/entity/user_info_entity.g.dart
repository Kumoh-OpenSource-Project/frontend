// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoEntity _$UserInfoEntityFromJson(Map<String, dynamic> json) =>
    UserInfoEntity(
      id: json['id'] as int,
      nickName: json['nickName'] as String,
      kakaoId: json['kakaoId'] as String,
      profilePhoto: json['profilePhoto'] as String?,
      userName: json['name'] as String,
      level: json['level'] as String,
    );

Map<String, dynamic> _$UserInfoEntityToJson(UserInfoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.userName,
      'nickName': instance.nickName,
      'profilePhoto': instance.profilePhoto,
      'kakaoId': instance.kakaoId,
    };
