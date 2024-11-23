import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_timer.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Get.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: Colors.white,
            ),
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: Get.isDarkMode
                      ? [Color(0xFF121212), Color(0xFF1E1E1E)]
                      : [Color(0xFF2C3E50), Color(0xFF34495E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            SafeArea(
              child: GetBuilder<QuizController>(
                init: QuizController(),
                builder: (controller) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Question ',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                              ) ?? TextStyle(color: Colors.white, fontSize: 20),
                              children: [
                                TextSpan(
                                  text: controller.numberOfQuestion.round().toString(),
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ) ?? TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: '/',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                  ) ?? TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: controller.countOfQuestion.toString(),
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ) ?? TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ProgressTimer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionsList[index],
                        ),
                        controller: controller.pageController,
                        itemCount: controller.questionsList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(
          onPressed: () => controller.nextQuestion(),
          text: 'Next',
        ),
      ),
    );
  }
}
