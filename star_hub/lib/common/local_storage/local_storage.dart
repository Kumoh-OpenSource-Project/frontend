import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final localStorageProvider = Provider((ref) => LocalStorage());

class LocalStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String? refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: 'refresh_token', value: refreshToken);
    }
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }

  Future<String?> getUserId() async {
    final userId = await _storage.read(key: 'user_id');
    //Todo: 고쳐요

    return '23';
    //return '3180030559';
  }

  Future<String?> getAccessToken() async {
    final accessToken = await _storage.read(key: 'access_token');
    // print("현 토큰");
    // print(accessToken);
    //return accessToken;
    //todo: 고쳐요
    return "YDe0myKMrm8kMmOs9Qq1nEeE7TmFKXqVH2QKPXWbAAABjFBAbL7OkqTnJF629A";
    //return "qhtaoPKUS4R5aLO9RfElyq63ctK5rf0cyGgKPXUbAAABjDIj7drOkqTnJF629A";
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
