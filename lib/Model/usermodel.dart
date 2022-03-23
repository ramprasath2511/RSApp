import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class User {


  late int id;
  String username;
  String password;
  String email;
  String? profilePic;


  User( this.username, this.password, this.email ,this.profilePic);



  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, email: $email, profilePic: $profilePic}';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    json["username"],
    json["password"],
    json["email"],
    json["profilePic"],
  );
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "profilePic": profilePic,
  };

}
