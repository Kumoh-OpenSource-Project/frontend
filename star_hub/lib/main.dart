import 'package:flutter/material.dart';
import 'package:star_hub/home/view/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colozrs.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
