import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:telegramr/models/message_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


import 'state.dart';
import 'action.dart';

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    Lifecycle.initState: _init,
    ChatAction.onAdd: _onAdd,
    // 对应onFetch
    ChatAction.onFetch: _onFetch,
    ChatAction.handleSendMessage: _handleSendMessage,
    ChatAction.onBackPress: _onBackPress,
    ChatAction.getImage: _getImage
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
    ctx.dispatch(ChatActionCreator.didBackPress());
  } else {
    Navigator.pop(ctx.context);
  }
  return Future.value(false);
}


// 图片上传
Future _getImage(Action action, Context<ChatState> ctx) async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  var newMessage = {
    "id": 1,
    "from_id": 1,
    "to_id": 2,
    "out": true,
    "uname": "Beats0",
    "avatar": "https://avatars0.githubusercontent.com/u/29087203?s=460&v=4",
    "message": {
      "img": {
        "uri": image.path,
        // "uri": "https://pic.xiami.net/webh5/files/xiamiWeb/44a518a363e48baa251b29deace29013-354x341.gif",
        "hash": image.hashCode.toString(),
        "width": decodedImage.width,
        "height": decodedImage.height,
        "size": 1024,
        "isLocal": true
      }
    },
    "date": 1559377920312,
    "type": "img"
  };
  ctx.dispatch(ChatActionCreator.handleSendOtherMessage(newMessage));
 }
  
// sticker
Future _sendSticker(Action action, Context<ChatState> ctx) async {
  var newMessage = {
    "id": 1,
    "from_id": 1,
    "to_id": 2,
    "out": true,
    "uname": "Beats0",
    "avatar": "https://avatars0.githubusercontent.com/u/29087203?s=460&v=4",
    "message": {
      "sticker": {
        "uri": "https://raw.githubusercontent.com/galmoe/sticker/master/sticker/271296361570369536.png",
        "hash": "",
        "width": 150,
        "height": 150,
        "size": 1024,
        "isLocal": false,
        "thumb_id": 1
      }
    },
    "date": 1559377920312,
    "type": "sticker"
  };
  ctx.dispatch(ChatActionCreator.handleSendOtherMessage(newMessage));
 }
  