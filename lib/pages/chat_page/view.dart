import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:telegramr/models/message_model.dart';
import 'package:telegramr/widgets/messageMedia/message.dart';
import 'package:telegramr/widgets/messageMenu/messageMenuAudio.dart';
import 'package:telegramr/widgets/messageMenu/messageMenuSticker.dart';

import '../chatList.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(ChatState state, Dispatch dispatch, ViewService viewService) {
  // 渲染消息
  Widget _renderMessageItem(context, chatDataIndex, int index) {
    return renderMessage(context, chatDataIndex, index);
  }

  // 输入框
  Widget _renderBottomBar() {
    // setKeybordViewHeight();
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      constraints: BoxConstraints(minHeight: 50.0),
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(
            color: Color(0xFFBFBFBF),
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              focusNode: state.focusNode,
              controller: state.textEditingController,
              onChanged: (String text) =>
                  dispatch(ChatActionCreator.onTextFieldChanged(text)),

              /// TODO: 设置maxLines时会造成高度一定
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 0),
                hintText: "Type your message",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: state.textInput == '' ? Colors.grey : Colors.lightBlue,
                  size: 30,
                ),
                onPressed: () =>
                    dispatch(ChatActionCreator.handleSendMessage())),
          ),
        ],
      ),
    );
  }

  // 底部小菜单展开内容
  Widget _renderMenu() {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(
        milliseconds: 250,
      ),
      // TODO: 获取键盘高度
      // height: keyboardViewHeight,
      height: state.showMenu ? 230.0 : 0.0,
      child: state.showMenu
      ? Container(
          child: state.menuName == 'messageMenuAudio'
              ? MessageMeunAudio()
              : MessageMenuSticker())
      : Container(),
    );
  }

  // 底部小菜单渲染组件
  Widget _renderButtomMenuBarItem(IconData icon, Function func, {Color color = Colors.grey}) {
    return Material(
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
          size: 30,
        ),
        onPressed: func,
      ),
    );
  }

  // 底部小菜单渲染
  Widget _renderButtomMenuBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _renderButtomMenuBarItem(Icons.keyboard_voice,
              () => dispatch(ChatActionCreator.setMenuName('messageMenuAudio')),
              color: state.menuName == 'messageMenuAudio'
                  ? Colors.lightBlue
                  : Colors.grey),
          _renderButtomMenuBarItem(Icons.sentiment_satisfied,
              () => dispatch(ChatActionCreator.setMenuName('messageMenuSticker')),
              color: state.menuName == 'messageMenuSticker'
                  ? Colors.lightBlue
                  : Colors.grey
          ),
          _renderButtomMenuBarItem(Icons.image, () {}),
          _renderButtomMenuBarItem(Icons.photo_camera, () {}),
          _renderButtomMenuBarItem(Icons.insert_drive_file, () => () {}),
          _renderButtomMenuBarItem(Icons.control_point, () => () {}),
        ],
      )
    );
  }

  // main
  Widget _renderChatMain() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/wallpaper.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Container(
                //   child: Column(
                //     children: <Widget>[
                //       Text(state.count.toString()),
                //       RaisedButton(
                //         // Effect调用
                //         // onPressed: () => dispatch(ChatActionCreator.onAdd()),
                //         // reducer调用
                //         onPressed: () => dispatch(ChatActionCreator.add()),
                //         // onPressed: () => Navigator.pushNamed(context, '/request'),
                //         child: Icon(Icons.add),
                //       ),
                //       Text(state.messages == null ? '0' : state.messages.length.toString() ),
                //       RaisedButton(
                //         // reducer调用
                //         // action => reducer
                //         // onPressed: () => dispatch(ChatActionCreator.addMessage()),
                //        /// 调用
                /// Action: onFetchAction 调用=> Action: onFetch 映射=> Effect: _onFetch
                /// Effect: _onFetch 调用=> Action: didLoadAction 调用=> Action: didLoad
                /// Action: didLoad 映射 Reducer _onAddMessage
                //         onPressed: () => dispatch(ChatActionCreator.onFetchAction()),
                //         // onPressed: () => Navigator.pushNamed(context, '/request'),
                //         child: Icon(Icons.add),
                //       ),
                //     ],
                //   ),
                // ),
                child: state.messages == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: state.listScrollController,
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) => _renderMessageItem(
                            context, state.messages[index], index),
                      ),
              ),
            ),
            _renderBottomBar(),
            _renderButtomMenuBar(),
            _renderMenu(),
          ],
        )
      ],
    );
  }

  return WillPopScope(
    onWillPop: () => dispatch(ChatActionCreator.backPress()),
    child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Row(
            children: <Widget>[
              ClipOval(
                child: SizedBox(
                  width: 42.0,
                  height: 42.0,
                  child: CachedNetworkImage(
                    imageUrl: 'https://avatars1.githubusercontent.com/u/1935767?s=180&v=4',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'yorkie',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text('连接中...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: _renderChatMain(),
      ),
      )
    );
  }
