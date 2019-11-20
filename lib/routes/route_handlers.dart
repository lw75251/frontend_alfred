import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/bag_screen.dart';
import 'package:flutter_alfred/main/login_screen.dart';
import 'package:flutter_alfred/main/main_screen.dart';
import 'package:flutter_alfred/main/menu_screen.dart';
import 'package:flutter_alfred/main/qr_screen.dart';
import 'package:flutter_alfred/main/signup_screen.dart';


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
    return MainScreen();
  });

Handler qrHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return QRScreen();
  });


Handler menuHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MenuScreen();
  });

Handler checkoutHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return CheckoutScreen();
  });  