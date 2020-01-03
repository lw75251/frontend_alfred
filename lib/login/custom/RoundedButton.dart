import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final VoidCallback onSuccess;

  RoundedButton({
    this.text,
    this.textColor,
    this.onSuccess,
    Key key
  }) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> with SingleTickerProviderStateMixin {

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
    ) ..addListener(() => setState((){}));
    super.initState();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {

    _scale = 1 - _controller.value;
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 40,
          width: _width*8/9,
          decoration: BoxDecoration(
              // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0, offset: Offset(0, 10))],
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.white,
            ),          
          child: Center(
            child: Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                fontSize: 12.0,
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