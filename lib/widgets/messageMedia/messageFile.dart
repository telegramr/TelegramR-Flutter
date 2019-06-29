import 'dart:io';

import 'package:flutter/material.dart';

class FileT {
  final String uri;
  final String hash;
  final int size;
  final bool isLocal;
  FileT({
    this.uri,
    this.hash,
    this.size,
    this.isLocal,
  });

  factory FileT.fromJson(Map<String, dynamic> json) {
    return FileT(
      uri: json['uri'] as String,
      hash: json['hash'] as String,
      size: json['size'] as int,
      isLocal: json['isLocal'] as bool,
    );
  }
}

Widget MessageFile(BuildContext context, {FileT file, bool isOut = false}) {
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
            padding: EdgeInsets.all(5),
            child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width - 160.0,
                child: file.isLocal
                    ? _renderLocalFile(context, file, isOut)
                    : _renderFile(context, file, isOut)),
          ),
        ],
      ),
    ),
  );
}

Widget _renderLocalFile(BuildContext context, FileT file, bool isOut) {}

Widget _renderFile(BuildContext context, FileT file, bool isOut) {
  return Row(
    children: <Widget>[
      Container(
        width: 80.0,
        height: 80.0,
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(right: 10.0),
        color: Color(0xFFEBF0F5),
        child: FlatButton(
          onPressed: () {},
          color: Color(0xFFA2B8C8),
          child: new Icon(
            Icons.file_download,
            color: Colors.white,
            size: 20.0,
          ),
          shape: new CircleBorder(),
        ),
      ),
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width - 260,
        maxHeight: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                'image_2018-09-18-14-35-25.png',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Color(0xFF4E9AD4),
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text('27.5KB PNG',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  )),
            )
          ],
        ),
      )
    ],
  );
}
