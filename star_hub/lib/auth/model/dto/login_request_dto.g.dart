// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    LoginRequestDto(
      id: json['id'] as int,
      nickName: json['nickName'] as String,
      kakaoId: json['kakaoId'] as String,
      profilePhoto: json['profilePhoto'] as String?,
      userName: json['name'] as String,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(LoginRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.userName,
      'nickName': instance.nickName,
      'profilePhoto': instance.profilePhoto,
      'kakaoId': instance.kakaoId,
    };
