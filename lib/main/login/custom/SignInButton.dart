import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/routes/router.dart';

class SignInButton extends StatefulWidget {
  final String text;
  final GestureTapUpCallback onTapUp;
  final GestureTapDownCallback onTapDown;

  SignInButton({
    this.text,
    this.onTapUp,
    this.onTapDown,
    Key key
  }) : super(key: key);

  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> with SingleTickerProviderStateMixin {

  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    var transition = (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
        return Stack(children: <Widget>[
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, -1.0),
              ).animate(animation),
              child: this.widget,
            ),
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            )
          ],
        );
      };

    router.navigateTo(context, signUpRoute,
      replace: true,
      transition: TransitionType.custom,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: transition,
    );
  }

  @override
  Widget build(BuildContext context) {

    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapUp: this.widget.onTapUp ?? this._onTapUp,
      onTapDown: this.widget.onTapDown ?? this._onTapDown,
      child: Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10*_scale, offset: Offset(0, 10))],
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),          
        child: Center(
          child: Text(
            "Hi Alfred",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2)
            ),
          ),
        )
      ),
    );
  }
}