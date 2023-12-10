import 'package:json_annotation/json_annotation.dart';
part 'request_image_s3_entity.g.dart';

@JsonSerializable()
class RequestImageS3Entity {
  @JsonKey(name: "imageUrl")
  int imageUrl;

  RequestImageS3Entity({
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => _$RequestImageS3EntityToJson(this);

  factory RequestImageS3Entity.fromJson(Map<String, dynamic> json) =>
      _$RequestImageS3EntityFromJson(json);

}