import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SourceHeroPage extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          uri: 'http://pic1.win4000.com/wallpaper/e/537ebd9b60603.jpg',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<Null>(
                builder: (BuildContext context) => DestinationHeroPage()));
          },
        ),
      ),
    );
  }
}

class DestinationHeroPage extends StatelessWidget {
  final String uri;
  // TODO: 添加 thumb 图片类型
  final List<String> thumb;

  DestinationHeroPage({Key key, this.uri = '', this.thumb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Flippers Page'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(0.0, 10.0),
            itemBuilder: (_) {
              return [
                PopupMenuItem(child: Text('保存'), value: '1'),
                PopupMenuItem(child: Text('分享'), value: '1'),
              ];
            },
          )
        ],
      ),
      body: Container(
        // The blue background emphasizes that it's a new route.
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: uri == ''
            ? Center(child: CircularProgressIndicator())
            : PhotoHero(
                uri: uri,
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.uri, this.onTap, this.width})
      : super(key: key);

  final String uri;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: uri,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: uri,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
