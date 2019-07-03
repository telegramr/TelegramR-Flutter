import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../chatList.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    HomeState state, Dispatch dispatch, ViewService viewService) {
  // return Scaffold(
  //   appBar: AppBar(
  //     title: Text('CounterFishRedux'),
  //   ),
  //   body: Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text('this is page 1'),
  //         Text(
  //           state.count.toString(),
  //         ),
  //         RaisedButton(
  //           onPressed: () => dispatch(CounterActionCreator.goToPage2()),
  //           // onPressed: () => Navigator.pushNamed(context, '/request'),
  //           child: Icon(Icons.share),
  //         )
  //       ],
  //     ),
  //   ),
  //   floatingActionButton: FloatingActionButton(
  //     //发送的action到了Effect中处理
  //     onPressed: () => dispatch(CounterActionCreator.onAdd()),
  //     //也可以发action到reducer中处理
  //     //onPressed: () => dispatch(CounterActionCreator.add()),
  //     tooltip: 'add',
  //     child: Icon(Icons.add),
  //   ),
  // );
  return Scaffold(
      appBar: AppBar(
        title: Text('TelegramR'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(0.0, 10.0),
            icon: Icon(Icons.add),
            itemBuilder: (_) {
              return [
                new PopupMenuItem(child: new Text('搜索'), value: '1'),
                new PopupMenuItem(child: new Text('扫一扫'), value: '1'),
                new PopupMenuItem(child: new Text('帮助与反馈'), value: '1'),
              ];
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ChatList(),
      drawer: Drawer(
        child: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                //      margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://ws1.sinaimg.cn/large/006nOlwNgy1fp0v3noihrj337b29eu0x.jpg'),
                      fit: BoxFit.cover),
                ),
                accountName: new Text(
                  "Beats0",
                ),
                accountEmail: new Text(
                  "Beats01998@gmail.com",
                ),
                currentAccountPicture: new CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        'https://avatars0.githubusercontent.com/u/29087203?s=460&v=4')),
                onDetailsPressed: () {},
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('个人'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('电话'),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('按钮'),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/xxx');
                },
              ),
            ],
          ),
        ),
      ),
    );
}