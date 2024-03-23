
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/model/sqflite.dart';
import 'package:quiz/veiw/resultScreen.dart';
import 'package:quiz/veiw/welcomScreen.dart';

class QuestionController extends GetxController {
  String name = '';
  bool _isPressed = false;

  bool get isPressed => _isPressed;
  double _numberOfQuestion = 1;
  int? _selectedAnswer;
  int _countOfCorrectAnswer = 0;
  final RxInt _sec = 15.obs;

  Future<void> addToLeaderboard(String name, int score) async {
    final url = 'http://dreamlo.com/lb/d1728Wan_kOcT9-zYej6ZQ33R8nuHackGjTi0WcpgNvA/add/$name/$score';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Score added to leaderboard successfully.');
      } else {
        print('Failed to add score to leaderboard. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding score to leaderboard: $e');
    }
  }



  SqlDb db = SqlDb();
  late List<Map<String, dynamic>> _questionList;

  Future<void> initializeQuestions() async {
    _questionList = await db.readData('SELECT * FROM quiz');

    // Clear the map before filling it again
    __questionIsAnswered.clear();

    // Fill the map with question IDs as keys and false as values
    for (var element in _questionList) {
      __questionIsAnswered[element['id']] = false;
    }

    update();
  }


  List<Map<String, dynamic>> get questionList => [..._questionList];

  int get countOfQuestion => _questionList.length;

  double get numberOfQuestion => _numberOfQuestion;

  int? get selectedAnswer => _selectedAnswer;

  int get countOfCorrectAnswer => _countOfCorrectAnswer;

  RxInt get sec => _sec;

  int? _correctAnswer;

  final Map<int, bool> __questionIsAnswered = {};

  Timer? _timer;

  final maxSec = 15;

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);

    initializeQuestions().then((_) {
      resetAnswer();
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return countOfCorrectAnswer * 100 / _questionList.length;
  }

  void resetAnswer() {
    for (var element in _questionList) {
      __questionIsAnswered.addAll({element['id']: false});
    }
    update();
  }


  Color getColor(int answerIndex) {
    if (_isPressed) {
      if(answerIndex == _correctAnswer!-3){
        return Colors.green;
      }
      else if (answerIndex == _selectedAnswer!-3 && _correctAnswer != _selectedAnswer){
        return Colors.red;
      }
    }
    return Colors.white;
  }

  void checkAnswer(int correctAnswer, int selectedAnswer, int id) {
    print('ID received in checkAnswer: $id');
    print('__questionIsAnswered keys: ${__questionIsAnswered.keys}');
    _isPressed = true;
    _selectedAnswer = selectedAnswer;
    _correctAnswer = correctAnswer;
    if (_correctAnswer == _selectedAnswer) {
      _countOfCorrectAnswer++;
    }
    stopTimer();

    // Check if the key exists in the map before updating its value
    if (__questionIsAnswered.containsKey(id)) {
      __questionIsAnswered[id] = true;
    } else {
      print('Error: Key $id not found in __questionIsAnswered map.');
      // Handle this error according to your application logic
    }

    Future.delayed(Duration(milliseconds: 500)).then((value) => newQuestion());
    update();
  }




  bool checkIsQuestionAnswered(int quesID) {
    return __questionIsAnswered.entries.firstWhere((element) => element.key == quesID).value;
  }

  void newQuestion() {
    if(_timer!=null || _timer!.isActive){
      stopTimer();
    }
    if(pageController.page==_questionList.length-1)
      {
        Get.offAndToNamed(ResultScreen.routeName);
      }
    else
      {
        _isPressed=false;
        pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
        _numberOfQuestion = pageController.page! + 2;
        startTimer();
      }

    update();
  }

  void stopTimer() => _timer?.cancel();

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_sec.value>0)
        {
          _sec.value--;
        }
      else{
        stopTimer();
        newQuestion();
      }
    });
  }

  void resetTimer() => _sec.value=maxSec;

  void startAgain() {
    _correctAnswer = 0;
    _countOfCorrectAnswer = 0;
    _selectedAnswer = 0;
    _numberOfQuestion = 1;
    resetAnswer();
    Get.offAndToNamed(WelcomeScreen.routeName);
    update();
  }
}

