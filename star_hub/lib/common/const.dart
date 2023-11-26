import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio dio = Dio(options);
final BaseOptions options = BaseOptions(
  baseUrl: dotenv.get("BASE_URL"),
  contentType: "application/json",
);
