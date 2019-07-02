import 'package:flutter/material.dart';

class MessageMeunAudio extends StatefulWidget {
  MessageMeunAudio({Key key}) : super(key: key);

  _MessageMeunAudioState createState() => _MessageMeunAudioState();
}

class _MessageMeunAudioState extends State<MessageMeunAudio> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('this is voice'),
    );
  }
}