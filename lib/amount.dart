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
    print(data);
    return new MaterialApp(

      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Amount"),
          ),
          body: new ListView.builder(
           itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index){
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
                      data[index]["current_amount"],
                    style: new TextStyle(
                      fontSize: 30.0,
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
                )

              ],

            ),
          ),

      ),

    );

  }
}