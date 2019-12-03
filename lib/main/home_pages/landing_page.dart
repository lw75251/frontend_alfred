import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/arrow.dart';
import 'package:flutter_alfred/routes/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key key}) : super(key: key);

  final _color = const Color(0xFF9AA7BF);

  Widget get _appBar => AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: _color,
    leading: IconButton(
      icon: Icon(
        FontAwesomeIcons.userCircle, 
        color: Colors.white,
      ),
      onPressed: (){},
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          FontAwesomeIcons.compass,
          color: Colors.white,
        ),
        onPressed: (){},
      )
    ],
  );

  Widget get _animatedLogo => ControlledAnimation(
    playback: Playback.MIRROR,
    duration: Duration(milliseconds: 1000),
    tween: MultiTrackTween([
      Track("size")
          .add(Duration(milliseconds: 1000), Tween(begin: 120.0, end: 180.0)),
      Track("fontSize")
          .add(Duration(milliseconds: 1000), Tween(begin: 33.33, end: 50.0)),        
    ]),
    curve: Curves.linear,
    builder: (context, animation) {
      return Container(
        width: animation["size"],
        height: animation["size"],
        child: Center(
          child: Text("Alfred",
            style: TextStyle(
              color: _color,
              fontSize: animation["fontSize"]
            )
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(-1.0, -6.0),
              blurRadius: 30.0,
            ),
          ]
        )
      );
    },
  );

  Widget get _instructionArrow => SizedBox(
    height: 220,
    width: 220,
    child: CustomPaint(
      painter: ArrowPainter(),
    ),
  );

  Widget get _joinTableButton => RaisedGradientButton(
    child: Text(
      'Or ask to join a friends table',
      style: TextStyle(color: Colors.white),
    ),
    gradient: LinearGradient(
      colors: <Color>[
        Color(0xFF919fba),
        Color(0XFFb4bccf),
      ],
    ),
    onPressed: (){}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(
        color: _color,
        child: Stack(children: <Widget>[
          Align(
            alignment: const FractionalOffset(.5,.3),
            child: SizedBox(
                height: 200,
                width: 200,
                child: Stack(children: <Widget>[
                  _instructionArrow,
                  Center(
                    child: GestureDetector(
                      child: _animatedLogo,
                      onTapUp: (details){
                        router.navigateTo(context, testRoute, 
                          transitionDuration: const Duration(milliseconds: 200));
                      },
                    )
                  ),
              ])
            ),        
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _joinTableButton
          )
        ]),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0, 
        horizontal: 20
      ),
      child: Container(
        width: width,
        height: 50.0,
        decoration: BoxDecoration(
          gradient: gradient, 
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            )
          ],
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black12)

        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onPressed,
              child: Center(
                child: child,
              )),
        ),
      ),
    );
  }
}