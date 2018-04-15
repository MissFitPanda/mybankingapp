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


class loans extends StatefulWidget {
  @override
  _loansState createState() => new _loansState();
}

class _loansState extends State<loans> {


  List data;


  @override
  Widget build(BuildContext context) {
    print(data);
    return new MaterialApp(

      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Loans You Can Avail"),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            //if(data == null) {
            //return;
            //}

            // print(index);
            //return new ListTile(
            //title: new Text(
            //  data[index]["current_amount"]
//                    data[index]["current_amount"]
            //),

            return new Card(

              child: new Container(


                child: new Text(
                  "Housing Loans",
                  style: new TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,

                  ),


                ),

                padding: const EdgeInsets.all(40.0),
              ),

            );
          },
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
                  onTap: () async {
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
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
    );
  }
}