import 'package:flutter/material.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';

import 'chat_ui/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Ui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryDark),
      ),
      home: Navigation(),
    );
  }
}
