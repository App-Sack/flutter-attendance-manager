import 'package:attendance_manager/utils/colors.dart';
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
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: inputTypeText,
        focusedBorder: UnderlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(
              width: 2.5, color: kBlueColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: Colors.white),
        ),
        disabledBorder: UnderlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(
              width: 1, color: Colors.white),
        ),
        suffixStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
