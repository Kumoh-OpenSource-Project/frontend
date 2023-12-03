import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_hub/common/local_storage/local_storage.dart';

import '../entity/report_entity.dart';

class ReportService {
  static const String baseUrl =
      'http://ec2-3-39-84-165.ap-northeast-2.compute.amazonaws.com:3000';

  Future<Map<String, String>> _createHeaders() async {
    String? token = await LocalStorage().getAccessToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> report(ReportEntity reportEntity) async {
    const url = '$baseUrl/report';
    final headers = await _createHeaders();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(reportEntity.toJson()),
    );

    if (response.statusCode == 201) {
      print('Report submitted successfully.');
    } else {
      print('Failed to submit report. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
