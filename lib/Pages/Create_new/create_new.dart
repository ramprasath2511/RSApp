import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:intl/intl.dart';
import 'package:rsapp/Api/api_list.dart';
import 'package:rsapp/Common/theme_helper.dart';
import 'package:rsapp/Pages/Home/home_page.dart';

class CreatBudgetPage extends StatefulWidget {
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  DateTime _selectedDateTime = DateTime.now();
  final List<String> genderItems = [
    'Ramprasath',
    'Sudha',
  ];
  final _formKey = GlobalKey<FormState>();
   String? selectedValue;
late String description;
late double amount;
late String month;
  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');
  int activeCategory = 0;
  TextEditingController _description = TextEditingController();
  TextEditingController _month = TextEditingController();
  TextEditingController _budgetPrice = TextEditingController();
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
  final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
  final selectedText = Text('You selected: $formattedDate');
  var size = MediaQuery.of(context).size;

  final birthdayTile = new Material(
    color: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('choose date',
              style: TextStyle(
                color: Color(0xff67727d),
                fontSize: 15.0,
              )),
          CupertinoDateTextBox(
              initialValue: _selectedDateTime,
              onDateChange: onBirthdayChange,
              hintText: DateFormat.yMd().format(_selectedDateTime)),
        ],
      ),
    ),
  );
    return Scaffold(
      key: _scaffoldKey,
     // backgroundColor: Colors.grey.withOpacity(0.05),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child:Column(
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
                    top: 25, right: 20, left: 10, bottom: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>HomePage()));
                        }, icon: Icon(Icons.arrow_back),),
                        const Text(
                          "Create budget",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            birthdayTile,
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Purchased Item",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xff67727d)),
                  ),
                  TextFormField(
                    controller: _description,
                    cursorColor: Colors.black,
                    validator: (val) {
                      if(val!.isEmpty) {
                        return "Enter a description";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      description = val!;
                    },
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Enter Item Name", border: InputBorder.none),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (size.width - 140),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Purchased Amount (£)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            TextFormField(
                              controller: _budgetPrice,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              validator: (val) {
                                if(val!.isEmpty) {
                                  return "Enter a price";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                amount = val! as double;
                              },
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  hintText: "£ Enter Amount",
                                  border: InputBorder.none),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Purchased Month",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xff67727d)),
                  ),
                  TextFormField(
                    controller: _month,
                    cursorColor: Colors.black,
                    validator: (val) {
                      if(val!.isEmpty) {
                        return "Enter a current month";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      month = val!;
                    },
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Enter current month eg.June", border: InputBorder.none),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    value: selectedValue,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Who owns the amount',
                      style: TextStyle(fontSize: 14,
                      color: Colors.black45),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purple[700],
                    ),
                    items: genderItems.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select who owns';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, right: 60),
                    child: Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text('Save'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                          Future<Map<String, dynamic>> response =
                          ApiList().addBudget( double.parse(_budgetPrice.text),_description.text,selectedValue!,formattedDate,_month.text);
                          response.then((value) =>
                          {
                            value.forEach((key, value) {
                              if (value == 1) {
                                scaffoldMessenger.showSnackBar(
                                    SnackBar(content: Text(key)));
                              }else{
                                scaffoldMessenger.showSnackBar(
                                    SnackBar(content: Text("Data is not uploaded")));
                              }
                            })
                          });
                        }
                         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),),
      ),//birthdayTile,//getBody(),
    );
  }
  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }

}