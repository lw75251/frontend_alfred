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



const String loginRoute = "/login";
const String signUpRoute = "/signup";
const String homeRoute = "/";
const String qrRoute = "/scan";
const String menuRoute = "/menu";
const String checkoutRoute = "/checkout";

const String testRoute = "/test";

final router = Router();

class Routes {
  static void defineRoutes(Router router) {

    router.define(testRoute, handler: testHandler);

    router.define(loginRoute, handler: loginHandler);
    router.define(signUpRoute, handler: signUpHandler);
    router.define(homeRoute, handler: homeHandler);
    router.define(qrRoute, handler: qrHandler);
    router.define(menuRoute, handler: menuHandler, transitionType: TransitionType.inFromRight);
    router.define(checkoutRoute, handler: checkoutHandler, transitionType: TransitionType.fadeIn);
  }
}