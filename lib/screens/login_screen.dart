import 'package:attendance_manager/screens/all_subjects_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:attendance_manager/widgets/login_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../widgets/user_input_form_container.dart';

enum selectedUser {
  Student,
  Teacher,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var selected = selectedUser.Student;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final statusBarheight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - statusBarheight,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.asset(
                      "assets/images/jss_logo.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kOrangeColor.withOpacity(0.9),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.red,
                      //       blurRadius: 5,
                      //       spreadRadius: 5),
                      // ]),
                    ),
                    height:
                        (MediaQuery.of(context).size.height - statusBarheight) *
                            0.75,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          selected == selectedUser.Student
                              ? UserInputFormContainer(
                                  inputText: 'USN',
                                  passwordText: "DD/MM/YYYY",
                                  userIdController: userIdController,
                                  passwordController: passwordController,
                                  inputKeyboardType: TextInputType.text,
                                  passwordKeyboardType: TextInputType.datetime,
                                )
                              : UserInputFormContainer(
                                  inputText: "inputText",
                                  passwordText: "passwordText",
                                  inputKeyboardType: TextInputType.text,
                                  passwordKeyboardType: TextInputType.number,
                                  userIdController: userIdController,
                                  passwordController: passwordController),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LoginScreenButton(
                                  textLabel: "Login",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, AllSubjectsScreen.routeName);
                                    //TODO:Login functionality
                                  },
                                ),
                                const Divider(
                                  color: Colors.red,
                                  thickness: 1.5,
                                ),
                                selected == selectedUser.Student
                                    ? LoginScreenButton(
                                        textLabel: "Login As Teacher",
                                        onPressed: () {
                                          setState(() {
                                            selected = selectedUser.Teacher;
                                          });
                                        },
                                      )
                                    : LoginScreenButton(
                                        textLabel: "Login As Student",
                                        onPressed: () {
                                          setState(() {
                                            selected = selectedUser.Student;
                                          });
                                        },
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
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
}
