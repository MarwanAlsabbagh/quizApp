import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed('/quiz_screen');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Get.isDarkMode
                ? [Color(0xFF121212), Color(0xFF1E1E1E)]
                : [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'Let\'s Start the Quiz!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your name to get started.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Form(
                    key: _formkey,
                    child: GetBuilder<QuizController>(
                      init: Get.find<QuizController>(),
                      builder: (controller) => TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black38,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Name should not be empty';
                          }
                          return null;
                        },
                        onSaved: (String? val) {
                          controller.name = val!.trim().toUpperCase();
                        },
                        onFieldSubmitted: (_) => _submit(context),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      width: double.infinity,
                      onPressed: () => _submit(context),
                      text: 'Start Quiz',
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
