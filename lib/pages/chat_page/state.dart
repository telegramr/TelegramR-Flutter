import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class ChatState implements Cloneable<ChatState> {
  int count = 0;
  TextEditingController textEditingController = TextEditingController();
  ScrollController listScrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  
  String textInput = '';
  List messages;
  List imgList = List<File>();
  bool showMenu = false;
  String menuName = '';
  double keyboardViewHeight = 0.0;

  @override
  ChatState clone() {
    return ChatState()
    ..count = count
    ..messages = messages
    ..menuName = menuName
    ..textInput = textInput
    ..textEditingController = textEditingController
    ..listScrollController = listScrollController
    ..focusNode = focusNode;
  }
}

ChatState initState(Map<String, dynamic> args){
  return ChatState();
}