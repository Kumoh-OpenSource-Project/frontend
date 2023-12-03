// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportEntity _$ReportEntityFromJson(Map<String, dynamic> json) => ReportEntity(
      type: json['type'] as String,
      id: json['id'] as int,
      reportContent: json['reportContent'] as String,
    );

Map<String, dynamic> _$ReportEntityToJson(ReportEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'reportContent': instance.reportContent,
    };
