import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import './pages/home_page/page.dart';
import './pages/chat_page/page.dart';


void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Color(0xff5682a3),
//           backgroundColor: Color(0xffe7ebf0),
//           accentColor: Color(0xff598fba),
//         ),
//         onGenerateRoute: (RouteSettings settings) {
//           switch (settings.name) {
//             case '/':
//               return CupertinoPageRoute(
//                   builder: (_) => HomePage(), settings: settings);
//             case '/chat':
//               return CupertinoPageRoute(
//                   builder: (_) => ChatPage(), settings: settings);
//             case '/hero':
//               return CupertinoPageRoute(
//                   builder: (_) => SourceHeroPage(), settings: settings);
//             case '/imageViewer':
//               return CupertinoPageRoute(
//                   builder: (_) => ImageViewerPage(), settings: settings);
//           }
//         }
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Color(0xff5682a3),
//         backgroundColor: Color(0xffe7ebf0),
//         accentColor: Color(0xff598fba),
//       ),
//       home: FishReduxPageStateless(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  final AbstractRoutes routes = HybridRoutes(routes: <AbstractRoutes>[
    PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        '/': HomePage(),
        '/chat': ChatPage(),
        // 'counter_fish_redux2': CounterFishReduxPage2(),
      },
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff5682a3),
        backgroundColor: Color(0xffe7ebf0),
        accentColor: Color(0xff598fba),
      ),
      title: 'TelegramR',
      home: routes.buildPage('home', null),
      onGenerateRoute: (RouteSettings settings) {
        return CupertinoPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}