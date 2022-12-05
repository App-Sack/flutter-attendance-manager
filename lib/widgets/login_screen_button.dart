import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreenButton extends StatefulWidget {
  final String textLabel;
  final Function()? onPressed;
  bool loading;
  LoginScreenButton({super.key, required this.textLabel, this.onPressed,this.loading=false});

  @override
  State<LoginScreenButton> createState() => _LoginScreenButtonState();
}

class _LoginScreenButtonState extends State<LoginScreenButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
              child: widget.loading?CircularProgressIndicator(color: kOrangeColor,):Text(
            widget.textLabel,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
