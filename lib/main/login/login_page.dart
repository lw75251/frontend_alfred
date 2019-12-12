import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/main/login/custom/SignInButton.dart';
import 'package:flutter_alfred/main/login/custom/SlidingFadeIn.dart';
import 'package:flutter_alfred/routes/router.dart';

class WhitespaceSeparator extends StatelessWidget {
  final double height;
  const WhitespaceSeparator({
    this.height = 20,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
    );
  }
}

class LoginPage extends StatelessWidget {

  LoginPage({Key key}) : super(key: key);

  final headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 35.0,
    color: Colors.white
  );

  final bodyStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.white
  );

  final _delay = 500;

  // Widget get _logo => Hero(
  //   tag: "logo",
  //   child: AvatarGlow(
  //     endRadius: 90,
  //     duration: Duration(seconds: 2),
  //     glowColor: Colors.white10,
  //     repeat: true,
  //     repeatPauseDuration: Duration(seconds: 2),
  //     startDelay: Duration(seconds: 1),
  //     child: Material(
  //         elevation: 8.0,
  //         shape: CircleBorder(),
  //         child: CircleAvatar(
  //           backgroundColor: Colors.grey[100],
  //           child: FlutterLogo(
  //             size: 50.0,
  //           ),
  //           radius: 50.0,
  //         )),
  //   ),
  // );

  Widget get _logo => Hero(
    tag: "logo",
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
  );  

  @override
  Widget build(BuildContext context) {

    void _navigateToSignInRoute() {
      var transition = (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
        return Material(
          child: Stack(children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(0.0, -1.0),
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut
                )),
                child: this,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut
                )),
                child: child,
              )
            ],
          ),
        );
      };

      router.navigateTo(context, signUpRoute,
        replace: true,
        transition: TransitionType.custom,
        transitionDuration: const Duration(milliseconds: 1000),
        transitionBuilder: transition,
      );
    }


    void _onSignInTapUp(TapUpDetails details) {
      var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
          return Stack(children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: this,
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
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: transition,
      );
    }

    Widget _loginAccount(){
      return GestureDetector(
        onTapUp: _onSignInTapUp,
        child: Text(
          "I Already have An Account".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.white
          ),
        )
      );
    } 

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: <Widget>[
              WhitespaceSeparator(height: 15),
              
              _logo,

              WhitespaceSeparator(),

              SlidingFadeIn(
                delay: _delay + 1000,
                child: Text("Hello There", style: headerStyle)
              ),
              SlidingFadeIn(
                delay: _delay + 2000, 
                child: Text("I'm Alfred", style: headerStyle)
              ),

              WhitespaceSeparator(),

              SlidingFadeIn(
                delay: _delay + 3000,
                child: Text("Your New Personal Butler", style: bodyStyle)
              ),
              SlidingFadeIn(
                delay: _delay + 3000, 
                child: Text("For everywhere you go!", style: bodyStyle)
              ),

              WhitespaceSeparator(height: 90),

              SlidingFadeIn(
                delay: _delay + 4000,
                child: SignInButton(
                  onSuccess: _navigateToSignInRoute,
                )
              ),

              WhitespaceSeparator(),

              SlidingFadeIn(
                delay: _delay + 4000,
                child: _loginAccount()
              ),
            ],
          ),
        )
      )
    );
  }
}