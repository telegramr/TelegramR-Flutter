import 'package:flutter/material.dart';


class MessageText extends StatelessWidget {
  /// [messageText = '']   文本消息内容
  /// [isOut = false ]     是否为本人信息
  
  final String messageText;
  final bool isOut;

  const MessageText({this.messageText = '', this.isOut = false, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
                 borderRadius: this.isOut
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: ClipRRect(
          borderRadius: this.isOut
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width - 160.0,
                  child: Text(
                    this.messageText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
