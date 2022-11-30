import 'package:flutter/material.dart';

class InputFieldBox extends StatelessWidget {
  InputFieldBox({
    Key? key,
    required this.userIdController,
    required this.inputTypeText,
    required this.keyboardType,
    this.isPass = false,
  }) : super(key: key);

  final TextEditingController userIdController;
  final String inputTypeText;
  final TextInputType keyboardType;
  bool isPass;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userIdController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: inputTypeText,
        suffixStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
