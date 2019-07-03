import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
// import 'package:telegramr/models/message_model.dart';

import 'state.dart';
import 'action.dart';

Reducer<ChatState> buildReducer() {
  return asReducer<ChatState>(<Object, Reducer<ChatState>>{
    ChatAction.add: _add,
    ChatAction.didLoad: _onAddMessage,
    ChatAction.onTextInput: _onTextInput,
    ChatAction.sendMessage: _sendMessage,
    // ChatAction.goButtom: _goButtom,
  });
}

ChatState _add(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.count = ++state.count;
  return newState;
}

// 添加 mesages 数据
ChatState _onAddMessage(ChatState state, Action action) {
  final ChatState newState = state.clone();
  List mesages = action.payload;
  newState.messages = mesages;
  // return state.clone()
  //   ..messages = mesages;
  return newState;
}

// 设置textInput
ChatState _onTextInput(ChatState state, Action action) {
  // TODO: textInput 只能单个输入
  final ChatState newState = state.clone();
  String textInput = action.payload;
  newState.textInput += textInput;
  print(textInput);
  return newState;
}

// 发送消息
ChatState _sendMessage(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.messages.insert(0, action.payload);
  return newState;
}

// 返回到底部
// ChatState _goButtom(ChatState state, Action action) {
//   final ChatState newState = state.clone();
//   newState.listScrollController.animateTo(0.0,
//         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//   return newState;
// }

