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
import 'student_home.dart';

import 'addClass.dart';
import 'tutor_home.dart';
import 'map.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:geocoder/geocoder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String url = 'http://10.0.2.2:8888';


Future<List> getTutorFromTuition(int id) async {
  final http.Response response = await http.get(
    "$url/getTutorFromTuition/$id",
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  final tutor = jsonDecode(response.body);
  return tutor;
}

class ClassDetails extends StatefulWidget {
  final Map tuition;
  final Map profile;
  final List list;
  ClassDetails({Key key, @required this.tuition, @required this.profile, this.list}) : super(key: key);

  @override
  _ClassDetailsState createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  List newTutors = [{'name': 'null'}];

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'sBXReBDgnfo',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),

  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTutors(widget.tuition['id']).then((value) {
      setState(() {
        print('in init');
        print(newTutors);
      });
    });
  }

  Future getTutors(int id) async {
    newTutors = await getTutorFromTuition(id);
  }

  _launchURL(String newUrl) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(newUrl)) {
      await launch(newUrl);
    } else {
      throw 'Could not launch $newUrl';
    }
  }

  _launchNav(String origin, String dest) async {
    var cord1 = await Geocoder.local.findAddressesFromQuery(origin);
    var cord2 = await Geocoder.local.findAddressesFromQuery(dest);

    var cord1lat = cord1.first.coordinates.latitude;
    var cord1long = cord1.first.coordinates.longitude;

    print('The coordinates obtained for origin are: ');
    print('$cord1lat, $cord1long');

    var cord2lat = cord2.first.coordinates.latitude;
    var cord2long = cord2.first.coordinates.longitude;

    print('The coordinates obtained for origin are: ');
    print('$cord2lat, $cord2long');

    String api = 'https://www.google.com/maps/dir/?api=1&origin=($cord1lat,$cord1long)&destination=($cord2lat,$cord2long)&travelmode=walking';
    if (await canLaunch(api)) {
      await launch(api);
    } else {
      throw 'Could not launch $api';
    }
  }

  @override
  Widget build(BuildContext context) {
    String origin = widget.profile['building'] + " " + widget.profile['street'] + " " + widget.profile['city'] + " " + widget.profile['state'];
    String dest = widget.tuition['street'] + " " + widget.tuition['city'] + " " + widget.tuition['state'];

    return Scaffold(
      appBar: AppBar(
        title: Text('SOCRATICA'),
        backgroundColor: Colors.green,
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
                          widget.profile['name'],
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
                    MaterialPageRoute(builder: (context) => HomePage(list: widget.list)))),
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
            Divider(
              height: 1.0,
            ),
            ListTile(
                title: Text('view classes'),
                leading: Icon(Icons.explore),
                onTap: () => _launchURL('https://optimistic-thompson-854acb.netlify.app/'),
            ),
            Divider(
              height: 1.0,
            ),
            ListTile(
              title: Text('view bookstores'),
              leading: Icon(Icons.gps_fixed),
              onTap: () => _launchURL('https://upbeat-gates-5d469d.netlify.app/'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.tuition['name'],
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.green,
                ),
              ),

              SizedBox(
                height: 5.0,
              ),
              Image.network(
                'https://donboscoschool.in/wp-content/uploads/2018/12/CHAIR.jpg',
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//                Text(
//                  'Subject: Physics',
//                  style: TextStyle(fontSize: 20.0),
//                ),
//                SizedBox(
//                  height: 15.0,
//                ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
//                Text(
//                  'Description',
//                  style: TextStyle(
//                    fontSize: 25.0,
//                  ),
//                ),
                      Text(
                        widget.tuition['description'],
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                  Text(
                    'Tutors:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: newTutors.length,
                      itemBuilder: (context, index){
                        print('list view');
                        return Center(child: Text(newTutors[index]['name']));
                      }
                  ),
                  YoutubePlayer(
                    controller: _controller,
                  ),
                  RaisedButton(
                    child: Text(
                      'Show navigation to class',
                    ),
                    onPressed: () async {
                      _launchNav(origin, dest);
                    }
                  )
                ],
              ),


              // Here goes the Video Sample,,,
            ],
          ),
        ),
      ),
    );
  }
}
