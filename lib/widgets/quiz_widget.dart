import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vorkautus/dto/QuestionDTO.dart';
import '../globals.dart' as globals;

class QuizSubview extends StatefulWidget {
  @override
  _QuizSubviewState createState() => _QuizSubviewState();
}

class _QuizSubviewState extends State<QuizSubview> {
  late List<QuestionDTO> questions;
  late QuestionDTO currentQuestion;
  late List<String> shuffledAnswers;

  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Question Text Field
                Text(
                  currentQuestion?.question ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0),
                ),
                SizedBox(height: 16.0),
                // Answer Buttons
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: shuffledAnswers.map((option) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: AnswerButton(
                                option: option,
                                onPressed: () => _onAnswerSelected(option),
                                color: _getColor(option),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadQuestion() {
    QuestionDTO? question =
        globals.repository.getRandomQuestionFromList(questions);
    if (question != null) {
      currentQuestion = question;
      List<String> answers = List.from(question.wrongAnswers)
        ..add(question.rightAnswer);
      answers.shuffle(Random());
      shuffledAnswers = answers;
    } else {
      throw Exception("Question was not found");
    }
  }

  void _onAnswerSelected(String option) {
    setState(() {
      selectedAnswer = option;
      answered = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Reset the state for the next question
        answered = false;
        selectedAnswer = null;
        loadQuestion();
      });
    });
  }

  Color _getColor(String option) {
    if (answered) {
      return (option == currentQuestion?.rightAnswer)
          ? Colors.green
          : Colors.red;
    }
    return const Color.fromARGB(255, 79, 55, 139); // Default color when not answered
  }

  @override
  void initState() {
    super.initState();
    questions = globals.repository.getQuestionsFromJson();
    loadQuestion();
  }
}

class AnswerButton extends StatelessWidget {
  final String option;
  final VoidCallback onPressed;
  final Color color;

  AnswerButton(
      {required this.option, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        option,
        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.normal),
      ),
    );
  }
}
