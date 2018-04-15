import 'package:flutter/material.dart';
import 'package:mybankingapp/login.dart';
import 'main.dart';
import 'package:mybankingapp/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:developer';
import 'dart:core';
import './speech_package.dart';
import  './help.dart';




class amount extends StatefulWidget {
  @override
  _amountState createState() => new _amountState();
}

class _amountState extends State<amount> {
  String _title;
  Widget _screen;
  login _login;
  settings _settings;
  bool _authenticated;

  List data;

  getData() async {

    var response = await http.get(new Uri.http("10.0.2.2:8080", "/AmountInfo"));
    this.setState((){
        print(JSON.decode(response.body)['data']);
        data = JSON.decode(response.body)['data'];
      }
    );
//    print(data);
    return data;
  }

  @override
  void initState() {
   this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Accounts & Summary"),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.help),
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () {
      SpeechPackage.toSpeech('HELP');
      Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
      builder: (BuildContext context) => new help()), (
      Route route) => route == null);
      },
              ),
            ],

          ),
          body: new Container(
            padding: new EdgeInsets.only(left: 20.0),
            child: new Column(
              children: [
                new Row(
                  children:[
                    new Text("Account number", style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0)),
                  ],
                ),
                new Row(
                  children: [
                    new Text("Available Balance", style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0)),
                  ],
                ),
              ],
            ),
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text("Help & Feedback"),
                  trailing: new Icon(Icons.settings),
                ),
                new ListTile(
                  title: new Text("Home"),
                  trailing: new Icon(Icons.home),
                    onTap:() async {
                      SpeechPackage.toSpeech('home');
                      Navigator.of(context).pushAndRemoveUntil
                        (new MaterialPageRoute(builder:
                          (BuildContext context) => new settings()),
                              (Route route) => route == null);
                    }
                ),
                new ListTile(
                  title: new Text("Quit"),
                  trailing: new Icon(Icons.close),
                  onTap:() => Navigator.of(context).pop(),
                ),
          new ListTile(
      title: new Text("Home"),
        trailing: new Icon(Icons.arrow_back),
        onTap:() async {
          SpeechPackage.toSpeech('home');
          Navigator.of(context).pushAndRemoveUntil
            (new MaterialPageRoute(builder:
              (BuildContext context) => new settings()),
                  (Route route) => route == null);
        }
    ),

              ],

            ),
          ),

      ),

    );

  }
}