import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
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
    // ChatAction.onBackPress: _onBackPress,
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
  
  // addListener输入框焦点控制
  ctx.state.focusNode.addListener(() => {
    if(ctx.state.focusNode.hasFocus) {
      ctx.dispatch(ChatActionCreator.onFocus())
    }
  });
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
  ctx.dispatch(ChatActionCreator.add());
}

// 发送消息
void _handleSendMessage(Action action, Context<ChatState> ctx) {
  if(ctx.state.textInput.trim() != '') {
    ctx.dispatch(ChatActionCreator.sendMessage(ctx.state.textInput));
  }
}

// 物理按键返回
Future<bool> _onBackPress(Action action, Context<ChatState> ctx) {
  if (ctx.state.showMenu) {
    ctx.dispatch(ChatActionCreator.onBackPress());
  } else {
    Navigator.pop(ctx.context);
  }
  return Future.value(false);
}
  