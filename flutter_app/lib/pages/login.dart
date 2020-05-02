import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import 'tutor_home.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'student_home.dart';

String url = 'http://10.0.2.2:8888';

Future<List> login(String username, String password) async {
  final creds = "username=$username&password=$password&grant_type=password";
  const clientID = "com.socratica";
  final body = creds;

// Note the trailing colon (:) after the clientID.
// A client identifier secret would follow this, but there is no secret, so it is the empty string.
  final String clientCredentials =
  const Base64Encoder().convert("$clientID:".codeUnits);

  print(clientCredentials);

  final http.Response response =
//  await http.post("http://10.0.2.2:8888/auth/token",
//  await http.post("http://localhost:8888/auth/token",
  await http.post("$url/auth/token",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic $clientCredentials"
      },
      body: body);

  List ret = [];
  Map<String, dynamic> resp = jsonDecode(response.body);
  Map<String, dynamic> jsonType;

  if(response.statusCode == 200){
    final http.Response typeResp = await http.get("$url/getType/$username");
    jsonType = jsonDecode(typeResp.body);
  }

  ret = [resp['access_token'], jsonType['type'], jsonType['id']];
  return ret;
}

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => new _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Socratica',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _loginKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'USERNAME',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          obscureText: false,
                          controller: _username,
                          validator: (value) {
                            if(value.isEmpty)   return 'Please enter email';
                            //if(!EmailValidator.validate(value))   return 'Invalid email';
                            return null;
                          },
                        ),
                        SizedBox(height: 5.0,),
                        TextFormField(
                          controller: _pass,
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          obscureText: true,
                        ),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 10.0, left: 20.0),
                          child: InkWell(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: RaisedButton(
                              onPressed: () async {
                                if(_loginKey.currentState.validate()){
                                    String pass = _pass.text;
                                    String username = _username.text;
//                                      String creds = "username=$username&password=$pass&grant_type=password";
//                                    print('mehhhh');
                                    List ans = await login(username, pass);
                                    print(ans);
                                    if(ans[1] == 'tutor'){
                                      setState(() {
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TutorHome(list: ans)));
                                      });
                                    }
                                    else{
                                      setState(() {
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(list: ans,)));
                                      });
                                    }

//
                                }
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('New here?'),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
