import 'dart:convert';

import 'package:rsapp/Model/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/budget.dart';

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
  Future<Map<String, dynamic>> addBudget(
      double amount, String description, String owner, String date, String month) async {
    var budget = Budget(amount, description,date,month,owner);
    print(json.encode(budget));
    var response = await http.post(Uri.parse(url + "/addbudget"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(budget));
    Map<String, int> data ={"Successfully added": 1,};
    Map<String, int> message = {"Failed to add budget": 0};
    if (response.statusCode == 200) {
      print(response.body);
      return data;
    } else {
      return message;
    }
  }

  Future<double> monthlyTotal(String month, String year) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };
    Map<String, String> fields = <String, String>{
      'month': month,
      'year': year
    };
    var request = http.MultipartRequest("GET", Uri.parse(url + "/home"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
      print(streamedResponse);
      return jsonDecode(streamedResponse);
    } else{
      throw Exception('Failed to load Budgetdetails');
    }
  }
  Future<double> ownerTotal(String owner) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
    };
    Map<String, String> fields = <String, String>{
      'owner': owner,
    };
    var request = http.MultipartRequest("GET", Uri.parse(url + "/ownertotal"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
      print(streamedResponse);
      return jsonDecode(streamedResponse);
    } else{
      throw Exception('Failed to load Budgetdetails');
    }
  }
  Future<double> ownermonthlyTotal(String owner, String month) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
    };
    Map<String, String> fields = <String, String>{
      'owner': owner,
      'month': month,
    };
    var request = http.MultipartRequest("GET", Uri.parse(url + "/ownermonthtotal"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
      print(streamedResponse);
      return jsonDecode(streamedResponse);
    } else{
      throw Exception('Failed to load Budgetdetails');
    }
  }
  Future<List<Budget>> filterList(String month, String year) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
    };
    Map<String, String> fields = <String, String>{
      'month': month,
      'year': year,
    };
    var request = http.MultipartRequest("GET", Uri.parse(url + "/filteredlist"))
      ..headers.addAll(headers)
      ..fields.addAll(fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      String streamedResponse = await response.stream.bytesToString();
      List<Budget> res = budgetFromJson(streamedResponse);
      print(res);
      return res;
    } else{
      throw Exception('Failed to load Budgetdetails');


    }
  }
}