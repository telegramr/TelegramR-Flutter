import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:telegramr/models/message_model.dart';

import 'state.dart';
import 'action.dart';

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    Lifecycle.initState: _init,
    ChatAction.onAdd: _onAdd,
    // 对应onFetch
    ChatAction.onFetch: _onFetch,
    ChatAction.handleSendMessage: _handleSendMessage,
    ChatAction.goButtom: _goButtom,
    // ChatAction.onTextInput
  });
}


// api
Future<String> _loadChatJsonData() async {
  return await rootBundle.loadString('assets/chatData.json');
}

void _init(Action action, Context<ChatState> ctx) async {
  String jsonString = await _loadChatJsonData();
  List resData = json.decode(jsonString);
  List reversedMessages = resData.map((json) => MessageT.fromJson(json)).toList();
  ctx.dispatch(ChatActionCreator.didLoadAction(reversedMessages.reversed.toList()));
}

// 本地调用json数据
Future _onFetch(Action action, Context<ChatState> ctx) async {
  String jsonString = await _loadChatJsonData();
  List resData = json.decode(jsonString);
  List reversedMessages = resData.map((json) => MessageT.fromJson(json)).toList();
  ctx.dispatch(ChatActionCreator.didLoadAction(reversedMessages.reversed.toList()));
}

void _onAdd(Action action, Context<ChatState> ctx) {
  print("effect ChatActionCreator add()");
  ctx.dispatch(ChatActionCreator.add());
}

void _handleSendMessage(Action action, Context<ChatState> ctx) {
  ctx.dispatch(ChatActionCreator.sendMessage(ctx.state.textInput));
  // ctx.dispatch(ChatActionCreator.goButtom());
  // _goButtom(action, ctx);
}

void _goButtom(Action action, Context<ChatState> ctx) {
  print("effect _goButtom");
  ctx.state.listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
}