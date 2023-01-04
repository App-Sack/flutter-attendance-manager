import 'package:attendance_manager/resources/auth_methods.dart';
import 'package:attendance_manager/screens/student_screens/all_subjects_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/all_classes_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:attendance_manager/widgets/login_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/user_input_form_container.dart';

enum selectedUser {
  Student,
  Teacher,
}

class LoginScreen extends StatefulWidget {
  static const routeName='/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var selected = selectedUser.Student;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading=false;
  void clearTheData(){
    userIdController.clear();
    passwordController.clear();
  }
  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
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
                            passwordText: "DDMMYYYY",
                            userIdController: userIdController,
                            passwordController: passwordController,
                            inputKeyboardType: TextInputType.text,
                            passwordKeyboardType: TextInputType.datetime,
                          )
                              : UserInputFormContainer(
                              inputText: "Email Id",
                              passwordText: "Password",
                              inputKeyboardType: TextInputType.text,
                              passwordKeyboardType: TextInputType.text,
                              userIdController: userIdController,
                              passwordController: passwordController),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LoginScreenButton(
                                  textLabel: "Login",
                                  loading: isLoading,
                                  onPressed: () async {
                                    if(userIdController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                      setState(() {
                                        isLoading=true;
                                      });
                                      String response;
                                      if(selected==selectedUser.Student){
                                        response=await AuthMethods().studentLogin(userIdController.text.toLowerCase(), passwordController.text);
                                      }
                                      else{
                                        response=await AuthMethods().TeacherLogin(userIdController.text.toLowerCase(), passwordController.text);
                                      }
                                      SharedPreferences sp=await SharedPreferences.getInstance();
                                      if(response=="success"){
                                        if(selected==selectedUser.Student){
                                          Navigator.of(context).pushReplacementNamed(AllSubjectsScreen.routeName);
                                        }
                                        else{
                                          Navigator.of(context).pushReplacementNamed(AllClassesScreen.routeName);
                                        }
                                      }
                                      else{
                                        setState(() {
                                          isLoading=false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
                                      }
                                    }
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
                                    clearTheData();
                                    setState(() {
                                      selected = selectedUser.Teacher;
                                    });
                                  },
                                )
                                    : LoginScreenButton(
                                  textLabel: "Login As Student",
                                  onPressed: () {
                                    clearTheData();
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
