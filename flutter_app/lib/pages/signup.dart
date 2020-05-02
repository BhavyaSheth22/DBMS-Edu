import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/pages/fillProfile.dart';
import 'package:loginpage/pages/fillTutorProfile.dart';

import 'dart:async';
import 'dart:convert';

import 'package:loginpage/pages/home.dart';

String url = 'http://10.0.2.2:8888';

Future<List> signup(String email, String username, String password, userType type) async {
//    return 'This function called';
  String edited;
  if(type == userType.student)  edited = 'student';
  if(type == userType.tutor)  edited = 'tutor';

  final http.Response response = await http.post(
    '$url/register',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': username,
      'password': password,
      'type': edited
    }),
  );

  //print('Here is response\n');
  dynamic jso = jsonDecode(response.body);
  return [jso['id'], response.statusCode, jso['username']];
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SignUpForm()
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

enum userType { student, tutor }

class _SignUpFormState extends State<SignUpForm> {
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  List _response;
  userType _character = userType.student;

@override
  Widget build(BuildContext context) {
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
                    'Signup now',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Form(
            key: _signupKey,
            child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
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
                                if(!EmailValidator.validate(value))
                                  return 'Enter valid email';
                                return null;
                              },
                            ),
                            SizedBox(height: 5.0),
                            TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                  labelText: 'USERNAME',
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
                              controller: _pass,
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD ',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'CONFIRM PASSWORD',
                                  labelStyle: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                              obscureText: true,
                              validator: (value) {
                                if (value != _pass.text){
                                  return 'Passwords do not match';
                                }
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              'What are you signing up as?',
                            ),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Student'),
                                  leading: Radio(
                                    value: userType.student,
                                    groupValue: _character,
                                    onChanged: (userType value) {
                                      setState(() { _character = value; });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Tutor'),
                                  leading: Radio(
                                    value: userType.tutor,
                                    groupValue: _character,
                                    onChanged: (userType value) {
                                      setState(() { _character = value; });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
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
                                      if (_signupKey.currentState.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        _response = await signup(_email.text, _username.text, _pass.text, _character);
                                        String text;
                                        bool flag = false;
                                        if(_response[1] == 200){
                                          text = 'Signup successful';
                                          print(_character);
                                          flag = true;
                                        }
                                        else text =_response[1] == 409 ? 'Username or email alreaady exists' : 'Error. Please try again.';

                                        _signupKey.currentState.reset();
                                        Scaffold
                                            .of(context)
                                            .showSnackBar(SnackBar(content: Text(text)));

                                        if (flag == true) {
                                          Future.delayed(Duration(seconds: 1));
                                          setState(() {
                                            if(_character == userType.student){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => FillProfile(list: _response),
                                                )
                                              );
                                            }
                                            else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => FillTutorProfile(list: _response),
//                                                    builder: (context) => FillTutorProfileForm(),
                                                  )
                                              );
                                            }
                                          });
                                        }
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 5.0),
                          ]
                      )
                  ),
                ]
            )
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
          height: 40.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  'Go Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
        )],
    );
  }
}

