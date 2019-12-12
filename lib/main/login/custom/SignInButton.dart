import 'package:flutter/material.dart';

class SignInButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final VoidCallback onSuccess;

  SignInButton({
    this.text,
    this.textColor,
    this.onSuccess,
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
    ) ..addListener(() => setState((){}))
      ..addStatusListener((status) {
        if ( status == AnimationStatus.completed ) widget.onSuccess();
      })
    
    ;
    super.initState();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {

    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      child: Transform.scale(
        scale: _scale,
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
                color: widget.textColor
              ),
            ),
          )
        ),
      ),
    );
  }
}