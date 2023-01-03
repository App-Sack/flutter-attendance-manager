import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods{
  
  Future<String> CheckLogin() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    if(sp.getString('usn')!=null){
      return "student";
    }
    if(sp.getString('token')!=null){
      return "teacher";
    }
    else{
      return "login";
    }
  }
  Future<String> studentLogin(String usn,String password) async{
    final url=Uri.parse("https://sjce12345.pythonanywhere.com/api/student/$usn");
    final data=await http.get(url);
    var extractedData=json.decode(data.body) as Map<String,dynamic>;
    String? dob=extractedData['dob'];
    if(dob!=null){
      if(dob==password){
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setString('usn', usn);
        return "success";
      }
      else{
        return "Incorrect DOB";
      }
    }
    else{
      return "Incorrect USN";
    }
  }

  Future<String> TeacherLogin(String email,String password) async{
    final url=Uri.parse("https://sjce12345.pythonanywhere.com/api/user/token/");
    final response= await http.post(url,body:json.encode({
      'email':email,
      'password':password
    }),headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    },);
    final responseData=json.decode(response.body);
    if(responseData['non_field_errors']!=null){
      return "Invalid Credentials";
    }
    else{
      SharedPreferences sp=await SharedPreferences.getInstance();
      sp.setString('token',responseData['token']);
      return "success";
    }
  }

  void LogOut()async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    sp.clear();
  }
}