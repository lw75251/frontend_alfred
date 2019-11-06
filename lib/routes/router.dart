// import 'package:flutter/material.dart';
// import 'package:friendly/routes/undefined_view.dart';
// import 'package:friendly/ui/gradients.dart';
// import 'package:friendly/ui/login/landing.dart';
// import 'package:friendly/ui/login/slides.dart';

// const String LandingScreenRoute = '/';
// const String SignUpRoute = 'signup';

// class Router {
  

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case LandingScreenRoute:
//         return MaterialPageRoute(builder: (_) => LandingScreen());
//       case SignUpRoute:
//         return MaterialPageRoute(builder: (context) => FriendlySwiper());
//       default:
//         return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,));
//     }
//   }
// }

import 'package:fluro/fluro.dart';
import 'package:flutter_alfred/routes/route_handlers.dart';



const String welcomeRoute = "/";
const String optionsRoute = "/settings/:header/:img";
const String gameRoute = "/game/:header/:difficulty";

final router = Router();

class Routes {
  static void defineRoutes(Router router) {
    router.define(welcomeRoute, handler: mainHandler, transitionType: TransitionType.fadeIn);
    // router.define(optionsRoute, handler: optionsHandler, transitionType: TransitionType.fadeIn);
    // router.define(gameRoute, handler: gameHandler, transitionType: TransitionType.fadeIn);
  }
}