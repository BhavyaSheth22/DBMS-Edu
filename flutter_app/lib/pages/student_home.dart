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
import 'addClass.dart';
import 'tutor_home.dart';
import 'map.dart';
import 'classDetails.dart';

String url = 'http://10.0.2.2:8888';

Future<Map>  getStudentInfo(int id, String access) async {
  List ans = [];
//  String access = list[0];
//  int id = list[2];

  final http.Response response = await http.get(
    "$url/getStudentByID/$id",
    headers: <String, String>{
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $access"
    },
  );

  Map<String, dynamic> tutor = jsonDecode(response.body);
  return tutor;
}

Future<List> getAllTuitions() async {
  final http.Response response = await http.get(
    '$url/getAllTuitions',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  final tuitions = jsonDecode(response.body);
//  print(tuitions);

  return tuitions;
}

class HomePage extends StatefulWidget {
  final List list;
  HomePage({Key key, @required this.list}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _tuitions = List();
  Map _student = Map();

  String _name;
//  String _tuitionName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setVariables(widget.list[2], widget.list[0]).then((value){
      setState(() {
        _name = _student['name'];
//        print(_name);
//        print(_tuitions);
      });
    });
  }

  Future setVariables(int id, String access) async {
    _student = await getStudentInfo(id, access);
    print(_student);

    _tuitions = await getAllTuitions();
    print(_tuitions);
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
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
            Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Hi $_name !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                      fontSize: 15.0,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Here are some classes you may be interested.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                      color: Colors.green,
                    ),
                  ),

                ],
            ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _tuitions.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.book),
                            title: Text(_tuitions[index]['name']),
                            subtitle: Row(
                              children: <Widget>[
                                Text('Location: '),
                                Text(_tuitions[index]['city']),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClassDetails(tuition: _tuitions[index], profile: _student, list: widget.list,)));
                              });
                            },
                          ),

                        ],
                      ),
                    );
                  }
              )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapStateless()));
          });
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
