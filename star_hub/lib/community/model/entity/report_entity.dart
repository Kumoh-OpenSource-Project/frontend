import 'package:json_annotation/json_annotation.dart';

part 'report_entity.g.dart';

@JsonSerializable()
class ReportEntity {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "reportContent")
  String reportContent;

  ReportEntity({
    required this.type,
    required this.id,
    required this.reportContent,
  });

  Map<String, dynamic> toJson() => _$ReportEntityToJson(this);

  factory ReportEntity.fromJson(Map<String, dynamic> json) =>
      _$ReportEntityFromJson(json);
}
