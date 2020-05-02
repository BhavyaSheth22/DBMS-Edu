import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:loginpage/pages/login.dart';

String url = 'http://10.0.2.2:8888';

Future<int> fillProfile(List student) async {

  final http.Response response = await http.post(
    '$url/addprofile',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'name': student[0],
      'dob': student[1],
      'building': student[2],
      'street': student[3],
      'city': student[4],
      'state': student[5],
      'student_id': student[6]
    }),
  );
  print(response);
  print(response.body);
  return response.statusCode;
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Date of Birth'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          },
      ),
    ]);
  }
}

class FillProfile extends StatefulWidget {

  final List list;
  FillProfile({Key key, @required this.list}) : super(key: key);

  @override
  _FillProfileState createState() => _FillProfileState();
}

class _FillProfileState extends State<FillProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FillProfileForm(list: widget.list),
    );
  }
}

class FillProfileForm extends StatefulWidget {
  final List list;
  FillProfileForm({Key key, @required this.list}) : super(key: key);

  @override
  _FillProfileFormState createState() => _FillProfileFormState();
}

class _FillProfileFormState extends State<FillProfileForm> {
  DateTime date;

  final _fillProfileKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _building = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  List student = [];
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    final String username = widget.list[2];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                child: Center(
                  child: Text(
                    'Hi $username! Please fill these details.',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Form(
            key: _fillProfileKey,
            child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: <Widget>[
                                Text('DOB'),
                                Text(_date == null ? 'Not picked' : _date.toString()),
                                RaisedButton(
                                  child: Text('Pick a date'),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: _date == null ? DateTime.now() : _date,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2021),
                                    ).then((date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    });
                                    print(_date);
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            TextFormField(
                              controller: _building,
                              decoration: InputDecoration(
                                  labelText: 'Building',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 5.0),
                            TextFormField(
                              controller: _street,
                              decoration: InputDecoration(
                                  labelText: 'Street ',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _city,
                              decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.0,),
                            TextFormField(
                              controller: _state,
                              decoration: InputDecoration(
                                  labelText: 'State',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 50.0),
                            Container(
                                height: 40.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_fillProfileKey.currentState.validate()) {
                                        student = [_name.text, _date.year, _building.text, _street.text, _city.text, _state.text, widget.list[0]];
                                        print(student);
                                        int response = await fillProfile(student);
                                        if(response == 200){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LoginForm(),
                                              )
                                          );
                                        }
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(height: 5.0),
                          ]
                      )
                  ),
                ]
            )
        ),
        ],
    );
  }
}