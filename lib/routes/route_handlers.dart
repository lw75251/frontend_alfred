import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/bag_screen.dart';
import 'package:flutter_alfred/main/login_screen.dart';
import 'package:flutter_alfred/main/main_screen.dart';
import 'package:flutter_alfred/main/menu_screen.dart';


Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  });

Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MainScreen();
  });

Handler menuHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MenuScreen();
  });

Handler checkoutHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return CheckoutScreen();
  });  