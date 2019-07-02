import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:telegramr/models/sticker_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/sticker.dart';

class MessageMenuSticker extends StatefulWidget {
  MessageMenuSticker({Key key}) : super(key: key);

  _MessageMenuStickerState createState() => _MessageMenuStickerState();
}

class _MessageMenuStickerState extends State<MessageMenuSticker>
    with SingleTickerProviderStateMixin {
  List<String> thumbs = [];
  List<StickerT> stickers = [];
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
    List<StickerT> temp = resData.map((json) => StickerT.fromJson(json)).toList();
    
    temp.forEach((v) => thumbs.add(v.thumb));
    setState(() {
      thumbs = thumbs;
      stickers = temp;
    });
  }

  @override
  void initState() {
    fetchMessage();
    // _tabController = TabController(vsync: this, length: thumbs.length);
    // _tabController.addListener(() {
    //   print(_tabController.index);
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return thumbs.length == null || thumbs.length == 0
    ? Center(child: CircularProgressIndicator())
    : DefaultTabController(
      length: thumbs.length, // Added
      initialIndex: 0, //Ad
      child: Container(
        child: Column(
          children: <Widget>[
            // TabBarView
            Container(
              height: 180.0,
              color: Color(0xFFF4F5F6),
              child: TabBarView(
                // controller: this._tabController,
                children: stickers.map((item) => GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      childAspectRatio: 1.0),
                      children: item.stickers.map((sticker) => GestureDetector(
                                                                  onTap: (){
                                                                    print(sticker.uri);
                                                                  },
                                                                  child: CachedNetworkImage(imageUrl: sticker.uri),
                                                                  )).toList(),
                  )).toList()
              ),
            ),
            // TabBar
            Container(
              height: 50.0,
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorWeight: 1.5,
                indicatorColor: Colors.lightBlue,
                isScrollable: true,
                labelColor: Color(0xFF00A6F9),
                indicatorPadding: EdgeInsets.all(0.0),
                indicatorSize: TabBarIndicatorSize.tab,
                // controller: this._tabController,
                tabs: List.generate(
                  thumbs.length,
                  (index) => Tab(
                      child: CachedNetworkImage(imageUrl: thumbs[index],
                          width: 30.0, height: 30.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
