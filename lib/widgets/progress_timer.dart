import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';


class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.sec.value / 15),
              color: Colors.amber,
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.sec.value}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
