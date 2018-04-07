import 'package:tts/tts.dart';

class SpeechPackage {
  static void toSpeech (String text){
    Tts.speak(text);
  }
}