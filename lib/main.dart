import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff5682a3),
          backgroundColor: Color(0xffe7ebf0),
          accentColor: Color(0xff598fba),
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(
                  builder: (_) => HomePage(), settings: settings);
            case '/chat':
              return CupertinoPageRoute(
                  builder: (_) => ChatPage(), settings: settings);
          }
        }
    );
  }
}
