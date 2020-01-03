import 'dart:async';

import 'package:flutter/material.dart';

class SlidingFadeIn extends StatefulWidget {
  final AxisDirection axis;
  final Widget child;
  final int delay;
  
  SlidingFadeIn({
    this.axis = AxisDirection.up,
    this.delay = 0,
    this.child,
    Key key
  }) : super(key: key);

  @override
  _SlidingFadeInState createState() => _SlidingFadeInState();
}

class _SlidingFadeInState extends State<SlidingFadeIn> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _animOffset;
  Offset _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    if ( widget.axis == AxisDirection.down ) {
      _offset = Offset(0.0, -0.35);
    } else if (widget.axis == AxisDirection.up ) {
      _offset = Offset(0.0, 0.35);
    } else if (widget.axis == AxisDirection.left ) {
      _offset = Offset(-0.35, 0);
    } else {
      _offset = Offset(0.35, 0);
    }

    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset = Tween<Offset>(begin: _offset, end: Offset.zero).animate(curve);


    Timer(Duration(milliseconds: widget.delay), 
      () => _controller.forward()
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}