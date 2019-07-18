import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:telegramr/models/message_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:telegramr/models/sticker_model.dart';


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
    ChatAction.getImage: _getImage,
    ChatAction.showStickerDialog: _showStickerDialog
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

// sticker 预览菜单dialog
void _showStickerDialog(Action action, Context<ChatState> ctx) async {
  String jsonString = await rootBundle.loadString('assets/stickerData.json');

  // StickerT stickers;
  List resData = json.decode(jsonString);
  // println(resData);
  // stickers = resData[0];
  // resData.map((v) => {

  // });
  // List<StickerT> stickers = resData.map((json) => StickerT.fromJson(json));

  // print(resData[0]);
  // List resData = json.decode(jsonString);
  // List<StickerT> stickers = resData.map((json) => StickerT.fromJson(json)).toList();
  // StickerItemT sticker = stickers[0];
  double ctxWidth = MediaQuery.of(ctx.context).size.width;
  double stickerWidth = (ctxWidth - 40) / 5;
  Map sticker = {
    "id": 1,
    "title": '233',
    "thumb": "https://i0.hdslb.com/bfs/album/1ed54435efcef302bb5582d49447c7d0d75d1a99.jpg",
    "stickers": [{
      "uri": "https://i0.hdslb.com/bfs/album/1ed54435efcef302bb5582d49447c7d0d75d1a99.jpg",
      "width": 150,
      "height": 150,
      "hash": "",
      "size": 1024,
      "thumb_id": 1
    }, {
      "uri": "https://i0.hdslb.com/bfs/album/1af4d7b6e578b485a611ecfff0ee49626ac0d75a.jpg",
      "width": 150,
      "height": 150,
      "hash": "",
      "size": 1024,
      "thumb_id": 1
    }, {
      "uri": "https://i0.hdslb.com/bfs/album/020b87c07f6e304750bf6f73fd5c271c3118a708.jpg",
      "width": 150,
      "height": 150,
      "hash": "",
      "size": 1024,
      "thumb_id": 1
    }, {
      "uri": "https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg",
      "width": 150,
      "height": 150,
      "hash": "",
      "size": 1024,
      "thumb_id": 1
    }]
  };

  var result = await showDialog(
    context: ctx.context,
    builder: (ctx) {
      return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(ctx).size.width,
            height: MediaQuery.of(ctx).size.height / 2 + 50.0,
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  )
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                   Container(
                    height: 4.0,
                    width: 45.0,
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 214, 215, 218),
                        borderRadius: BorderRadius.all(const Radius.circular(5.0))),
                  ),
                  // sticker text
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('DuAng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        Container(
                          child: InkResponse(
                            onTap: () => Navigator.of(ctx).pop(1),
                            child: Icon(Icons.more_vert, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // sticker GridView
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    height: MediaQuery.of(ctx).size.height / 2 - 50.0,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                          childAspectRatio: 1.0),
                      children: <Widget>[
                         CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            width: 50.0),
                             CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            width: 50.0),
                             CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            width: 50.0),
                             CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            width: 50.0),
                             CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            width: 50.0),
                            CachedNetworkImage(
                            imageUrl: 'https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg',
                            ),
                      ]
                    )
                  ),
                  // sticker action buttom
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black38,
                                width: 0.2,
                                style: BorderStyle.solid)),
                          ),
                          alignment: Alignment.center,
                          width: ctxWidth,
                          height: 50.0,
                          child: Text('REMOVE 120 张贴纸', style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      );
    },
  );
  print("result = $result");
}
