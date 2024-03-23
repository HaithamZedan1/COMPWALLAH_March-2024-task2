import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/binding.dart';
import 'package:quiz/veiw/quizScreen.dart';
import 'package:quiz/veiw/resultScreen.dart';
import 'package:quiz/veiw/welcomScreen.dart';
import 'veiw/leaderScreen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
        GetPage(name: ResultScreen.routeName, page: () => ResultScreen()),
        GetPage(name: QuizScreen.routeName, page: () => QuizScreen()),
        GetPage(name: LeaderboardScreen.routeName, page: () => LeaderboardScreen()),
      ],
       home: WelcomeScreen(),// Starting screen
    );
  }
}
