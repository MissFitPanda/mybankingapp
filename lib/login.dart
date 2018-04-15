import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'settings.dart';
import './speech_package.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import './recogniser.dart';


  class login extends StatefulWidget {

    login({ void onSubmit});

    @override
    _LoginAppState createState() => new _LoginAppState();
  }

  class _LoginAppState extends State<login>  {

//    const login({
//      Key key,
//      @required this.onSubmit,
//    }) : super(key: key);

    final VoidCallback onSubmit;
    static final TextEditingController _user = new TextEditingController();
    static final TextEditingController _pass = new TextEditingController();


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

    final String SubmitButtonValue = "Submit";

    String get username => _user.text;

    String get password => _pass.text;

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


    @override
    Widget build(BuildContext context) {
      return new Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          new TextField(controller: _user,
            decoration: new InputDecoration(hintText: 'Enter Username',border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(0.0),
              ),
              borderSide: new BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),),),
          new TextField(controller: _pass,
            decoration: new InputDecoration(hintText: 'Enter Password',border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(0.0),
              ),
              borderSide: new BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),),
            obscureText: true,),
          new Divider(height: 15.0,color: Colors.white),
          new Divider(height: 15.0,color: Colors.white,),
          new RaisedButton(
              child: new Text(SubmitButtonValue,style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              color: Colors.indigoAccent,
              onPressed: () async {
//                  SpeechPackage.toSpeech("login successfull");
                  Navigator.of(context).push
                  (new MaterialPageRoute
                  (builder: (BuildContext context) => new settings()));
                }
          ),

          _buildButtonBar()
        ],
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
      if (transcription.toLowerCase().contains('submit')) {
        SpeechPackage.toSpeech("login pressed");
        Navigator.of(context).push
          (new MaterialPageRoute
          (builder: (BuildContext context) => new settings()));
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
