import 'package:flutter/material.dart';
import 'package:loginpage/profile.dart';
import 'buybooks.dart';
import 'package:loginpage/main.dart';
import 'classdetails.dart';
import 'profile.dart';

// ignore: camel_case_types
class Home_Page extends StatelessWidget {
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
                          'Harsh Shah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'harsh_shah@gmail.com',
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
                title: Text('profile'),
                leading: Icon(Icons.account_circle),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()))),
            Divider(
              height: 1.0,
            ),
            ListTile(
                title: Text('home'),
                leading: Icon(Icons.home),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_Page()))),
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
                    MaterialPageRoute(builder: (context) => MyHomePage()))),
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'HI User',
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

          // Card 1
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('PHYSICS'),
                ),
                FlatButton(
                  child: const Text('MindSetters'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Class_details()));
                  },
                ),
                FlatButton(
                  child: const Text('PACE'),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Card 2

          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('MATHS'),
                ),
                FlatButton(
                  child: const Text('FIITJEE'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: const Text('RAO IIT'),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Card 3
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('KARATE'),
                ),
                FlatButton(
                  child: const Text('SHATOKAN'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      )),

      // Here goes the code for drawer details.....
    );
  }
}
