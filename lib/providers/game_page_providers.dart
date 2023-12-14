import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final String difficultyLevel;
  List? questions;
  int _currentQuestionCount = 0;
  int _maxQuestions = 5;
  int _correctQuestionCount = 0;

  BuildContext context;
  GamePageProvider({
    required this.difficultyLevel,
    required this.context,
  }) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'category': 18,
        'difficulty': difficultyLevel,
      },
    );
    var _data = jsonDecode(
      _response.toString(),
    );
    questions = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    if (questions != null && _currentQuestionCount < questions!.length) {
    return questions![_currentQuestionCount]["question"];
  } else if (_currentQuestionCount == _maxQuestions) {
    // Game over, display endgame message
    return "Game over";
  } else {
    // Handle the case when there are no questions or _currentQuestionCount is out of bounds
    return "No question available";
  }
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _correctQuestionCount += isCorrect ? 1 : 0;
    _currentQuestionCount++;
    notifyListeners();
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle_sharp : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions) notifyListeners();
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score: $_correctQuestionCount/$_maxQuestions"),
          );
        });
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
