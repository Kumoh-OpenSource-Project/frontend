import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/view/screens/login_screen.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  // try {
  // LoginRequestDto loginResponse = await authRepository.getUser('Bearer ${token.accessToken}');
  // print("로그인 성공: ${loginResponse.toJson()}");
  // } catch (error) {
  // print("로그인 실패: $error");
  // }

  static String get routeName => 'myPage';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _logout(context, ref);
          },
          child: const Text('로그아웃'),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(localStorageProvider).deleteTokens();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
