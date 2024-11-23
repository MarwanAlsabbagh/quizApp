import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/question_model.dart';
import '../screens/result_screen.dart';
import '../screens/welcome_screen.dart';

class QuizController extends GetxController {
  String name = '';

  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question: "What is Flutter?",
      answer: 1,
      options: [
        'A framework for building cross-platform apps',
        'A programming language',
        'An operating system',
        'A database management system'
      ],
    ),
    QuestionModel(
      id: 2,
      question: "Which programming language is used in Flutter?",
      answer: 2,
      options: ['Java', 'Dart', 'Python', 'Kotlin'],
    ),
    QuestionModel(
      id: 3,
      question: "What is a Widget in Flutter?",
      answer: 3,
      options: [
        'A database entity',
        'A backend service',
        'A building block for UI',
        'A type of network request'
      ],
    ),
    QuestionModel(
      id: 4,
      question: "Which widget is used for unbounded scrolling in Flutter?",
      answer: 1,
      options: ['ListView', 'Column', 'Row', 'Stack'],
    ),
    QuestionModel(
      id: 5,
      question: "What is the function of the `setState` method in Flutter?",
      answer: 2,
      options: [
        'To initialize a widget',
        'To update the state and refresh the UI',
        'To make a network request',
        'To debug the application'
      ],
    ),
    QuestionModel(
      id: 6,
      question: "Which widget is used to create a clickable button?",
      answer: 3,
      options: ['Container', 'Text', 'ElevatedButton', 'AppBar'],
    ),
    QuestionModel(
      id: 7,
      question: "What is `pubspec.yaml` used for in a Flutter project?",
      answer: 4,
      options: [
        'For managing project settings',
        'For writing Dart code',
        'For handling database configurations',
        'For defining dependencies and assets'
      ],
    ),
    QuestionModel(
      id: 8,
      question: "Which method is used to navigate to a new screen in Flutter?",
      answer: 1,
      options: [
        'Navigator.push',
        'Screen.open',
        'Route.go',
        'Screen.navigate'
      ],
    ),
    QuestionModel(
      id: 9,
      question: "What does the `Scaffold` widget provide in a Flutter app?",
      answer: 2,
      options: [
        'Network handling',
        'A basic layout structure with app bar and body',
        'State management',
        'Database connection'
      ],
    ),
    QuestionModel(
      id: 10,
      question: "Which of these is a common state management solution in Flutter?",
      answer: 4,
      options: ['Redux', 'Bloc', 'Provider', 'All of the above'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];

  bool _isPressed = false;
  bool get isPressed => _isPressed;

  double _numberOfQuestion = 1;
  double get numberOfQuestion => _numberOfQuestion;

  int? _selectAnswer;
  int? get selectAnswer => _selectAnswer;

  int? _correctAnswer;
  int _countOfCorrectAnswers = 0;
  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  final Map<int, bool> _questionIsAnswerd = {};

  late PageController pageController;

  Timer? _timer;
  final maxSec = 15;
  final RxInt _sec = 15.obs;
  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }

    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }

  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null && _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
