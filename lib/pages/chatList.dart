import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/chat_list_model.dart';


class ChatList extends StatefulWidget {
  ChatList({Key key}) : super(key: key);

  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  List chatListData;

    // api聊天列表数据
  Future<String> _loadChatJsonData() async {
    return await rootBundle.loadString('assets/chatList.json');
  }

  // json序列化
  Future fetchMessage() async {
    /// TODO: 网络请求json数据
    // Future fetchMessage() async {
    //   final String url = 'http://localhost:3001/api/chat/group/111';
    //   final response = await http.get(url);

    //   if (response.statusCode == 200) {
    //     List resData = json.decode(response.body);
    //     setState(() {
    //       messages = resData.map((json) => MessageT.fromJson(json)).toList();
    //     });
    //   } else {
    //     print("err code $response.statusCode");
    //   }
    // }
    String jsonString = await _loadChatJsonData();
    List resData = json.decode(jsonString);
    setState(() {
      chatListData = resData.map((json) => ChatListT.fromJson(json)).toList();
    });
  }

  Widget _renderListItem(ChatListT item, int index) {
    return RawMaterialButton(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black38, width: 0.2, style: BorderStyle.solid)),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8.0, right: 12.0, bottom: 8.0),
              child: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(item.avatar),
              ),
            ),
            Container(
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.uname,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('${item.date}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black38)),
                        ],
                      ),
                    ),
                    Container(
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            // TODO: 设置消息类型和内容
                            // item.message[],
                            item.type,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 16),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black26,
                              ),
                              child: Text(
                                '${item.unread}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/chat');
      },
    );
  }

  @override
  void initState() {
    fetchMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: chatListData == null
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: chatListData.length,
          shrinkWrap: true,
          itemBuilder:(context, index) => this._renderListItem(chatListData[index], index)),
    );
  }
}
