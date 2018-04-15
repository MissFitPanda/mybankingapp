import 'package:flutter/material.dart';
import 'package:mybankingapp/main.dart';
import 'package:mybankingapp/login.dart';
import 'transactions.dart';
import 'amount.dart';
import 'cards.dart';
import 'loans.dart';
import 'package:speech_recognition/speech_recognition.dart';
import './speech_package.dart';

  class settings extends StatefulWidget {
    @override
    _settingsState createState() => new _settingsState();
  }

  class _settingsState extends State<settings> {



    bool isListening = false;
    bool _speechRecognitionAvailable = false;

    String _currentLocale = 'en_US';
    String transcription = '';

    // Speech recognition handler
    SpeechRecognition _speech;

    @override
    void initState() {
      super.initState();
      activateSpeechRecognizer();
    }

    String _title = "Welcome to your Profile";
    final String _amount = "Accounts & Summary";
    final String _transaction = "Fund Transfer";


    void activateSpeechRecognizer() {
      print('_MyAppState.activateSpeechRecognizer... ');
      _speech = new SpeechRecognition();
      _speech.setAvailabilityHandler(onSpeechAvailability);
      _speech.setCurrentLocaleHandler(onCurrentLocale);
      _speech.setRecognitionStartedHandler(onRecognitionStarted);
      _speech.setRecognitionResultHandler(onRecognitionResult);
      _speech.setRecognitionCompleteHandler(onRecognitionComplete);
      _speech
          .activate()
          .then((res) => setState(() => _speechRecognitionAvailable = res));
    }
    Widget _screen;
    login _login;
    bool _authenticated;




    _MyAppState(){
      _login = new login(onSubmit: (){ onSubmit(); });
      _settings = new settings();
      _screen = _login;
      _authenticated = false;
    }

    void onSubmit() {
      print('login with:' +  _login.username + ' ' + _login.password);
//      if(_login.username =='u' && _login.password =='p'){
      _setAuthenticated(true);
//      }
    }

    void _gohome(){
      print('go home');
      setState((){
        if(_authenticated==true){
          _screen = _settings;
        }else{
          _screen = _login;

        }

      }
      );
    }
    void _logout(){
      print('go logout');
      _setAuthenticated(false);

    }
    void _setAuthenticated(bool auth){
      setState((){
        if(auth==true){
          _screen = _settings;
          _title= 'Welcome to your account';
          _authenticated = true;
        }else{

          _title= 'Please login';
          _screen = _login;
          _authenticated = false;

        }

      }
      );
    }



    @override
    Widget build(BuildContext context) {

      return new MaterialApp(
        title: 'login',
        home: new Scaffold(
          appBar: new AppBar(

            backgroundColor: Colors.indigoAccent,
            title: new Text(_title),
              actions: <Widget>[
        new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: () {
            Navigator.of(context).pushAndRemoveUntil
              (new MaterialPageRoute(builder:
                (BuildContext context) => new login()),
                    (Route route) => route == null);
          }),


        ],
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
                  onTap:() async {
                    SpeechPackage.toSpeech('Quit');
                    Navigator.of(context).pop();
                  }
                )

              ],

            ),
          ),
          body: new Container(
            padding: new EdgeInsets.only(left:110.0),
            child: new Row(
              children:[
                 new Column(
                children:[
            new IconButton(icon: new Icon(Icons.people, color: Colors.indigoAccent),
            iconSize: 120.0
            ,onPressed: () =>Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute
            (builder: (BuildContext context)=> new amount()),(Route route)=> route==null),),
          new Text("Accounts & Summary",style: new TextStyle(fontWeight: FontWeight.bold),),
          new IconButton(icon: new Icon(Icons.swap_horiz,color: Colors.indigoAccent),
            iconSize: 120.0 ,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new transactions()), (Route route)=> route==null),),
            new Text("Fund Transfer",style: new TextStyle(fontWeight: FontWeight.bold),),
            new IconButton(icon: new Icon(Icons.style,color: Colors.indigoAccent),
              iconSize: 120.0,onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new cards()), (Route route)=> route==null),),
            new Text("Cards",style: new TextStyle(fontWeight: FontWeight.bold),),
            _buildButtonBar(),
                ],
            ),
              ],
            ),
          ),
        ),
      );
    }
    void _startRecognition() {
      _speech
          .listen(locale: _currentLocale)
          .then((result) {
        _speechRecognitionAvailable = result;
        print('_MyAppState.start => result ${result}');
        isListening = result;
      });
    }

    void _stopRecognition() {
      _speech.stop().then((result) => setState(() {
        isListening = false;
      }));
    }

    void onSpeechAvailability(bool result) =>
        setState(() => _speechRecognitionAvailable = result);

    void onCurrentLocale(String locale) =>
        setState(() => _currentLocale = locale);

    void onRecognitionStarted() => setState(() => isListening = true);

    void onRecognitionResult(String text) => setState(() => transcription = text);

    void onRecognitionComplete() => setState(() {
      isListening = false;
      if (transcription.toLowerCase().contains('Accounts')) {
        SpeechPackage.toSpeech("Accounts & Summary");
        Navigator.of(context).push
          (new MaterialPageRoute
          (builder: (BuildContext context) => new transactions()));
      }
      else if (transcription.toLowerCase().contains('loans')) {
        SpeechPackage.toSpeech("Loans Pressed");
        Navigator.of(context).push
          (new MaterialPageRoute
          (builder: (BuildContext context) => new loans()));
      }
    });


    Widget _buildButtonBar() {
      List<Widget> buttons = [
        !isListening
            ? _buildIconButton(Icons.mic, _startRecognition, color: Colors.white, fab: true)
            : _buildIconButton(Icons.mic_off, _stopRecognition, color: Colors.white, backgroundColor: Colors.greenAccent, fab: true),
      ];
      Row buttonBar = new Row(mainAxisSize: MainAxisSize.min, children: buttons);
      return buttonBar;
    }


    Widget _buildIconButton(IconData icon, VoidCallback onPress,
        {Color color: Colors.grey,
          Color backgroundColor: Colors.pinkAccent,
          bool fab = false}) {
      return new Padding(
        padding: new EdgeInsets.all(12.0),
        child: fab
            ? new FloatingActionButton(
            child: new Icon(icon),
            onPressed: onPress,
            backgroundColor: backgroundColor)
            : new IconButton(
            icon: new Icon(icon, size: 32.0),
            color: color,
            onPressed: onPress),
      );
    }
  }





