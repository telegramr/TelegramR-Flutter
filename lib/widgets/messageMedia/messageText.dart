import 'package:flutter/material.dart';

Widget MessageText(BuildContext context, {String messageText = '', bool isOut = false}) {
  print('MessageText=====>');
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: isOut
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
        borderRadius: isOut
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
                  messageText,
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
