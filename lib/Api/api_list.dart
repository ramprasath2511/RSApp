import 'dart:convert';

import 'package:rsapp/Model/usermodel.dart';
import 'package:http/http.dart' as http;

class ApiList{
  String url = "http://192.168.99.1:8080";
  Future<User> getUserDetails() async {
    User? data;
    var response = await http.get(Uri.parse(url + "/details"));
    if (response.statusCode == 200) {
      data = User.fromJson(jsonDecode(response.body));
      print(data);
      return data;
     print(data);
    } else{
      throw Exception('Failed to load userdetails');
    }

  }
}