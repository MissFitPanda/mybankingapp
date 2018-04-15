import 'package:flutter/material.dart';
import 'package:mybankingapp/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:mybankingapp/login.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mybankingapp/amount.dart';
import 'package:mybankingapp/help.dart';



void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    routes: <String, WidgetBuilder>{
      "/settings": (BuildContext context)=> new settings(),
      "/login": (BuildContext context)=> new login(),
      "/amount": (BuildContext context)=> new amount(),
      "/help" :  (BuildContext context)=> new help(),
    }

  ));
}
class MyApp extends StatefulWidget{
  _MyAppState createState() => new _MyAppState();
}

  class _MyAppState extends State<MyApp> {

    String _title = 'Please Login';
    Widget _screen;
    login _login;
    settings _settings;
    bool _authenticated;

    _MyAppState() {
      _login = new login(onSubmit: (){onSubmit();});
      _settings = new settings();
      _screen = _login;
      _authenticated = false;
    }

    void onSubmit() {
      print('Login with: ' + _login.username + ' ' + _login.password);
      //if(_login.username == 'user' && _login.password == 'password') {
      _setAuthenticated(true);
      //}
    }

    void _goHome() {
      print('go home $_authenticated');

      setState(() {
        if(_authenticated == true) {
          _screen = _settings;
        }
        else {
          _screen = _login;
        }
      }
      );
    }
    void _logout() {
      print('log out');
      _setAuthenticated(false);
    }

    void _setAuthenticated(bool auth) {
      setState(() {
        if(auth == true) {
          _screen = _settings;
          _title = 'Welcome';
          _authenticated = true;
        }
        else {
          _screen = _login;
          _title = 'Please Login';
          _authenticated = false;
        }
      }
      );
    }

    @override
    Widget build(BuildContext context) {
      return new MaterialApp (
        title: 'Login Demo',
        home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.indigoAccent,
            title: new Text(_title),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.home), onPressed: (){_goHome();}),
              new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: (){_logout();}),
            ],
          ),
          body: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: _screen,
          ),
        ),
      );
    }
  }
