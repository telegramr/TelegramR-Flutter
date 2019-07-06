// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerItemT _$StickerItemTFromJson(Map<String, dynamic> json) {
  return StickerItemT(
      uri: json['uri'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      size: json['size'] as int,
      hash: json['hash'] as String,
      thumb_id: json['thumb_id'] as int);
}

Map<String, dynamic> _$StickerItemTToJson(StickerItemT instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'hash': instance.hash,
      'thumb_id': instance.thumb_id
    };

StickerT _$StickerTFromJson(Map<String, dynamic> json) {
  return StickerT(
      id: json['id'] as int,
      title: json['title'] as String,
      thumb: json['thumb'] as String,
      stickers: (json['stickers'] as List)
          ?.map((e) => e == null
              ? null
              : StickerItemT.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$StickerTToJson(StickerT instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumb': instance.thumb,
      'stickers': instance.stickers
    };
