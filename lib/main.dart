import 'package:flutter/material.dart';
import 'package:mybankingapp/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:mybankingapp/login.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:url_launcher/url_launcher.dart';



void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    routes: <String, WidgetBuilder>{
      "/settings": (BuildContext context)=> new settings(),
      "/login": (BuildContext context)=> new login()

    }

  ));
}
class MyApp extends StatefulWidget{
  _MyAppState createState() => new _MyAppState();
}

  class _MyAppState extends State<MyApp> {

//    SpeechRecognition _speech;
//
//    bool _speechRecognitionAvailable = true;
//    bool _isListening = false;
//
//    String transcription = '';
//
//    String _currentLocale = 'en_US';

    String _title = "Welcome! Login Please";
    Widget _screen;
    login _login;
    settings _settings;
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
//    Widget _buildDissmissibleBackground(
//        {Color color,
//          IconData icon,
//          FractionalOffset align = FractionalOffset.centerLeft}) =>
//        new Container(
//          height: 42.0,
//          color: color,
//          child: new Icon(icon, color: Colors.white70),
//          alignment: align,
//        );
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'login',
        home: new Scaffold(
          appBar: new AppBar(

            backgroundColor: Colors.indigoAccent,
            title: new Text(_title),

            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.home), onPressed: () {
                _gohome();

              }),
              new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                _logout();

              }),
            ],
          ),
          body:_login,
        ),
      );
    }
  }
//      return new MaterialApp(
//        title: 'login',
//        home: new Scaffold(
//        appBar: new AppBar(
//
//        backgroundColor: Colors.indigoAccent,
//        title: new Text(_title),
//
//        actions: <Widget>[
//        new IconButton(icon: new Icon(Icons.home), onPressed: () {
//        _gohome();
//
//        }),
//        new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
//        _logout();
//
//        }),
//
//
//        ],
//        ),
//          body: new Padding(
//              padding: new EdgeInsets.all(8.0),
//              child: new Center(
//                child: new Column(
//                  mainAxisSize: MainAxisSize.min,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: [
//                    new Expanded(
//                        child: new Container(
//                            padding: const EdgeInsets.all(5.0),
//                            color: Colors.grey.shade200,
//                            child: new Text(transcription))),
//                    _buildButton(
//                      onPressed: !_isListening ? () => abc() : null,
//                      label: _isListening
//                          ? 'Listening...'
//                          : 'Listen ($_currentLocale)',
//                    ),
//                    _buildButton(
//                      onPressed: _isListening ? () => cancel() : null,
//                      label: 'Cancel',
//                    ),
//                    _buildButton(
//                      onPressed: _isListening ? () => stop() : null,
//                      label: 'Stop',
//                    ),
//                  ],
//                ),
//              )),
//        ),
//      );
//    }
//
//    Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
//        padding: new EdgeInsets.all(12.0),
//        child: new RaisedButton(
//          color: Colors.cyan.shade600,
//          onPressed: onPressed,
//          child: new Text(
//            label,
//            style: const TextStyle(color: Colors.white),
//          ),
//        ));
//
//    void abc() {
//      setState(() => _isListening = true);
//      _speech.activate();
//      start();
//      return;
//    }
//
//      void start() => _speech
//          .listen(locale: _currentLocale)
//          .then((result) => print('_MyAppState.start => result ${result}'));
////          .then((result) => setState(() => _isListening = true ) );
//
//      void cancel() =>
//          _speech.cancel().then((result) => setState(() => _isListening = false));
//
//      void stop() =>
//          _speech.stop().then((result) => setState(() => _isListening = false));
//
//      void onSpeechAvailability(bool result) =>
//          setState(() => _speechRecognitionAvailable = result);
//
//      void onCurrentLocale(String locale) =>
//          setState(() => _currentLocale = locale);
//
//      void onRecognitionStarted() => setState(() => _isListening = true);
//
//      void onRecognitionResult(String text) => setState(() => transcription = text);
//
//      void onRecognitionComplete() => setState(() => _isListening = false);
//    }

//        return new MaterialApp(
//          title: 'login',
//          home: new Scaffold(
//            appBar: new AppBar(
//
//              backgroundColor: Colors.indigoAccent,
//              title: new Text(_title),
//
//              actions: <Widget>[
//                new IconButton(icon: new Icon(Icons.home), onPressed: () {
//                  _gohome();
//
//                }),
//                new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
//                  _logout();
//
//                }),
//
//
//              ],
//            ),
//            body: _login,
//          ),
//        );
//      }
//
//
