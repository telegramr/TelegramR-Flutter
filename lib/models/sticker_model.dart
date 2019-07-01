class StickerItemT {
  final String uri;
  final int width;
  final int height;
  final int size;
  final String hash;

  StickerItemT({this.uri, this.width, this.height, this.size, this.hash});

  factory StickerItemT.fromJson(Map<String, dynamic> json) {
    return StickerItemT(
      uri: json['uri'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      size: json['size'] as int,
      hash: json['hash'] as String,
    );
  }
}

class StickerT {
  final int id;
  final String title;
  final String thumb;
  final List<StickerItemT> stickers;

  StickerT({this.id, this.title, this.thumb, this.stickers});

  factory StickerT.fromJson(Map<String, dynamic> json) {
    return StickerT(
      id: json['id'] as int,
      title: json['title'] as String,
      thumb: json['thumb'] as String,
      stickers: json['stickers'] as List,
    );
  }
}
