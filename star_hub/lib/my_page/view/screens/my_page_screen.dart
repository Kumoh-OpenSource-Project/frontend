import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/auth/view/screens/login_screen.dart';
import 'package:star_hub/common/pages/loading_page.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/model/service/photo_service.dart';
import 'package:star_hub/community/model/service/place_service.dart';
import 'package:star_hub/community/model/service/scope_service.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:star_hub/my_page/model/state.dart';
import 'package:star_hub/my_page/view/screens/my_likes_screen.dart';
import 'package:star_hub/my_page/view/screens/my_scraps_screen.dart';
import 'package:star_hub/my_page/view_model/my_page_viewmodel.dart';

import '../../../common/local_storage/local_storage.dart';
import 'my_posts_screen.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen> {
  String userName = '';
  String profileImageUrl =
      'http://res.cloudinary.com/dnbf7czsn/image/upload/v1702310928/pluto-197_g74xnv.png';
  final TextEditingController _nicknameController = TextEditingController();
  late bool isLevelUp;
  String? level = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(myPageViewModelProvider);
    if (viewmodel.state is MyPageStateSuccess) level = viewmodel.entity.level;
    if (ref.read(postViewModelProvider).level != null && level != null) {
      if (level != ref.read(postViewModelProvider).level) {
        level = ref.read(postViewModelProvider).level;
        print("마이페이지 레벨업");
      }
      print("레벨업은 안함");
    } else {
      print("마이페이지 레벨업ㄴㄴ");
      print(level);
      print(ref.read(postViewModelProvider).level);
    }
    Color getBorderColor(String level) {
      switch (level) {
        case '수성':
          return Colors.grey;
        case '금성':
          return Colors.yellow;
        case '지구':
          return Colors.green;
        case '화성':
          return Colors.orange;
        case '목성':
          return Colors.brown;
        case '토성':
          return Colors.brown.shade200;
        case '천왕성':
          return Colors.blueAccent;
        case '해왕성':
          return Colors.lightBlueAccent;
        case '태양':
          return Colors.red;
        case '블랙홀':
          return Colors.deepPurple.shade900;
        default:
          return Colors.white;
      }
    }

    return viewmodel.state is MyPageStateSuccess
        ? Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: (level ?? viewmodel.entity.level) == '대은하'
                                  ? null
                                  : Border.all(
                                      color: getBorderColor(
                                          (level ?? viewmodel.entity.level)),
                                      width: 4.0,
                                    ),
                              gradient:
                                  (level ?? viewmodel.entity.level) == '대은하'
                                      ? const LinearGradient(
                                          colors: [
                                            Colors.red,
                                            Colors.orange,
                                            Colors.yellow,
                                            Colors.green,
                                            Colors.blue,
                                            Colors.indigo,
                                            Colors.purple,
                                          ],
                                        )
                                      : null,
                            ),
                            child: Padding(
                              padding:
                                  (level ?? viewmodel.entity.level) == '대은하'
                                      ? const EdgeInsets.all(4.0)
                                      : const EdgeInsets.all(0.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  viewmodel.entity.profilePhoto
                                              ?.startsWith('https') ==
                                          true
                                      ? viewmodel.entity.profilePhoto.toString()
                                      : profileImageUrl,
                                ),
                                radius: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                viewmodel.entity.nickName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                level ?? viewmodel.entity.level,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.person, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                '계정 정보 변경',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: const Text(
                                              '닉네임 변경',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      _showNicknameDialog(context, viewmodel);
                                    },
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: const Text(
                                              '프로필 이미지 변경',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      final url = await _selectProfileImage();
                                      final success = await _updateProfileImage(
                                          url, viewmodel);
                                      if (success) {
                                        setState(() {
                                          profileImageUrl = url;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.my_library_books_rounded,
                                  color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                '커뮤니티 활동 조회',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '내가 쓴 글',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              MyPostsPage(
                                                  viewmodel.entity.nickName),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.easeInOut;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            return SlideTransition(
                                                position: offsetAnimation,
                                                child: child);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '좋아요한 글',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const MyLikesPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.easeInOut;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            return SlideTransition(
                                                position: offsetAnimation,
                                                child: child);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '스크랩한 글',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const MyScrapsPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.easeInOut;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            return SlideTransition(
                                                position: offsetAnimation,
                                                child: child);
                                          },
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _logout(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent),
                        child: Text(
                          '로그아웃',
                          style: kTextContentStyleMiddle.copyWith(
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
  }

  Future<void> _logout(BuildContext context) async {
    final localStorage = LocalStorage();
    localStorage.deleteTokens();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SplashScreen()));
  }

  Future<String> _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final url = _uploadImageToS3(File(pickedFile.path));
      print('Selected image path: ${pickedFile.hashCode}');
      return url;
    } else {
      print('No image selected.');
      return '';
    }
  }

  Future<String> _uploadImageToS3(File imageFile) async {
    final url =
        'https://starhubimage.s3.ap-northeast-2.amazonaws.com/userImage/${imageFile.hashCode}';

    List<int> imageBytes = await imageFile.readAsBytes();

    final request = http.Request('PUT', Uri.parse(url))
      ..headers['Content-Type'] = 'image/jpeg'
      ..bodyBytes = imageBytes;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print(url);
        return url;
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  void _showNicknameDialog(BuildContext context, MyPageViewModel viewModel) {
    String newNickname = userName;
    final localStorage = LocalStorage();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text('닉네임 변경'),
              content: TextField(
                cursorColor: Colors.white,
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: '새로운 닉네임을 입력하세요',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    newNickname = value;
                  });
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final success =
                        await _updateNickname(newNickname, viewModel);

                    if (success) {
                      setState(() {
                        userName = newNickname;
                      });

                      print('New Nickname: $userName');
                      Navigator.of(context).pop();
                    } else {
                      print('Failed to update nickname');
                    }
                  },
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool> _updateProfileImage(
      String newProfileImage, MyPageViewModel viewModel) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getAccessToken();

      final response = await http.patch(
        Uri.parse(
            'http://ec2-3-39-84-165.ap-northeast-2.compute.amazonaws.com:3000/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userImage': newProfileImage}),
      );

      if (response.statusCode == 200) {
        setState(() {
          profileImageUrl = newProfileImage;
          viewModel.getUserInfo();
        });
        return true;
      } else {
        print('Failed to update nickname. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during nickname update: $e');
      return false;
    }
  }

  Future<bool> _updateNickname(
      String newNickname, MyPageViewModel viewModel) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getAccessToken();

      final response = await http.patch(
        Uri.parse(
            'http://ec2-3-39-84-165.ap-northeast-2.compute.amazonaws.com:3000/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userNickName': newNickname}),
      );

      if (response.statusCode == 200) {
        setState(() {
          userName = newNickname;
          viewModel.getUserInfo();
        });
        return true;
      } else {
        print('Failed to update nickname. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during nickname update: $e');
      return false;
    }
  }
}
