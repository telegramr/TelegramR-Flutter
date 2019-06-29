import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StickerT {
  final String uri;
  final String hash;
  final int width;
  final int height;
  final int size;
  final bool isLocal;
  final int thumb_id;
  StickerT({
    this.uri,
    this.hash,
    this.width,
    this.height,
    this.size,
    this.isLocal,
    this.thumb_id,
  });

  factory StickerT.fromJson(Map<String, dynamic> json) {
    return StickerT(
        uri: json['uri'] as String,
        hash: json['hash'] as String,
        width: json['width'] as int,
        height: json['height'] as int,
        size: json['size'] as int,
        isLocal: json['isLocal'] as bool,
        thumb_id: json['thumb_id'] as int);
  }
}

Widget MessageSticker(BuildContext context,
    {StickerT sticker, bool isOut = false}) {
  double maxWidth = MediaQuery.of(context).size.width / 4 * 3 > 160
      ? 160.0
      : MediaQuery.of(context).size.width / 4 * 3;

  return Container(
    margin: EdgeInsets.only(top: 5.0),
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
            padding: EdgeInsets.all(2.0),
            child: LimitedBox(
                maxWidth: sticker.width.toDouble() > maxWidth
                    ? maxWidth
                    : sticker.width.toDouble(),
                child: sticker.isLocal
                    ? _renderLocalImg(context, sticker, isOut)
                    : _renderNetImg(context, sticker, isOut)),
          ),
        ],
      ),
    ),
  );
}

Widget _renderLocalImg(BuildContext context, StickerT img, bool isOut) {
  return Image.file(File(img.uri));
}

Widget _renderNetImg(BuildContext context, StickerT img, bool isOut) {
  return CachedNetworkImage(
    placeholder: (context, url) => Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          width: 100.0,
          height: 100.0,
          padding: EdgeInsets.all(30.0),
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
