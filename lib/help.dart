import 'package:flutter/material.dart';
import 'main.dart';
import 'package:mybankingapp/settings.dart';
import './amount.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'settings.dart';
import 'package:speech_recognition/speech_recognition.dart';
import './speech_package.dart';


class help extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Help & Feedback")),
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
                onTap:() async {
                  SpeechPackage.toSpeech('Quit');
                  Navigator.of(context).pop();
                }
            ),
            new ListTile(
                title: new Text("Back"),
                trailing: new Icon(Icons.home),
                onTap:() async {
                  SpeechPackage.toSpeech('Accounts & Summary');
                  Navigator.of(context).pushAndRemoveUntil
                    (new MaterialPageRoute(builder:
                      (BuildContext context) => new amount()),
                          (Route route) => route == null);
                }
            )

          ],

        ),
      ),

      body: new Container(
      child: new Card(
      child: new Column(
      children: <Widget>[
          new Text("SUPPORT CENTER",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Times Roman",decoration: TextDecoration.underline,
            fontSize: 20.0,),),
          new Text("",style: new TextStyle(fontSize: 20.0,),),
          new Text("Registered Office :  Bank Tower",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Rock Salt",
            fontSize: 17.0, ),),
          new Text("Near Chakli Circle, Old Padra Road, Vadodara 390007, Gujarat, India.",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Rock Salt",
            fontSize: 17.0,),),
          new Text("",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Rock Salt",
            fontSize: 20.0,),),
          new Text("Tel :+91-265-6722286",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Rock Salt",
            fontSize: 17.0,),),
          new Text("Fax : +91-22-26531122",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Rock Salt",
            fontSize: 17.0,),),


      ],
    ),
    ),
    ),

    );
  }
}
