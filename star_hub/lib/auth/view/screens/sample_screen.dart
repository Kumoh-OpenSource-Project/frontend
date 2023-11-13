import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:star_hub/common/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  Future<void> signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      if (response.statusCode == 200) {
        final profileInfo = json.decode(response.body);
        print(profileInfo.toString());

        setState(() {
          _loginPlatform = LoginPlatform.kakao;
        });
      } else {
        print('Error: ${response.statusCode}');
        // Handle error case
      }
    } catch (error) {
      print('Kakao login failed: $error');
      // Handle error case
    }
  }

  Future<void> signOut() async {
    switch (_loginPlatform) {
    // Handle sign-out for different platforms if needed
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      default:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual UI implementation
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: signInWithKakao,
          child: const Text('Sign In with Kakao'),
        ),
      ),
    );
  }
}
