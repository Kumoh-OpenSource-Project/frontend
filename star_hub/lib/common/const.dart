import 'package:dio/dio.dart';

final Dio dio = Dio(options);
final BaseOptions options = BaseOptions(
    baseUrl: "https://cc12-210-206-182-220.ngrok-free.app/",
    contentType: "application/json");

enum LoginPlatform {
  facebook,
  google,
  kakao,
  naver,
  apple,
  none, // logout
}
