import 'package:flutter/material.dart';
import 'profile.dart';
import '../main.dart';
import 'book.dart';
import 'home.dart';
import 'login.dart';

class Books extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (context) => LoginForm()))),
          ],
        ),
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const ListTile(
              title: Center(
                child: Text(
                  'TOP BOOKS ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            FlatButton(
              child: const Text(
                'KENNETH ROSEN - Discrete MATHEMATICS',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Book()));
              },
            ),
            FlatButton(
              child: const Text('RD SHARMA - MATHEMATICS'),
              onPressed: () {},
            ),
            FlatButton(
              child: const Text('JAIN AND JAIN - CHEMISTRY'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
