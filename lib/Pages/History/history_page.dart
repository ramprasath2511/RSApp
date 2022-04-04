import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rsapp/Api/api_list.dart';
import 'package:rsapp/Common/days_month.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../Model/budget.dart';
import '../Home/home_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  String? selectedValue = DateFormat.y().format(DateTime.now());
  Future<List<Budget>>? response;
  Future<double>? monthlyBudget;
  List<String> items = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',

  ];
  String activeDay = DateFormat.MMMM().format(DateTime.now());
  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');
  @override
  void initState()  {
    super.initState();
    monthlyBudget = ApiList().monthlyTotal(activeDay.toString(), selectedValue!);
    response = ApiList().filterList(activeDay.toString(), selectedValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
                  top: 40, right: 10, left: 10, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>HomePage()));
                      }, icon: Icon(AntDesign.arrowleft)),

                      Text(
                        "History",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          iconSize: 14,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                          buttonHeight: 30,
                          buttonWidth: 70,
                          buttonPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: _primaryColor,
                          ),
                          buttonElevation: 2,
                          itemHeight: 30,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownWidth: 200,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _primaryColor,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(days.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = days[index]['day'];
                              });
                               response = ApiList().filterList(activeDay.toString(), selectedValue!);
                              monthlyBudget = ApiList().monthlyTotal(activeDay.toString(),selectedValue!);
                            },
                            child:  Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: activeDay == days[index]['day']
                                      ? _primaryColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: activeDay == days[index]['day']
                                          ? _primaryColor
                                          : Colors.black.withOpacity(0.1))),
                              child: Center(
                                child: Text(
                                  days[index]['day'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: activeDay == days[index]['day']
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )
                          );
                        })),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          Expanded(
          child:Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FutureBuilder<List<Budget>>(
             future: response,
            builder: (context,AsyncSnapshot<List<Budget>> snapshot) {
              if (snapshot.hasData!=null) {
           return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: (size.width - 40) * 0.7,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'images/splash_image.jpeg',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          width: (size.width - 90) * 0.5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                snapshot.data![index].description,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight
                                                        .w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                snapshot.data![index].date,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(
                                                        0.5),
                                                    fontWeight: FontWeight
                                                        .w400),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                snapshot.data![index].owner,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(
                                                        0.5),
                                                    fontWeight: FontWeight
                                                        .w400),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (size.width - 40) * 0.3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '£'+snapshot.data![index].amount.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 65, top: 8),
                                child: Divider(
                                  thickness: 0.8,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  );
    }else{
                return const Center(
                  child: Text(" No budget data"),
                );
              }},),
    ),
          ),
          SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                FutureBuilder<double>(
    future: monthlyBudget,
    builder:(context,snapshot) {
    if (snapshot.hasData) {
    return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "£"+snapshot.data.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
      }
      else if (snapshot.hasError) {
      return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    }
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
