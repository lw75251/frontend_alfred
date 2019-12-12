import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/delayed_animation.dart';
import 'package:flutter_alfred/routes/router.dart';

class LoginPageDeprecated extends StatefulWidget {
  @override
  _LoginPageDeprecatedState createState() => _LoginPageDeprecatedState();
}

class _LoginPageDeprecatedState extends State<LoginPageDeprecated> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
          backgroundColor: Color(0xFF8185E2),
          body: Center(
            child: Column(
                children: <Widget>[
                  Hero(tag: "logo",
                    child: AvatarGlow(
                      endRadius: 90,
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
                              size: 50.0,
                            ),
                            radius: 50.0,
                          )),
                    ),
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Hi There",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    delay: delayedAmount + 1000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "I'm Alfred",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Your New Personal",
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Journaling  companion",
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  DelayedAnimation(
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
                SizedBox(height: 50.0,),
                  DelayedAnimation(
                    child: GestureDetector(
                      onTapDown: _onSignInTapDown,
                      onTapUp: _onSignInTapUp,
                      child: Text(
                        "I Already have An Account".toUpperCase(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                    ),
                    delay: delayedAmount + 5000,
                  ),
                ],
            ),
          )
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black38, blurRadius: 10*_scale, offset: Offset(0, 10))],
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Hi Alfred',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );

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

  void _onSignInTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onSignInTapUp(TapUpDetails details) {
    _controller.reverse();
    var transition = (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
        return Stack(children: <Widget>[
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(animation),
              child: this.widget,
            ),
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            )
          ],
        );
      };

    router.navigateTo(context, loginRoute,
      replace: true,
      transition: TransitionType.custom,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: transition,
    );
  }

}