import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/login/custom/swiper_controls.dart';
import 'package:flutter_alfred/routes.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {

  double size = 6.0;
  double activeSize = 6.0;
  double space = 10.0;

  final PageController _pageController = new PageController();
  PageIndicatorLayout layout = PageIndicatorLayout.SLIDE;
  List<PageIndicatorLayout> layouts = PageIndicatorLayout.values;
  bool loop = false;

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  Future<void> _pay() async {
    InAppPayments.setSquareApplicationId('sq0idp-_kKyxYaHI-WWjFt367OuzA');
    await InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
      onCardEntryCancel: _cardEntryCancel,
    );
  }

  void _cardEntryCancel() {
    // TODO: If User Cancels Card Entry, what happens?
  }

  void _cardNonceRequestSuccess(CardDetails result) async {
    print(result.nonce);

    try {
      InAppPayments.completeCardEntry(
        onCardEntryComplete: _cardEntryComplete
      );
    } catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }

  }

  void _cardEntryComplete() {
    // TODO: On Sucess
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

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
            onPressed: _pay,
          ),

          MaterialButton(
            child: Text("I'll do this later...", 
              style: TextStyle(color: Colors.white, fontSize: 14),),
            color: Colors.blueAccent,
            onPressed: (){
              // router.navigateTo(context, homeRoute,
              //   replace: false,
              //   transition: TransitionType.fadeIn,
              //   transitionDuration: const Duration(milliseconds: 200),
              // );
              Navigator.pushNamed(context, homeRoute);
            },
          ),

          Container()   
        ]),
      ),
    );

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      _nameSlide,
      _accountSlide,
      _cardSlide
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
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Hero(
                        tag: "logo",
                        child: AvatarGlow(
                          endRadius: 50,
                          duration: Duration(seconds: 2),
                          glowColor: Colors.white10,
                          repeat: true,
                          repeatPauseDuration: Duration(seconds: 2),
                          startDelay: Duration(seconds: 1),
                          child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: FlutterLogo(
                                  size: 35.0,
                                ),
                                radius: 35.0,
                              )),
                        ),
                      ),
                      Transform.rotate(
                          angle: -3 * pi / 2,
                          child: PageIndicator(
                            layout: layout,
                            size: size,
                            activeSize: activeSize,
                            controller: _pageController,
                            space: space,
                            count: children.length,
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