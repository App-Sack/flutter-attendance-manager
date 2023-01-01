import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class AuthMethods{
  
  
  Future<String> studentLogin(String usn,String password) async{
    final url=Uri.parse("https://sjce12345.pythonanywhere.com/api/student/$usn");
    final data=await http.get(url);
    var extractedData=json.decode(data.body) as Map<String,dynamic>;
    String? dob=extractedData['dob'];
    if(dob!=null){
      if(dob==password){
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
    print("called");
    final url=Uri.parse("https://sjce12345.pythonanywhere.com/api/docs/#/user/user_token_create");
    final response= await http.post(url,body:json.encode({
      'email':email,
      'password':password
    }));
    print(response.body);
    return "successs";
  }
}