import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:loginpage/pages/profile.dart';
import 'buybooks.dart';
import 'package:loginpage/main.dart';
import 'classdetails.dart';
import 'profile.dart';
import 'login.dart';
import 'tutor_home.dart';

String url = 'http://10.0.2.2:8888';

Future<http.Response> addTutorToClass(String username, int classID) async {
  final http.Response response = await http.get(
    "$url/getTutorByUsername/$username",
  );

  Map user = jsonDecode(response.body);
  int userID = user['id'];

  http.Response response2 = await http.post(
    "$url/updateTutorClass",
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, int>{
      'userID': userID,
      'classID': classID
    })
  );

  return response2;
}

Future<int> addClass(int tutorID, String name, int contact, String address, String tutors, String descr) async {
  List addr = address.split(', ');

  print('in add class function');
  final http.Response response = await http.post(
    '$url/add_class',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'contact': contact,
      'street': addr[0],
      'city': addr[1],
      'state': addr[2],
      'description': descr,
      'admin_id': tutorID
    })
  );

  Map newClass = jsonDecode(response.body);
  print(newClass);
  List tutor = tutors.split(' ');
  for(int i=0; i<tutor.length; i++){
    String user = tutor[i];
    http.Response addTutor = await addTutorToClass(tutor[i], newClass['id']);
    print(addTutor.statusCode);
    if(addTutor.statusCode == 200)  print('$user added');
//    try{
//
//    }
//    catch(e){
//      print('Error $e');
//    }
  }
  print(response);
  print(response.body);
  return response.statusCode;
}

class AddClass extends StatefulWidget {
  final String name;
  final int id;
  AddClass({Key key, @required this.name, @required this.id}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _addClassKey = GlobalKey<FormState>();
  final TextEditingController _className = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _tutors = TextEditingController();
  final TextEditingController _descr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _name = widget.name;
    int id = widget.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SOCRATICA'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '$_name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
//            ListTile(
//                title: Text('home'),
//                leading: Icon(Icons.home),
//                onTap: () => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => TutorHome(list: widget.list)))),
//            Divider(
//              height: 1.0,
//            ),
            ListTile(
                title: Text('books'),
                leading: Icon(Icons.book),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Books()))),
            Divider(
              height: 1.0,
            ),
            ListTile(
                title: Text('logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginForm()))),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                  child: Center(
                    child: Text(
                      'Hi $_name! Add class details',
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
              key: _addClassKey,
              child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                        child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _className,
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
                              TextFormField(
                                controller: _contact,
                                decoration: InputDecoration(
                                    labelText: 'Contact no.',
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
                                controller: _descr,
                                decoration: InputDecoration(
                                    labelText: 'Description',
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
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: _tutors,
                                decoration: InputDecoration(
                                    labelText: 'Tutors',
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
                                        if (_addClassKey.currentState.validate()) {
                                          print('button clicked');
                                          String address = _street.text + ", " + _city.text + ", " + _state.text;
                                          int response = await addClass(widget.id, _className.text, int.parse(_contact.text), address, _tutors.text, _descr.text);
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
                                          'Create class',
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
      )
    );
  }
}
