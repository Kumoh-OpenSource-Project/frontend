import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


final BaseOptions options = BaseOptions(
  baseUrl: dotenv.get("BASE_URL"),
  contentType: "application/json",
);

final Dio dio = Dio(options);
