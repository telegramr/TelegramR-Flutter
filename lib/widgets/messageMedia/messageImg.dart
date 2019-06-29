import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImgT {
  final String uri;
  final String hash;
  final int width;
  final int height;
  final int size;
  final bool isLocal;
  ImgT({
    this.uri,
    this.hash,
    this.width,
    this.height,
    this.size,
    this.isLocal,
  });

  factory ImgT.fromJson(Map<String, dynamic> json) {
    return ImgT(
        uri: json['uri'] as String,
        hash: json['hash'] as String,
        width: json['width'] as int,
        height: json['height'] as int,
        size: json['size'] as int,
        isLocal: json['isLocal'] as bool);
  }
}

Widget MessageImg(BuildContext context, {ImgT img, bool isOut = false}) {
  return Card(
    margin: EdgeInsets.only(top: 5.0),
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
              padding: EdgeInsets.all(4.0),
              child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width / 4 * 3 > 160
                    ? 160.0
                    : MediaQuery.of(context).size.width / 4 * 3,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(4.0),
                  child: img.isLocal
                      ? _renderLocalImg(context, img, isOut)
                      : _renderNetImg(context, img, isOut),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _renderLocalImg(BuildContext context, ImgT img, bool isOut) {
  return Image.file(
    File(img.uri),
  );
}

Widget _renderNetImg(BuildContext context, ImgT img, bool isOut) {
  return CachedNetworkImage(
    placeholder: (context, url) => Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          width: 100.0,
          height: 100.0,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
    errorWidget: (context, url, error) => Material(
          child: Image.asset(
            'images/img_not_available.jpeg',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          clipBehavior: Clip.hardEdge,
        ),
    imageUrl: img.uri,
  );
}
