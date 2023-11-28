import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String userName;
  @JsonKey(name: "nickName")
  String nickName;
  @JsonKey(name: "profilePhoto")
  String? profilePhoto;
  @JsonKey(name: "kakaoId")
  String kakaoId;

  UserInfoEntity(
      {required this.id,
        required this.nickName,
        required this.kakaoId,
        required this.profilePhoto,
        required this.userName});

  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$UserInfoEntityFromJson(json);
}
