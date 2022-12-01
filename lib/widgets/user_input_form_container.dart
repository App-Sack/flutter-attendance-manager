import 'package:attendance_manager/widgets/input_field_box.dart';
import 'package:flutter/material.dart';

class UserInputFormContainer extends StatelessWidget {
  final String inputText;
  final String passwordText;
  final TextInputType inputKeyboardType;
  final TextInputType passwordKeyboardType;
  final TextEditingController userIdController;
  final TextEditingController passwordController;

  UserInputFormContainer(
      {super.key,
      required this.inputText,
      required this.passwordText,
      required this.inputKeyboardType,
      required this.passwordKeyboardType,
      required this.userIdController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InputFieldBox(
            userIdController: userIdController,
            inputTypeText: inputText,
            keyboardType: inputKeyboardType,
          ),
          InputFieldBox(
            userIdController: passwordController,
            inputTypeText: passwordText,
            keyboardType: passwordKeyboardType,
            isPass: true,
          ),
        ],
      ),
    );
  }
}
