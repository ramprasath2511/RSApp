import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rsapp/Pages/Home/home_page.dart';
import 'package:rsapp/Pages/Registration/Registration.dart';
import 'package:rsapp/Pages/Splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/Login/login_page.dart';

void main() {
  runApp( RsApp());
}

class RsApp extends StatefulWidget {
  @override
  _RsAppState createState() => _RsAppState();
}

class _RsAppState extends State<RsApp> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

 Color _primaryColor = HexColor('#DC54FE');
 Color _accentColor = HexColor('#8A02AE');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS App',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home:Stack( children:[

        (_loginStatus == 1)? HomePage():SplashScreen(title: 'RS App'),
     ] ),
      routes: <String, WidgetBuilder>{
    '/login_page': (BuildContext context) => new LoginPage(),
    '/Registration': (BuildContext context) => new RegistrationPage(),
    '/home_page': (BuildContext context) => new HomePage(),
    },
    );
  }
  var _loginStatus=0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("value")!;
    });
  }
}

