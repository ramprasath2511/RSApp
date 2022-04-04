import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rsapp/Model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  String url = "http://192.168.99.1:8080";


  Future<Map<String, dynamic>> postRegister(
      String username, String email, String password, String profilePic) async {
    var match = User(username, email, password, profilePic);
    print(json.encode(match));
    var response = await http.post(Uri.parse(url + "/register"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(match));
    Map<String, int> data ={"Successful authentication": 1,};
    Map<String, int> message = {"Registration Failed": 0};
    if (response.statusCode == 200) {
      print(response.body);
      savePref(1,username,email,profilePic);
      return data;

    } else {
      return message;
    }

  }

  Future<Map<String, dynamic>> loginAuth(String email, String password  ) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'text/plain',
    };
    Map<String, String> fields = <String, String>{
      'email': email,
      'password': password,
    };
    var request = http.MultipartRequest("POST", Uri.parse(url + "/login"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
       // print(jsonDecode(stremedResponse));
      _savePref(1,"email");
        return jsonDecode(streamedResponse);
    } else {
      throw Exception('Failed to load Budgetdetails');
    }
  }

  Future<String> forgotPassword( String password, String email) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };
    Map<String, String> fields = <String, String>{
      'email': email,
      'password': password,
    };
    var request = http.MultipartRequest("PUT", Uri.parse(url + "/forgotpassword"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
      // print(jsonDecode(stremedResponse));
      
      return streamedResponse;
    } else {
      return "Bad network";
    }

  }
  savePref(int value, String username, String email, String? profilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", value);
    prefs.setString("name", username);
    prefs.setString("email", email);
    prefs.setString("profilePic",profilePic!);
    prefs.commit();
  }

  _savePref(int value, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.getString("email");
    preferences.commit();

  }
}

