import 'package:flutter/material.dart';
import '../../model/message_model.dart';
import './messageText.dart';
import './messageImg.dart';
import './messageSticker.dart';
import './messageFile.dart';

class Message extends StatelessWidget {
  MessageT message;

  Message(this.message);

  @override
  Widget build(BuildContext context) {
    print('=======> reRender');
    switch (message.type) {
      case 'info':
        return _renderNotification(message.message['text']);
      default:
        return message.out
            ? _renderSelfMessage(message)
            : _renderFriendMessage(message);
    }
  }
}

Widget _renderMessageContent(MessageT messageObj) {
  switch (messageObj.type) {
    case 'text':
      return MessageText(
          messageText: messageObj.message['text'], isOut: messageObj.out);
      break;
    case 'img':
      return MessageImg(
          img: ImgT.fromJson(messageObj.message['img']), isOut: messageObj.out);
      break;
    case 'thumb':
      return Text('this is thumb');
      break;
    case 'sticker':
      return MessageSticker(
          sticker: StickerT.fromJson(messageObj.message['sticker']),
          isOut: messageObj.out);
      break;
    case 'file':
      return MessageFile(
          file: FileT.fromJson(messageObj.message['file']),
          isOut: messageObj.out);
      break;
    case 'voice':
      return Text('this is voice');
      break;
    default:
      return Center(child: Text('暂不支持此类消息'));
  }
}

Widget _renderSelfMessage(MessageT messageObj) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7.5),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // 上
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      messageObj.uname,
                      style: TextStyle(
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              // 内容
              _renderMessageContent(messageObj)
            ],
          ),
        ),
        CircleAvatar(
          radius: 21.0,
          backgroundImage: NetworkImage(messageObj.avatar),
        ),
      ],
    ),
  );
}

Widget _renderFriendMessage(MessageT messageObj) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7.5),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 21.0,
          backgroundImage: NetworkImage(messageObj.avatar),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 上
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      messageObj.uname,
                      style: TextStyle(
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              // 内容
              _renderMessageContent(messageObj)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _renderNotification(String content) {
  const Color color = Color(0xFFA29F9F);
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      )
    ],
  );
}
