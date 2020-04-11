import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Socratica';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)), //appbar title

      // here goes the code for body of the home page . It consists of 3 cards wrapped in Column widgets.

      body: Center(
        child: Column(
          children: <Widget>[
            // Card 1
          Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text('PHYSICS'),
              ),
              FlatButton(
                child: const Text('Classes 1'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 2'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 3'),
                onPressed: () {

                },
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
                title: Text('KARATE'),
              ),
              FlatButton(
                child: const Text('Classes 1'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 2'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 3'),
                onPressed: () {

                },
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
                title: Text('MATHS'),
              ),
              FlatButton(
                child: const Text('Classes 1'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 2'),
                onPressed: () {

                },
              ),
              FlatButton(
                child: const Text('Classes 3'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ],
    )
  ),

      // Here goes the code for drawer details.....
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('User'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Buy books'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('LogOut'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}