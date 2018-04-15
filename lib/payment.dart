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

class payment extends StatefulWidget {
  @override
  _paymentState createState() => new _paymentState();
}

class _paymentState extends State<payment> {
  String _title;
  Widget _screen;
  login _login;
  settings _settings;
  bool _authenticated;

  List data;

  getData() async {

    var response = await http.get(new Uri.http("10.0.2.2:8080", "/TransactionInfo"));
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
    print(data);
    return new MaterialApp(

      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Payment"),
        ),
        body: new Container(
          padding: new EdgeInsets.only(left: 42.0),
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
          new Column(
          children: [

          ],
          ),
              ],
          ),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Sanjana Sinha"),
                accountEmail: new Text("sanjana@icici.com"),

              ),
              new ListTile(
                title: new Text("Help & Feedback"),
                trailing: new Icon(Icons.settings),
              ),
              new ListTile(
                title: new Text("Home"),
                trailing: new Icon(Icons.home),
                onTap:() =>  Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new settings()), (Route route)=> route==null),
              ),
              new ListTile(
                title: new Text("Quit"),
                trailing: new Icon(Icons.close),
                onTap:() => Navigator.of(context).pop(),
              )

            ],

          ),
        ),

      ),

    );

  }
}