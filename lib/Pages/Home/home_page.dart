
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rsapp/Api/api_list.dart';
import 'package:rsapp/Common/theme_helper.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:rsapp/Model/usermodel.dart';

import 'navigationbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User?> userdetails;
  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');
  int currentIndex = 1;
  var drawerKey = GlobalKey<SwipeDrawerState>();
  @override
  void initState() {
      super.initState();
      userdetails = ApiList().getUserDetails();
  }
  @override
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.purple])),
      child: Scaffold(

backgroundColor: Colors.transparent,
        body: SwipeDrawer(
      radius: 20,
      key: drawerKey,
      hasClone: false,
      bodyBackgroundPeekSize: 30,
      backgroundColor: Colors.transparent,
      // pass drawer widget
      drawer: buildDrawer(),
      child:getBody(),
        ),

      ),
    );
  }
  Widget buildDrawer() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 60, 20, 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (size.width - 40) * 0.25,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Mr.Ramprasath",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white54
            ),
            ),
            ]
          ),

            ListTile(
              title: Text("History",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54
              ),),
              onTap: (){},
            ),
            ListTile(
              title: Text('Home',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54
              ),),
              onTap: (){},),

            ListTile(
              title: Text('Logout', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrangeAccent
              ),),),
          ],
        ),
      ),
    );
  }
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:AppBar(
          leading: InkWell(
              onTap: () {
                if (drawerKey.currentState?.openDrawer()) {
                  drawerKey.currentState?.closeDrawer();
                } else {
                  drawerKey.currentState?.openDrawer();
                }
              },
              child: Icon(Icons.menu)),
          title: Text("RS App",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8)),),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black26, offset: Offset(1, 4), blurRadius: 5.0)
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.7],
                colors: [
                  _primaryColor,
                  _accentColor,
                ],
              ),
              color: Colors.deepPurple.shade500,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 20, left: 20, bottom: 20),
                    child: Column(

                      children: [
                        FutureBuilder<User?>(
                          future:userdetails,
                        builder:(context,snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: (size.width - 40) * 0.25,
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data!.profilePic.toString()),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Container(
                                  width: (size.width - 40) * 0.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "Hello!",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black.withOpacity(
                                                0.6)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data!.username,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                          else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: () {  },
                            child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 25, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "24 Feb 2022",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "This Month total expenses",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.white)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Text(
                                          "£2446.90",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.orangeAccent),
                                        ),
                                      ),
                                    )

                                  ],
                                ),

                              ],
                            ),
                            ),
                          ),
                          ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: (size.width - 60) / 2,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    "Go".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Ramprasath",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff67727d)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "£240.0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: (size.width - 60) / 2,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    "Go".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Sudha",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff67727d)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "£480.0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      bottomNavigationBar: BottomNavBarV2(),
    );
  }
}