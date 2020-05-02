import 'package:flutter/material.dart';
import 'home.dart';
import '../main.dart';
import 'buybooks.dart';
import 'profile.dart';
import 'login.dart';

class Class_details extends StatelessWidget {
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
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Text(
              'MINDSETTERS',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),

            // Here goes the classes image
            /* Image(

              image: AssetImage(assetName),
            ),
          */
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Subject: Physics',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Teacher: Dr Aditya Shah',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Text(
                  'Mitesh Desai : 90% (2019)',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Preet Porwal : 92%  (2018)',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Message from the professor:',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),

            // Here goes the Video Sample,,,
          ],
        ),
      ),
    );
    ;
  }
}
