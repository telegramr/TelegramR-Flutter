import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegramr/models/sticker_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class MessageMenuSticker extends StatefulWidget {
  MessageMenuSticker({Key key}) : super(key: key);

  _MessageMenuStickerState createState() => _MessageMenuStickerState();
}

class _MessageMenuStickerState extends State<MessageMenuSticker>
    with SingleTickerProviderStateMixin {
  List stickers = [];
  List<StickerItemT> stickersThumb = [];
  int showStickerIndex = 0;

  TabController _tabController;

  Future<String> _loadChatJsonData() async {
    return await rootBundle.loadString('assets/stickerData.json');
  }

  // 本地调用json数据
  Future fetchMessage() async {
    String jsonString = await _loadChatJsonData();
    List resData = json.decode(jsonString);
    List temp = resData.map((json) => StickerT.fromJson(json)).toList();
    print(temp.toList());
    List thumbs = temp.map((v) => v['thumb']);
    print(thumbs.toList());
    setState(() {
      // stickersThumb = temp.map((v) => v['thumb']);
      stickers = resData.map((json) => StickerT.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    fetchMessage();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener((){print(_tabController.index);});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,  // Added
      initialIndex: 0, //Ad
      child: Container(
      child: Column(
        children: <Widget>[
          // TabBarView
          Container(
            height: 180.0,
            color: Color(0xFFF4F5F6),
            child: TabBarView(
              controller: this._tabController,
              children: <Widget>[
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 1.0
                  ),
                  children: <Widget>[
                     Image.network('https://i0.hdslb.com/bfs/album/1ed54435efcef302bb5582d49447c7d0d75d1a99.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/1af4d7b6e578b485a611ecfff0ee49626ac0d75a.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/020b87c07f6e304750bf6f73fd5c271c3118a708.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/3ddf77cf601431bea568c38ae3d80bc341ca6e1a.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/1821a0c7cc6304bde4cc2e39e2a50b8a2e5a27c1.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/dedbb88fb4ce6085e5b2b710acd2f49be35e9d28.jpg'),
                     Image.network('https://i0.hdslb.com/bfs/album/1d0480153e7f5957c792d40b4f3570cbb6f6a416.jpg@2000w_1e.webp'),
                  ],
                ),
                //  Center(
                //   child: Text('this is BBBBB'),
                // ),
                Center(
                  child: Text('this is BBBBB'),
                ),
                Center(
                  child: Text('this is CCCC'),
                ),
                Center(
                  child: Text('this is DDDD'),
                ),
                 Center(
                  child: Text('this is EEEE'),
                ),
              ],
            ),
          ),
          // TabBar
          Container(
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: TabBar(
              indicatorWeight: 1.5,
              indicatorColor:  Color(0xFF808080),
              isScrollable: true,
              labelColor: Color(0xFF00A6F9),
               indicatorPadding: EdgeInsets.all(0.0),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: this._tabController,
              tabs: <Widget>[
                Tab(
                  child: _renderTabItemImg('https://i0.hdslb.com/bfs/album/1ed54435efcef302bb5582d49447c7d0d75d1a99.jpg')
                ),
                Tab(
                  child: _renderTabItemImg('https://i0.hdslb.com/bfs/vip/ce49073ff96606a1a2674b3b4ef8e15fb0a399ff.png')
                ),
                Tab(
                  child: _renderTabItemImg('https://i0.hdslb.com/bfs/vip/f52830f0c01a4dc91457be5bb2ee49b1b5692cd5.png@44w_44h.webp')
                ),
                Tab(
                  child: _renderTabItemImg('https://i0.hdslb.com/bfs/vip/2afa12abaad687ee1be56447eb9aa26deba067db.png@44w_44h.webp')
                ),
                 Tab(
                  child: _renderTabItemImg('https://i0.hdslb.com/bfs/vip/1dfe73e00f40ca42789602e8ee53b58c4f75a838.jpg@44w_44h.webp')
                ),
              ],
            ),
          )
        ],
      ),
    ),
    );
  }

  Widget _renderTabItemImg(String url) {
    return Image.network(url, width: 30.0, height: 30.0);
  }
}
