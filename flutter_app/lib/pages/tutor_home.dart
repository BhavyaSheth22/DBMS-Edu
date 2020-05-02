import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:loginpage/pages/classDetails.dart';
import 'package:loginpage/pages/profile.dart';
import 'buybooks.dart';
import 'package:loginpage/main.dart';
import 'classdetails.dart';
import 'profile.dart';
import 'login.dart';
import 'addClass.dart';

String url = 'http://10.0.2.2:8888';

Future<Map>  getTutorInfo(int id, String access) async {

  final http.Response response = await http.get(
      "$url/getTutorByID/$id",
    headers: <String, String>{
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $access"
    },
  );

  Map<String, dynamic> tutor = jsonDecode(response.body);
  if(tutor['worksAt'] == null)  tutor['worksAt'] = {'id': -1};
  return tutor;
}

Future<Map> getTuitionInfo(int id, String access) async {
  if(id == -1){
    return {'name': 'You do not seem to be the teaching at any class' };
  }

  final http.Response response = await http.get(
    '$url/getTuitionByID/$id',
    headers: <String, String>{
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $access"
    },
  );
  Map<String, dynamic> tuition = jsonDecode(response.body);

  if(response.statusCode == 404){
    tuition = {'name': 'You do not seem to be the teaching at any class' };
  }

  return tuition;

}

Future<Map>  getAdminClass(int id, String access) async {
  print('in admin fn');
  final http.Response response = await http.get(
    '$url/getAdminByTutor/$id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $access"
      },
  );
  print('got response');
  print(response.body);


  if(response.statusCode == 404){
    return {'name': 'You do not seem to be the admin of any class' };
  }

  Map admin = jsonDecode(response.body);

  print('In admin function');
  print(admin);

  return admin;
}

class TutorHome extends StatefulWidget {
  final List list;
  TutorHome({Key key, @required this.list}) : super(key: key);

  @override
  _TutorHomeState createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  Map _tutor = Map();
  Map _worksAt = Map();
  Map _adminOf = Map();

  String _name;
  String _tuitionName;
  String _adminName;

  @override
  void initState() {
    super.initState();
    setVars(widget.list[2], widget.list[0]).then((value) {
      setState(() {
        _tuitionName = _worksAt['name'];
        print(_tutor);
        _name = _tutor['name'];
        print('heres the name');
        print(_name);
        _adminName = _adminOf['name'];
        print(_adminName);
      });
    });

  }

  Future setVars(int id, String access) async {
//    await Future.delayed(Duration(seconds: 2));
    _tutor = await getTutorInfo(id, access);
    print(_tutor);
    print(_tutor['id']);
    _worksAt = await getTuitionInfo(_tutor['worksAt']['id'], access);
    print(_worksAt);
    _adminOf = await getAdminClass(_tutor['id'], access);
    print(_adminOf);
  }

  @override
  Widget build(BuildContext context) {
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
            ListTile(
                title: Text('home'),
                leading: Icon(Icons.home),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TutorHome(list: widget.list)))),
            Divider(
              height: 1.0,
            ),
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
      body:Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Hi $_name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  fontSize: 15.0,
                  color: Colors.green,
                ),
              ),
              Text(
                'Here is your tutor profile:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('Classes'),
                ),
                FlatButton(
                  child: Text('$_tuitionName'),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassDetails(tuition: _worksAt, profile: _tutor)));
                    });
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('You are the admin of the following classes:'),
                ),
                FlatButton(
                  child: Text('$_adminName'),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassDetails(tuition: _adminOf, profile: _tutor)));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddClass(id: _tutor['id'], name: _tutor['name']),
              )
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
