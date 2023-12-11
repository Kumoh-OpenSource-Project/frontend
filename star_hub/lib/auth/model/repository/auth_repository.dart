import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:star_hub/auth/model/dto/login_request_dto.dart';
import 'package:star_hub/common/dio.dart';

part 'auth_repository.g.dart';
final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
  //return CommunityRepositoryStub();
});
@RestApi()
abstract class AuthRepository {

  @GET("auth/login")
  Future<LoginRequestDto> login(@Header("Authorization") String token);

  factory AuthRepository(Dio dio, {String? baseUrl}) =
  _AuthRepository;

  @GET("user")
  Future<LoginRequestDto> getUser(@Header("Authorization") String token);
}
