import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/login/test.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:flutter_alfred/models/UserModel.dart';
import 'package:flutter_alfred/routes.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _loginUser(LoginData data) async {
    final String path = productionPath + "/login";
    Map<String, String> headers = {"Content-type": "application/json"};
    var json = jsonEncode({
      "email": data.name,
      "password": data.password
    });
    
    final response = await http.post(path,
      headers: headers,
      body: json
    );

    print(response.statusCode);
    print(response.body);
    var userData = jsonDecode(response.body)["user"];
    user = User.fromJson(userData);

    return null;
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name)) {
    //     return 'Username not exists';
    //   }
    //   if (users[data.name] != data.password) {
    //     return 'Password does not match';
    //   }  
    //   return null;
    // });
  }

  Future<String> _signUp(LoginData data) async {
    final String path = productionPath + "/user";
    Map<String, String> headers = {"Content-type": "application/json"};
    var json = jsonEncode({
      "email": data.name,
      "password": data.password
    });
    
    final response = await http.post(path,
      headers: headers,
      body: json
    );

    print(response.statusCode);
    print(response.body);
    var userData = jsonDecode(response.body)["user"];
    user = User.fromJson(userData);

    return null;
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name)) {
    //     return 'Username not exists';
    //   }
    //   if (users[data.name] != data.password) {
    //     return 'Password does not match';
    //   }  
    //   return null;
    // });
  }

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }  

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Alfred',
      // logo: 'assets/images/ecorp-lightblue.png',
      // logo: "assets/images/alucard.jpg",
      onLogin: _loginUser,
      onSignup: _signUp,
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => TestScreen(),
        // ));
        // Navigator.of(context).pushReplacementNamed(qrRoute,
        //   arguments: {
        //     "user": user
        //   }
        // );


        Restaurant restaurant = Restaurant(
          restaurantId: "5e29f3481c9d440000be868f",
          tableId: "Table 2"
        );

        Navigator.of(context).pushReplacementNamed(homeRoute,
          arguments: {
            "user": user,
            "restaurant": restaurant
          }
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}