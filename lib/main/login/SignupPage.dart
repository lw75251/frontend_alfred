import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/login/custom/NameSlide.dart';
import 'package:flutter_alfred/main/login/custom/swiper_controls.dart';
import 'package:flutter_alfred/routes/router.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class SignUpPage extends StatefulWidget {
  
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  // Controllers
  PageController _pageController;
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _pageController = new PageController();
    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget get _logo => Hero(
    tag: "logo",
    child: Container(
      margin: const EdgeInsets.only(top: 15.0, left: 8.0),
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: FlutterLogo(
            size: 40.0,
          ),
          radius: 30.0,
      )),
    ),
  );   

  Widget get _nameSlide => Container(
    color: Colors.blueGrey,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 22.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
        Text("Nice to meet you! What do your friends call you?", 
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        )),
        Container(child: TextField(
          controller: _nameController,
          style: TextStyle(color: Colors.white, fontSize: 30),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            border: InputBorder.none,
            hintText: 'They call me...',
            helperText: "YOUR NICKNAME",
            helperStyle: TextStyle(color: Colors.white, fontSize: 15),
            counterText: "0 / 32"
          )),
        ),  
        Container()
      ]),
    ),
  );

  Widget get _accountSlide => Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 22.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Text("Hi ${_nameController.text} - make an account and start ordering!", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          )),
          TextField( controller: _emailController,
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.white, fontSize: 20),
              border: InputBorder.none,
          )),
          TextField( controller: _passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white, fontSize: 20),
              border: InputBorder.none,
          )),
          Container()   
        ]),
      ),
    );

  Widget get _cardSlide => Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 22.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Text("Last thing - save a payment method!", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          )),
          MaterialButton(
            child: Text("Link a payment method", 
              style: TextStyle(color: Colors.white, fontSize: 18),),
            color: Colors.blueAccent,
            onPressed: null,
          ),

          MaterialButton(
            child: Text("I'll do this later...", 
              style: TextStyle(color: Colors.white, fontSize: 14),),
            color: Colors.blueAccent,
            onPressed: (){
              router.navigateTo(context, homeRoute,
                replace: false,
                transition: TransitionType.fadeIn,
                transitionDuration: const Duration(milliseconds: 200),
              );
            },
          ),

          Container()   
        ]),
      ),
    );

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      NameSlide(),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
            children: <Widget>[
              PageView(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: children,
              ),

                // Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                    
                // ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _logo,
                      Container(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Transform.rotate(
                            angle: -3 * pi / 2,
                            child: PageIndicator(
                              layout: PageIndicatorLayout.SLIDE,
                              size: 6.0,
                              activeSize: 6.0,
                              controller: _pageController,
                              space: 10.0,
                              count: children.length,
                            ),
                        ),
                      ),
                  ]),
                ),
                Align(alignment: Alignment.bottomRight,
                    child: SwiperControls(
                      slideController: _pageController,
                      itemCount: children.length,
                      size: 30,
                      padding: const EdgeInsets.all(0)
                    ),
                )
              ],
            ))
          ],
        ),
    );
  }
}