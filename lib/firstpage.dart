import 'package:flutter/material.dart';
import 'main.dart';
import 'payment.dart';
import 'package:mybankingapp/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:mybankingapp/settings.dart ';
import './speech_package.dart';

class first extends StatefulWidget {
  @override
  _firstState createState() => new _firstState();
}

class _firstState extends State<first> {
  List data;

  Future<String> getData() async {
    var res = await http.get(new Uri.http("10.0.2.2:8080", "/TransactionInfo"));

    this.setState(() {
      data = JSON.decode(res.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(hintText: 'Enter Payee'),
            ),
            new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "enter amount"),
            ),
            new RaisedButton(
                child: new Text('Pay'),
                onPressed: () async {
                  SpeechPackage.toSpeech("pay");
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new payment()));
                })
          ],
        ),
      ),
    );
  }
}
