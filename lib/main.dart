import 'package:flutter/material.dart';
import 'package:flutter_alfred/checkout/bag_screen.dart';
import 'package:flutter_alfred/login/LoginPage.dart';
import 'package:flutter_alfred/menu/item_page.dart';
import 'package:flutter_alfred/menu/nav_page.dart';

import 'package:flutter_alfred/qr_reader/qr_screen.dart';
import 'package:flutter_alfred/routes.dart';
// import 'package:flutter_alfred/theme.dart' as themes;

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  // .then((_) {
  runApp(new MyApp());
  // });
}

class MyApp extends StatelessWidget {

  // MyApp(){
  //   Routes.defineRoutes(router);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alfred',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme: themes.textTheme,
        primarySwatch: Colors.lightBlue,
      ),

      initialRoute: "/test",

      routes: {
        "/test": (context) => LoginPage(),
        homeRoute: (context) => MenuNavigation(),
        itemRoute: (context) => ItemPage(),
        cartRoute: (context) => CartScreen(),
        qrRoute: (context) => QRScreen()
      }      
    );
  }
}