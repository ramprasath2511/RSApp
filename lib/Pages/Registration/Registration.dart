
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsapp/Common/theme_helper.dart';
import 'package:rsapp/Api/api_manager.dart';
import 'package:rsapp/Pages/Home/home_page.dart';
import 'package:rsapp/Pages/Login/login_page.dart';
import 'package:rsapp/Pages/Registration/registration_header.dart';
import 'package:image_picker/image_picker.dart';

import '../../Common/image_picker.dart';




class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;
  late String username,email,password;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  TextEditingController _usernameController=new TextEditingController();
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool uploadStatus = false;

 File? _image;

  _imageFromCamera() async {
    final PickedFile? pickedImage =
    await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage == null) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);
    if (imageConstraint(fileImage)) {
      setState(() {
        _image = fileImage;
      });
    }
  }

  _imageFromGallery() async {
    final PickedFile? pickedImage =
    await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);
    if (imageConstraint(fileImage)) {
      setState(() {
        _image = fileImage;
      });
    }
  }

  bool imageConstraint(File image) {
    if (!['bmp', 'jpg', 'jpeg']
        .contains(image.path.split('.').last.toString())) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image format should be jpg/jpeg/bmp.");
      return false;
    }
    if (image.lengthSync() > 10000000000000) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image Size should be less than expected.");
      return false;
    }
    return true;
  }



@override
void dispose(){
  _usernameController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: RegistrationHeader(150),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child:CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 6,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: _image != null
                                       ? FileImage(_image!)
                                       : AssetImage('images/splash_image.jpeg') as ImageProvider
                                 // Icon(Icons.person, color: Colors.grey.shade300, size: 80.0,),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  bottomPickerSheet(
                                      context, _imageFromCamera, _imageFromGallery);
                                },
                                child:Container(
                                padding: EdgeInsets.fromLTRB(110, 110, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
            ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your User name'),
                            validator: (val)=>(val!.isEmpty ?'Please enter your Name':null),
                            controller: _usernameController,
                            onSaved: (val) {
                              username = val!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                            controller: _emailController,
                            onSaved: (val) {
                              email = val!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            controller: _passwordController,
                            onSaved: (val) {
                              password = val!;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  Future<Map<String, dynamic>> response =
                                  ApiManager().postRegister(_usernameController.text,_emailController.text,_passwordController.text,_image!.path.toString());
                                  response.then((value) =>
                                  {
                                    value.forEach((key, value) {
                                      scaffoldMessenger.showSnackBar(
                                          SnackBar(content: Text(key)));
                                      if (value == 1) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                    })
                                  });
                                }
                               /* if(_usernameController.text.isEmpty)
                                {
                                  scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                  return;
                                }
                                if(_emailController.text.isEmpty)
                                {
                                  scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Email")));
                                  return;
                                }
                                if(_passwordController.text.isEmpty||_passwordController.text.length<6)
                                {
                                  scaffoldMessenger.showSnackBar(SnackBar(content:Text("Password should be min 6 characters")));
                                  return;
                                }*/

                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(10,20,10,20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Login',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialog({required BuildContext context, String? title, String? content}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title ?? ""),
            content: Text(content ?? ""),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Continue'),
                ),
              ),
            ],
          );
        });
  }

}