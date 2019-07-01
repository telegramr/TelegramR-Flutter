import 'dart:async';
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;
// import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:telegramr/widgets/messageMenu/messageMenuSticker.dart';

import '../models/message_model.dart';
import '../widgets/messageMedia/message.dart';

class ChatPage extends StatefulWidget {
  final String title;

  const ChatPage({Key key, this.title}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  List messages;
  List imgList = new List<File>();
  bool showMenu = false;
  String menuName = '';
  double keyboardViewHeight = 0.0;

  // 上传多个图片
  // List<Asset> images = List<Asset>();
  // String _error = 'No Error Dectected';

  // api聊天数据
  Future<String> _loadChatJsonData() async {
    return await rootBundle.loadString('assets/chatData.json');
  }

  // 本地调用json数据
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
    // 反转
    List reversedMessages =
        resData.map((json) => MessageT.fromJson(json)).toList();
    setState(() {
      messages = reversedMessages.reversed.toList();
    });
  }

  // 图片上传
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File image = new File('image.png'); // Or any other way to get a File instance.
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

    messages.insert(0, MessageT.fromJson(newMessage));
    setState(() {
      messages;
    });
    this.goButtom();
    // setState(() {
    //   imgList.add(image);
    // });
  }

  // 获取图片
  Future<void> loadAssets({
    bool enableCamera = true,
  }) async {
    // setState(() {
    //   images = List<Asset>();
    // });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: enableCamera,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (error == null) print('No Error Dectected');
    print(resultList.toString());
    // setState(() {
    //   // images = resultList;
    //   if (error == null) print('No Error Dectected');
    // });
  }

  // 按键返回
  Future<bool> onBackPress() {
    if (showMenu) {
      setState(() {
        showMenu = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  // 底部
  void goButtom() {
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  // 输入信息
  void _textFieldChanged(String content) {}

  // 发送文字消息
  void sendMessage(String content) {
    if (content.trim() == '') return;
    textEditingController.clear();
    var newMessage = {
      "id": 1,
      "from_id": 1,
      "to_id": 2,
      "out": true,
      "uname": "Beats0",
      "avatar": "https://avatars0.githubusercontent.com/u/29087203?s=460&v=4",
      "message": {"text": content},
      "date": 1559377920312,
      "type": "text"
    };
    messages.insert(0, MessageT.fromJson(newMessage));
    setState(() {
      messages;
    });
    this.goButtom();
  }

  @override
  void initState() {
    fetchMessage();
    // keyboardViewHeight = MediaQuery.of(context).viewInsets.bottom;
    focusNode.addListener(onFocusChange);
    super.initState();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      print('hasFocus');
      // Hide sticker when keyboard appear
      setState(() {
        showMenu = false;
      });
    }
  }

  void setMenuVisiable() {
    focusNode.unfocus();
    setState(() {
      showMenu = !showMenu;
    });
  }

  void setMenuName(String _menuName) {
    if(menuName == _menuName) {
      setMenuVisiable();
      return;
    }
    if(_menuName == 'messageMenuAudio' || _menuName == 'messageMenuSticker') {
      setMenuVisiable();
    }
  }

  void setKeybordViewHeight() {
    if (MediaQuery.of(context).viewInsets.bottom <= keyboardViewHeight) return;
    setState(() {
      keyboardViewHeight = MediaQuery.of(context).viewInsets.bottom;
    });
  }

  Widget _renderMessageItem(chatDataIndex, int index) {
    return renderMessage(context, chatDataIndex, index);
  }

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   /*横向拖动的开始状态*/
    //   onHorizontalDragStart: (startDetails) {
    //     print(startDetails);
    //   },
    //   onHorizontalDragUpdate: (width) {
    //     print('滑动距离$width');
    //     if(width.globalPosition.dx > 1.0) {
    //       Navigator.of(context).pop();
    //     }
    //   },
    //   /*横向拖动的结束状态*/
    //   // onHorizontalDragEnd: (endDetails) {
    //   //   print(endDetails);
    //   //   Navigator.of(context).pop();
    //   // },
    //   child: Scaffold(
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 21.0,
                backgroundImage: NetworkImage(
                    'https://avatars1.githubusercontent.com/u/1935767?s=180&v=4'),
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
      body: _renderChatMain(),
      // floatingActionButton: _renderFloatingBtn()
    );
  }

  Widget _renderFloatingBtn() {
    return Container(
      transform: Matrix4.translationValues(8.0, 0.0, 0.0),
      width: 40.0,
      height: 150.0,
      child: Column(
        children: <Widget>[
          Container(
              child: Column(
            children: <Widget>[
              FloatingActionButton(
                elevation: 1.0,
                highlightElevation: 1.0,
                child: Icon(
                  Icons.alternate_email,
                  color: Colors.grey,
                ),
                onPressed: goButtom,
                backgroundColor: Colors.white,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                transform: Matrix4.translationValues(0.0, -55.0, 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lightBlue,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
            ],
          )),
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            child: FloatingActionButton(
              elevation: 1.0,
              highlightElevation: 1.0,
              child: Icon(
                Icons.arrow_downward,
                color: Colors.grey,
              ),
              onPressed: goButtom,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _renderChatMain() {
    return WillPopScope(
      child: Stack(
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
                  child: messages == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: listScrollController,
                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 7.0),
                          itemCount: messages.length,
                          itemBuilder: (context, index) =>
                              _renderMessageItem(messages[index], index),
                        ),
                ),
              ),
              _renderBottomBar(),
              _renderButtomMenuBar(),
              _renderMenu(),
            ],
          )
        ],
      ),
      onWillPop: onBackPress,
    );
  }

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
          // Material(
          //   color: Colors.white,
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.image,
          //       color: Colors.grey,
          //       size: 30,
          //     ),
          //     onPressed: getImage,
          //   ),
          // ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              focusNode: focusNode,
              controller: textEditingController,
              onChanged: _textFieldChanged,

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
          // Material(
          //   color: Colors.white,
          //   child: Transform.rotate(
          //     angle: math.pi / 6,
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.attach_file,
          //         color: Colors.grey,
          //         size: 30,
          //       ),
          //       onPressed: setMenuVisiable,
          //     ),
          //   ),
          // ),
          Material(
            color: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                sendMessage(textEditingController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderButtomMenuBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _renderButtomMenuBarItem(Icons.keyboard_voice, () => setMenuName('messageMenuAudio')),
        _renderButtomMenuBarItem(Icons.sentiment_satisfied, () => setMenuName('messageMenuSticker')),
        _renderButtomMenuBarItem(Icons.image, setMenuVisiable),
        _renderButtomMenuBarItem(Icons.photo_camera, setMenuVisiable),
        _renderButtomMenuBarItem(Icons.insert_drive_file, setMenuVisiable),
        _renderButtomMenuBarItem(Icons.control_point, setMenuVisiable),
      ],
    ));
  }

  Widget _renderButtomMenuBarItem(IconData icon, Function func) {
    return Material(
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.grey,
          size: 30,
        ),
        onPressed: func,
      ),
    );
  }

  Widget _renderMenu() {
     return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(
        milliseconds: 250,
      ),
      // TODO: 获取键盘高度
      // height: keyboardViewHeight,
      height: showMenu ? 230.0 : 0.0,
      child: Container(
        child: MessageMenuSticker(),
      ),
     );
  }
}
