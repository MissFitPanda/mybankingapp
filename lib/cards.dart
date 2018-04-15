import 'package:flutter/material.dart';
import 'package:mybankingapp/login.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mybankingapp/login.dart';
import 'main.dart';
import 'package:mybankingapp/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:developer';



class cards extends StatefulWidget {
  @override
  _cardsState createState() => new _cardsState();
}

class _cardsState extends State<cards> {
  List data;

  Future<String> getData() async {

    var response = await http.get(new Uri.http("10.0.2.2:8080", "/CardInfo"));
    print( JSON.decode(response.body));
    this.setState((){
      data = JSON.decode(response.body)["data"];
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
          title: new Text("Cards & more"),

        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
                child: new Container(
              children:[
                new Text("Debit Cards:",style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                new Text(
                  data[index]["current_cards"],
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
                new Text("Credit Cards:",style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                new Text(
                  data[index]["current_cards"],
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ],
              padding: const EdgeInsets.all(40.0),

                ),

            );
          },
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