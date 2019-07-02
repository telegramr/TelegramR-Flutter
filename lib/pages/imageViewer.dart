// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';

// class ZoomImageDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Column(children: <Widget>[
//       AppBar(
//         title: Text("zoom/pan image demo"),
//       ),
//       Expanded(
//         child: ExtendedImage.network(
//           'https://avatars0.githubusercontent.com/u/29087203?s=460&v=4',
//           fit: BoxFit.contain,
//           //enableLoadState: false,
//           mode: ExtendedImageMode.Gesture,
//           initGestureConfigHandler: (state) {
//             return GestureConfig(
//                 minScale: 0.9,
//                 animationMinScale: 0.7,
//                 maxScale: 3.0,
//                 animationMaxScale: 3.5,
//                 speed: 1.0,
//                 inertialSpeed: 100.0,
//                 initialScale: 1.0,
//                 inPageView: false);
//           },
//         ),
//       )
//     ]));
//   }
// }


// see https://stackoverflow.com/questions/54055187/show-fullscreen-image-ontap-in-flutter
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('this is image viewer page'),
      ),
      body: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl:  'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
              // placeholder: new CircularProgressIndicator(),
              // errorWidget: new Icon(Icons.error),
            ),
          ),
        ),
    );
  }
}
