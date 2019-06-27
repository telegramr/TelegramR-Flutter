// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../pages1/search.dart';

// final routes = {
//   '/search': (context, {arguments}) => SearchPage()
//   // '/search': (context, {arguments}) => SearchPage(arguments: arguments)
// };


// var onGenerateRoute = (RouteSettings settings) {
//   final String name = settings.name;
  
//   final Function pageContentBuilder = this.routes[name];
//   if(pageContentBuilder != null) {

//     if(settings.arguments != null) {
//       final Route  route = MaterialPageRoute(
//         builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
//         return route;
//     } else {
//       final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context))
//       return routes;
//     }
//     }
//   };