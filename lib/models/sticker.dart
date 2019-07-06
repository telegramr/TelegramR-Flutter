// see https://flutter-academy.com/work-with-json-in-flutter-part-2-json-serializable/
import 'package:json_annotation/json_annotation.dart';

part 'sticker.g.dart';

@JsonSerializable()
class StickerItemT {
  final String uri;
  final int width;
  final int height;
  final int size;
  final String hash;
  final int thumb_id;

  StickerItemT({this.uri, this.width, this.height, this.size, this.hash, this.thumb_id});

  factory StickerItemT.fromJson(Map<String, dynamic> json) => _$StickerItemTFromJson(json);
  Map<String, dynamic> toJson() => _$StickerItemTToJson(this);
}

@JsonSerializable()
class StickerT {
  final int id;
  final String title;
  final String thumb;
  final List<StickerItemT> stickers;

  StickerT({this.id, this.title, this.thumb, this.stickers});

  factory StickerT.fromJson(Map<String, dynamic> json) => _$StickerTFromJson(json);

  // //反序列化
  // factory StickerT.fromJson(Map<String, dynamic> json) => _$StickerTFromJson(json);
  // //序列化
  // Map<String, dynamic> toJson() => _$StickerTToJson(this);
}

