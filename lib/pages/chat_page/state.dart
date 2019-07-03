import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class ChatState implements Cloneable<ChatState> {
  int count = 0;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  
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
    ..messages = messages;
  }
}

ChatState initState(Map<String, dynamic> args){
  //什么也没做，只是初始化数据
  return ChatState();
}