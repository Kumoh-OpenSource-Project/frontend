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

  Future<String?> getAccessToken() async {
    final accessToken = await _storage.read(key: 'access_token');
    return accessToken;
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}

