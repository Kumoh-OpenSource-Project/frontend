import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:star_hub/auth/model/login_request_dto.dart';

part 'auth_repository.g.dart';

@RestApi(baseUrl: 'https://302e-112-217-167-202.ngrok-free.app/')
abstract class AuthRepository {

  @GET("/auth/login")
  Future<LoginRequestDto> login(@Header("Authorization") String token);

  factory AuthRepository(Dio dio, {String? baseUrl}) =
  _AuthRepository;

  @GET("/user")
  Future<LoginRequestDto> getUser(@Header("Authorization") String token);
}
