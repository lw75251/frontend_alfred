import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class CheckoutButton extends StatefulWidget {
  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

typedef AniWidgetBuilder = Widget Function(BuildContext context, dynamic ani);

class _CheckoutButtonState extends State<CheckoutButton> {
  bool _startAnimation = false;
  // bool _firstAnimationFinished = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final duration = const Duration(milliseconds: 400);

    final tween = MultiTrackTween([
      Track("height").add(duration, Tween(begin: 100, end: screenHeight)),
      Track("width").add(duration, Tween(begin: 200, end: screenWidth)),
      Track("opacity").add(duration, Tween(begin: 1.0, end: 0.0)),
      Track("childIndex").add(duration, ConstantTween(0))
    ]);

    return GestureDetector(
      onTap: _clickCart,
      child: ControlledAnimation(
        playback: !_startAnimation ? Playback.PAUSE : Playback.PLAY_FORWARD,
        tween: tween,
        duration: tween.duration,
        animationControllerStatusListener: _listenToAnimationFinished,
      ),
    );
  }

  void _clickCart() {
    setState(() {
      _startAnimation = true;
    });
  }

  void _listenToAnimationFinished(status) {
    if (status == AnimationStatus.completed) {
    }
  }


  final contentChildren = <AniWidgetBuilder>[
  ];

  Widget buildButton(context, ani) {
    return Container(
      height: 50,
      width: ani["width"],
      decoration: boxDecoration(ani["backgroundColor"]),
      child: contentChildren[ani["childIndex"]](context, ani),
    );
  }

  static final AniWidgetBuilder loadButtonLabel = (context, ani) => 
    Center(
      child: Opacity(
        opacity: ani["opacity"],
        child: Text(
          "Load Stuff",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );

  static final AniWidgetBuilder progressIndicator = (context, ani) => Center(
    child: ControlledAnimation(
      playback: Playback.LOOP,
      duration: Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: pi * 2),
      builder: (context, rotation) => Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: ani["opacity"],
              child: Icon(
                Icons.sync,
                color: Colors.green,
              ),
            ),
          ),
    ),
  );

  static final AniWidgetBuilder showSuccess = (context, ani) {
    final tween = MultiTrackTween([
      Track("width")
          .add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 100.0)),
      Track("opacity")
          .add(Duration(milliseconds: 300), ConstantTween(0.0))
          .add(Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0))
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      builder: (context, animation) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.green.shade700,
              ),
              ClipRect(
                child: SizedBox(
                  width: animation["width"],
                  child: Opacity(
                      opacity: animation["opacity"],
                      child: Text(
                        "Success",
                        style: TextStyle(
                            color: Colors.green.shade800, fontSize: 16),
                      )),
                ),
              )
            ],
          ),
    );
  };
  
  BoxDecoration boxDecoration(Color backgroundColor) {
    return BoxDecoration(
      border: Border.all(color: Colors.green, width: 2),
      color: backgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(40),
          blurRadius: 10,
          offset: Offset(0, 5))
      ]);
  }
}
