import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/main_screen.dart';
import 'package:flutter_alfred/routes/router.dart';
import 'package:flutter_alfred/utils/fluro.dart';


Handler welcomeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Container();
  });

Handler mainHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Container();
  });

Handler optionsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {

    // Map data = {"header": params["header"][0], "img": params["img"][0]};
    Map data = FluroUtils.paramsToMap(optionsRoute, params);
    return Container();
  });

Handler gameHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {

    // Map Data: header, difficulty
    Map data = FluroUtils.paramsToMap(gameRoute, params);
    return Container();
  });  