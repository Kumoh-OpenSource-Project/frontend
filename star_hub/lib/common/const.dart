import 'package:dio/dio.dart';

final Dio dio = Dio(options);
final BaseOptions options = BaseOptions(
    baseUrl: "https://302e-112-217-167-202.ngrok-free.app/",
    contentType: "application/json");

enum LoginPlatform {
  facebook,
  google,
  kakao,
  naver,
  apple,
  none, // logout
}
