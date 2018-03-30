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

      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Transactions"),
        ),
        body: new Column(
          children: <Widget>[
            new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "enter amount"
              ),
            ),
            new RaisedButton(child: new Text('Pay'),
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new payment()),
                )
            )
          ],
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