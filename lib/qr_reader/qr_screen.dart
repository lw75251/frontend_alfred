import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:flutter_alfred/models/UserModel.dart';
import 'package:flutter_alfred/qr_reader/custom/flutter_qr_reader.dart';
import 'package:flutter_alfred/qr_reader/custom/qr_reader_view.dart';
import 'package:flutter_alfred/routes.dart';
// import 'package:flutter_qr_reader/flutter_qr_reader.dart';
// import 'package:flutter_qr_reader/qrcode_reader_view.dart';

import 'package:permission_handler/permission_handler.dart';


class QRScreen extends StatefulWidget {
  QRScreen({Key key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> with SingleTickerProviderStateMixin {
  QrReaderViewController _controller;
  bool isOk = false;
  String data;
  User user;


  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();

  void getPermissions() async {
  Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    print(permissions);
    if (permissions[PermissionGroup.camera] == PermissionStatus.granted) {
      setState(() {
        isOk = true;
      });
    }    
  }

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  Future onScan(String data) async {
    var tableData = jsonDecode(data);
    Restaurant restaurant = Restaurant.fromJson(tableData);

    // User user = User(
    //   uid: "5e29ebf0f6302410ac820c80",
    //   brainTreeId: "574810489",
    //   email: "lw75251@gmail.com",
    //   firstName: "Leon",
    //   lastName: "Wu",
    //   phoneNumber: "123.456.7890"
    // );
    final Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    user = arguments["user"];    

    Navigator.pushReplacementNamed(context, homeRoute,
      arguments: {
        "user": user,
        "restaurant": restaurant
      }
    );

    // _key.currentState.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: QrcodeReaderView(
        key: _key,
        onScan: onScan,
        headerWidget: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }
}