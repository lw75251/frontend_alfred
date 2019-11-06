import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alfred/main/login_screen.dart';
import 'package:flutter_alfred/main/main_screen.dart';
import 'package:flutter_alfred/routes/router.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {

  MyApp(){
    Routes.defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      initialRoute: loginRoute,
      onGenerateRoute: router.generator,
    );
  }
}