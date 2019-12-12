import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/checkout/bag_screen.dart';
import 'package:flutter_alfred/main/home/landing_page.dart';
import 'package:flutter_alfred/main/login/login_page.dart';
import 'package:flutter_alfred/main/login/signup_screen.dart';
import 'package:flutter_alfred/main/menu/me&u_page.dart';
import 'package:flutter_alfred/qr_reader/qr_screen.dart';


Handler testHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  });


Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  });

Handler signUpHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SignUpScreen();
  });

Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // return MainScreen();
    return HomePage();
  });

Handler qrHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return QRScreen();
  });

Handler menuHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MeAndUScreen();
  });

Handler checkoutHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return CheckoutScreen();
  });  