import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';
import '../models/question_model.dart';
import 'answer_option.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionModel.question,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              ...List.generate(
                questionModel.options.length,
                    (index) => Column(
                  children: [
                    AnswerOption(
                      questionId: questionModel.id,
                      text: questionModel.options[index],
                      index: index,
                      onPressed: () => Get.find<QuizController>()
                          .checkAnswer(questionModel, index),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
