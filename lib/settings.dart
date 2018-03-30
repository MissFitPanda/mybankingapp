  import 'package:flutter/material.dart';
import 'package:mybankingapp/main.dart';
import 'package:mybankingapp/login.dart';
import 'transactions.dart';
import 'amount.dart';
import 'cards.dart';
  class settings extends StatefulWidget {
    @override
    _settingsState createState() => new _settingsState();
  }

  class _settingsState extends State<settings> {

    String _title = "Welcome to your Profile";


    @override
    Widget build(BuildContext context) {

      return new MaterialApp(
        title: 'login',
        home: new Scaffold(
          appBar: new AppBar(

            backgroundColor: Colors.indigoAccent,
            title: new Text(_title),


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
          body: new Container(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new IconButton(icon: new Icon(Icons.account_balance_wallet),
                    iconSize: 120.0
                    ,onPressed: () =>Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute
                    (builder: (BuildContext context)=> new amount()),(Route route)=> route==null),),
                new IconButton(icon: new Icon(Icons.card_travel),
                    iconSize: 120.0 ,
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new transactions()), (Route route)=> route==null),),
                new IconButton(icon: new Icon(Icons.card_giftcard),
                    iconSize: 120.0,onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new cards()), (Route route)=> route==null),),

              ],
            ),
          )
        ),
      );
    }

  }


