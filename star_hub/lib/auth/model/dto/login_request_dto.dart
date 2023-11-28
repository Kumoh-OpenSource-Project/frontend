import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String userName;
  @JsonKey(name: "nickName")
  String nickName;
  @JsonKey(name: "profilePhoto")
  String profilePhoto;
  @JsonKey(name: "kakaoId")
  String kakaoId;

  LoginRequestDto(
      {required this.id,
      required this.nickName,
      required this.kakaoId,
      required this.profilePhoto,
      required this.userName});

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}
