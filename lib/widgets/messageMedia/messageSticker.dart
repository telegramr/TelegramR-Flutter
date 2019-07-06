import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:telegramr/models/sticker.dart';

Widget MessageSticker(BuildContext context, {StickerItemT sticker, bool isOut = false}) {
  double maxWidth = MediaQuery.of(context).size.width / 4 * 3 > 160
      ? 160.0
      : MediaQuery.of(context).size.width / 4 * 3;

      // print(sticker.width.toDouble());
      // print(sticker.width.toDouble() > maxWidth);
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
                  child: CachedNetworkImage(
                    imageUrl: sticker.uri,
                  ))),
        ],
      ),
    ),
  );
}
