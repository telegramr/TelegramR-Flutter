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
    ChatAction.onSetMenuName: _onSetMenuName,
    ChatAction.onFocus: _onFocus,
    ChatAction.onBackPress: _onBackPress
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
  final ChatState newState = state.clone();
  String textInput = action.payload;
  newState.textInput = textInput;
  newState.showMenu = true;
  return newState;
}

// 发送消息
ChatState _sendMessage(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.textInput = '';
  newState.textEditingController.clear();
  newState.messages.insert(0, action.payload);
  newState.listScrollController.animateTo(0.0,
      duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  return newState;
}

// 设置菜单名称
ChatState _onSetMenuName(ChatState state, Action action) {
  final ChatState newState = state.clone();
  String menuName = action.payload;
  newState.menuName = menuName;

  if (menuName == 'messageMenuAudio' || menuName == 'messageMenuSticker') {
    /// 比较[oldState], 在展开的情况下, 点击同一个后隐藏
    if (state.showMenu && state.menuName == menuName) {
      newState.menuName = '';
      newState.showMenu = false;
      return newState;
    } else {
      newState.menuName = menuName;
      newState.showMenu = true;
      newState.focusNode.unfocus();
      return newState;
    }
  }
}

// 输入框焦点控制
ChatState _onFocus(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.menuName = '';
  newState.showMenu = false;
  return newState;
}

// 按键返回
ChatState _onBackPress(ChatState state, Action action) {
  final ChatState newState = state.clone();
  // 展开了菜单
  if(state.menuName == 'messageMenuAudio' || state.menuName == 'messageMenuSticker') {
    newState.menuName = '';
    newState.showMenu = false;
  }
  return newState;
}
