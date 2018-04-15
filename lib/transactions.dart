import 'package:flutter/material.dart';
import 'main.dart';
import 'payment.dart';
import 'package:mybankingapp/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import'package:mybankingapp/settings.dart ';
import './speech_package.dart';
import 'package:mybankingapp/firstpage.dart' as first;
import 'package:mybankingapp/secondpage.dart' as second;


class transactions extends StatefulWidget {
  @override
  _transactionsState createState() => new _transactionsState();
}

class _transactionsState extends State<transactions> {
List data;

 Future<String> getData() async {
  var res = await http.get(new Uri.http("10.0.2.2:8080", "/TransactionInfo"));


  this.setState((){

    data = JSON.decode(res.body);
  }
  );

  return "Success!";
}
@override
void initState() {
  this.getData();
}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            actions: [
              new IconButton(icon: new Icon(Icons.home),
                onPressed: () =>
                    Navigator.of(context).pushAndRemoveUntil(
                        new MaterialPageRoute(builder: (
                            BuildContext context) => new settings()), (
                        Route route) => route == null),),
            ],
            bottom: new TabBar(
              tabs: [
                new Tab(text: "Self", icon: new Icon(Icons.input)),
                new Tab(text: "Others", icon: new Icon(Icons.launch)),
              ],
            ),
            title: new Text('Fund Transfer'),
          ),
          body: new TabBarView(
              children: [
                new first.first(),
                new second.second(),
            ],
          ),
        ),
      ),
    );

  }
  }

