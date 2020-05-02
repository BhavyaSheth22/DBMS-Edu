import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:loginpage/pages/login.dart';

String url = 'http://10.0.2.2:8888';

Future<int> fillTutorProfileFn(List tutor) async {

  final http.Response response = await http.post(
    '$url/add_tutor_profile',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'name': tutor[0],
      'subjects': tutor[1],
      'quals': tutor[2],
      'tutor_id': tutor[3]
    }),
  );

  print('Something worked');
  print(response);
  print(response.body);
  return response.statusCode;
}

Future<List> getAllSubjects() async {
  final http.Response response = await http.get(
    'http://10.0.2.2:8888/get_subjects',
  );
  List subjects = jsonDecode(response.body);
  return subjects;
}

Future<List> getAllQuals() async {
  final http.Response response = await http.get(
    '$url/get_quals',
  );
  List quals = jsonDecode(response.body);
  return quals;
}


class FillTutorProfile extends StatefulWidget {

  final List list;
  FillTutorProfile({Key key, @required this.list}) : super(key: key);

  @override
  _FillTutorProfileState createState() => _FillTutorProfileState();
}

class _FillTutorProfileState extends State<FillTutorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FillTutorProfileForm(list: widget.list),
//      body: FillTutorProfileForm()
    );
  }
}

class FillTutorProfileForm extends StatefulWidget {
  final List list;
  FillTutorProfileForm({Key key, @required this.list}) : super(key: key);

  @override
  _FillTutorProfileFormState createState() => _FillTutorProfileFormState();
}

class _FillTutorProfileFormState extends State<FillTutorProfileForm> {

  final _fillTutorProfileKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _subs = TextEditingController();
  final TextEditingController _qual = TextEditingController();
  List _subjects;
  List _quals;
  List tutor;

  @override
  void initState() {
      super.initState();
      print('In init');
      listenForSubjectsQuals();
//      print('In init');
//      print(_subjects);
//      print(_quals);
//      print('End of init');
//      ListenForQuals();
  }

  void listenForSubjectsQuals() async {
    _subjects = await getAllSubjects();
    _quals = await getAllQuals();
  }

  @override
  Widget build(BuildContext context) {
//    final String username = widget.list[2];
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
                    'Hi Bhavya! Please fill these details',
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
            key: _fillTutorProfileKey,
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
                            SizedBox(height: 5.0),
                            TextFormField(
                              controller: _subs,
                              decoration: InputDecoration(
                                  labelText: 'Subjects',
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
                              controller: _qual,
                              decoration: InputDecoration(
                                  labelText: 'Qualifications',
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
                                      if (_fillTutorProfileKey.currentState.validate()) {
                                        print('This is button');
                                        tutor = [_name.text, _subs.text, _qual.text, widget.list[0]];
                                        var _response = await fillTutorProfileFn(tutor);
                                        if(_response == 200){
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
