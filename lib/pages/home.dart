import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './chatList.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/xxx');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
