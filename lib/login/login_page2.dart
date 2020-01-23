import 'package:flutter/material.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {

  void _onButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            // ListTile
          ],
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}