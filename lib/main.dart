import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alfred/routes/router.dart';
import 'package:flutter_alfred/theme.dart' as themes;

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  // .then((_) {
  runApp(new MyApp());
  // });
}

class MyApp extends StatelessWidget {

  MyApp(){
    Routes.defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alfred',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme: themes.textTheme,
        primarySwatch: Colors.lightBlue,
      ),
      // initialRoute: loginRoute,
      initialRoute: testRoute,
      onGenerateRoute: router.generator,
    );
  }
}