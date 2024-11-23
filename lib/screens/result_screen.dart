import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: Get.isDarkMode
                    ? [Color(0xFF121212), Color(0xFF1E1E1E)]
                    : [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: GetBuilder<QuizController>(
              init: Get.find<QuizController>(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations!',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    controller.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.amber,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Your Score is:',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${controller.scoreResult.round()} /100',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.amber,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    onPressed: () => controller.startAgain(),
                    text: 'Start Again',
                  ),
                  const SizedBox(height: 30),
                  Icon(
                    Icons.emoji_emotions,
                    color: Colors.amber,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
