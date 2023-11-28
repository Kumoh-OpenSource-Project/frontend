import 'package:flutter/material.dart';
import 'package:star_hub/auth/view/screens/login_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String userName = 'Nickname';
  final TextEditingController _nicknameController = TextEditingController();

  static String get routeName => 'myPage';

  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        'https://e1.pngegg.com/pngimages/249/454/png-clipart-frost-pro-for-os-x-icon-set-now-free-blank-white-circle-thumbnail.png';
    String userLevel = '수성';

    return Scaffold(
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          userLevel,
                          style: const TextStyle(
                            color: Colors.white,
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
                          color: Colors.white,
                          width: 1.5,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: const Text(
                                '닉네임 변경',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                _showNicknameDialog(context);
                              },
                            ),
                            const SizedBox(height: 15),
                            InkWell(
                              child: const Text(
                                '프로필 이미지 변경',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {},
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
                          color: Colors.white,
                          width: 1.5,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: const Text(
                                '내가 쓴 글',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 15),
                            InkWell(
                              child: const Text(
                                '좋아요한 글',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 15),
                            InkWell(
                              child: const Text(
                                '스크랩한 글',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {},
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
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  child: const Text(
                    '로그아웃',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void _showNicknameDialog(BuildContext context) {
    String newNickname = userName;

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
                    ))),
                onChanged: (value) {
                  setState(() {
                    newNickname = value;
                  });
                },
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
                  onPressed: () {
                    setState(() {
                      userName = newNickname;
                    });

                    print('New Nickname: $userName');
                    Navigator.of(context).pop();
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
}
